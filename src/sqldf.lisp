;;; -*- Mode: LISP; Base: 10; Syntax: Ansi-Common-Lisp; Package: SQLDF -*-
;;; Copyright (c) 2021-2022 by Symbolics Pte. Ltd. All rights reserved.
(in-package #:cl-report)

(:import-from  :data-frame
		 :keys
		 :df
		:column
	        :alist-df)  

  

;; TODO: handle packages for the keys too

(defun sqldf (sql &optional df)
  "Execute SQL (a string) on a data frame and return a new data frame with the results.
An in-memory SQLite database is created, the contents of the data frame loaded, the query performed, and a new DATA-FRAME returned with the results and the database deleted. In most cases, using this library is faster, from a developer's time perspective, than writing the code to perform the same query. SQLDF has been tested with data frames of 350K rows with no slow-down noted. The R documentation for their version of SQLDF suggests that it could be faster than Lisp native queries. Note that the SQL query must use SQL-style names for columns and not the Lisp versions, e.g., flight-time becomes flight_time."
  (let* ((db (sqlite:connect ":memory:"))
         (words (uiop:split-string sql))
         (table (nth (1+ (position "from" words :test #'string=)) words))
         (df (or df (symbol-value (find-symbol (string-upcase table) *package*))))
         nrows data)

    (unless (and df (typep df 'df:data-frame))
      (error "Could not find data frame ~A" table))

    (create-df-table db table df)
    (write-table db table df)

    ;; There's no good way to get the number of rows in a query in SQLite
    (setf nrows (sqlite:execute-single db (format nil "select count (1) from (~A)" sql)))

    (sqlite::with-prepared-statement stmt (db sql nil)
      (loop while (sqlite:step-statement stmt)
            for i = 0 then (1+ i)
            with column-names = (map 'list
                                     #'(lambda (x)
                                         (from-sql-name x))
                                     (sqlite:statement-column-names stmt))
            for types = (loop for i below (length column-names)
                              collect (statement-column-type stmt i))
            do (if (not data)
                   (setf data (loop
                               for name in column-names
                               for type in types
                               collect (cons (if (find-symbol name (find-package "cl-report"))
                                                 (find-symbol name (find-package "cl-report"))
                                                 (intern (string-upcase name) (find-package "cl-report")))
                                             (alexandria:switch (type :test #'string=)
                                               ("REAL"    (make-array nrows :element-type 'double-float))
                                               ("INTEGER" (make-array nrows :element-type 'integer))
                                               ("TEXT"    (make-array nrows)))))))
            do (loop for j below (length column-names)
                     do (setf (aref (cdr (nth j data)) i) (sqlite:statement-column-value stmt j)))))
    (sqlite:disconnect db)
    (data-frame:alist-df data)))




(defun sqldf-1 (sql)
  "Execute SQL (a string) on a data frame and return a new data frame with the results.
The data frame is identified by the word following FROM (case insensitive) in the SQL string.  An in-memory SQLite database is creaetd, the contents of the data frame loaded, the query performed and a new DATA-FRAME returned with the results and the database deleted.  In most cases, using this library is faster, from a developers time perspective, than writing the code to perform the same query.  SQLDF has been tested with data frames of 350K rows with no slow-down noted.  The R documentation for their version of SQLDF suggests that it could be faster than Lisp native queries.  Note that the SQL query must use SQL style names for columns and not the Lisp versions, e.g. flight-time becomes flight_time."
  (let* ((db    (sqlite:connect ":memory:"))
	 (words (uiop:split-string sql))
	 (table (nth (1+ (position "from" words :test #'string=)) words))
	 (df-name (find-symbol (string-upcase table)))
	 df nrows data)

    (if (not (and (boundp df-name)
		  (typep (symbol-value df-name) 'df:data-frame)))
	(error "Could not find data frame ~A" table)
	(setf df (symbol-value df-name)))

    (create-df-table db table df)
    (write-table     db table df)

    ;; There's no good way to get the number of rows in a query in SQLite
    (setf nrows (sqlite:execute-single db (format nil "select count (1) from (~A)" sql)))

    (sqlite::with-prepared-statement stmt (db sql nil)
      (loop while (sqlite:step-statement stmt)
	    for i = 0 then (1+ i)
	    ;; with column-names = (sqlite:statement-column-names stmt)
	    with column-names = (map 'list
				     #'(lambda (x)
					 (from-sql-name x))
				     (sqlite:statement-column-names stmt))
	    for types = (loop for i below (length column-names)
			      collect (statement-column-type stmt i))

	    ;; Allocate the column memory & types
	    do (if (not data)
		   (setf data (loop
			       for name in column-names
			       for type in types
			       collect (cons (if (find-symbol name) (find-symbol name) (intern (string-upcase name)))
					     (alexandria:switch (type :test #'string=)
					       ("REAL"    (make-array nrows :element-type 'double-float))
					       ("INTEGER" (make-array nrows :element-type 'integer))
					       ("TEXT"    (make-array nrows)))))))

	    ;; Copy the data into the data-frame
	    do (loop for j below (length column-names)
		     do (setf (aref (cdr (nth j data)) i) (sqlite:statement-column-value stmt j)))))
    (sqlite:disconnect db)
    (data-frame:alist-df data)))


;;;
;;; Reading
;;;
(defun read-table (db table)
  "Read TABLE and return a data frame with the contents. Keys are interned in a package with the same name as TABLE."
  (let* ((nrows (sqlite:execute-single db (format nil "select count (*) from ~A" table)))
	 (ncols (sqlite:execute-single db (format nil "select count(*) from pragma_table_info('~A')" table)))
	 (names (execute-to-column db (format nil "select name from pragma_table_info('~A')" table)))
	 (types (execute-to-column db (format nil "select type from pragma_table_info('~A')" table)))
	 (*package* (cond
		      ((find-package (string-upcase table)) (find-package (string-upcase table)))
		      (t (make-package (string-upcase table)))))
	 (columns (loop
		    for name in names
		    for type in types
		    collect (cons (if (find-symbol name) (find-symbol name) (intern (string-upcase name)))
				  (alexandria:switch (type :test #'string=)
				    ("REAL"    (make-array nrows :element-type 'double-float))
				    ("INTEGER" (make-array nrows :element-type 'integer))
				    ("TEXT"    (make-array nrows)))))))

    (sqlite::with-prepared-statement stmt (db (format nil "select * from ~A" table) nil)
      (loop while (sqlite:step-statement stmt)
	    for i = 0 then (1+ i)
	    do (loop for j from 0 below ncols
		     do (setf (aref (cdr (nth j columns)) i) (sqlite:statement-column-value stmt j)))))
    (data-frame:alist-df columns)))


;;;
;;; Writing
;;;

(defun create-df-table (db table df)
  "Create a database table of NAME in DB according to the schema of DF.  This function is to create a table for DF prior to loading.  Lisp style symbol names are converted to SQL compatible names."
  (sqlite:execute-non-query db
			    (let (columns)
			      (map nil
				   #'(lambda (x)
				       (push (to-sql-name (symbol-name x)) columns)
				       (push (sqlite-column-type (column df x)) columns))
				   (keys df))
			      (format nil
				      "create table if not exists ~A (~{~A ~A~^, ~});"
				      table
				      (reverse columns)))))

(defun write-table (db table df)
  "Write data-frame DF to TABLE on connection DB. :na symbols are converted to \"NA\" strings in the database."
  (let (columns col-values)
    (map nil
	 #'(lambda (x)
	     (push (to-sql-name (symbol-name x)) columns))
	 (keys df))
    (map nil
	 #'(lambda (x)
	     (declare (ignore x))
	     (push "?" col-values))
	 (keys df))
    (sqlite:with-transaction db
      (loop
	for i below (aops:nrow df)
	with statement = (sqlite:prepare-statement db
						   (format nil
							   "insert into ~A (~{~A~^, ~}) values (~{~A~^, ~})"
							   table (reverse columns) col-values))
	do (loop
	     for j below (aops:ncol df)
	     do (sqlite:bind-parameter statement (1+ j) (if (eq (select df i j) :na)
							    "NA"
							    (select df i j)))
	     finally (sqlite:step-statement statement)
		     (sqlite:reset-statement statement))

      finally (sqlite:finalize-statement statement)))))


(defun execute-to-column (db sql &rest parameters)
  (declare (dynamic-extent parameters))
  (sqlite::with-prepared-statement stmt (db sql parameters)
    (loop while (sqlite:step-statement stmt)
          collect (sqlite:statement-column-value stmt 0))))

(defun statement-column-type (stmt column-number)
  "Return the type string of a column of a query statement"
  (ecase (sqlite-ffi:sqlite3-column-type (sqlite::handle stmt) column-number)
    (:integer "INTEGER")
    (:float "REAL")
    (:text "TEXT")
    (:blob "BLOB")
    (:null nil)))

;;; to-sql-name and from-sql-name came from postmodern; blame them for warnings and notes
(defparameter *sqlite-reserved-words* nil)
(defparameter *downcase-symbols* nil)
(defparameter *ESCAPE-SQL-NAMES-P* nil)

(defun to-sql-name (name &optional (escape-p *escape-sql-names-p*)
                           (ignore-reserved-words nil))
  "Convert a symbol or string into a name that can be a sql table, column, or
operation name. Add quotes when escape-p is true, or escape-p is :auto and the
name contains reserved words. Quoted or delimited identifiers can be used by
passing :literal as the value of escape-p. If escape-p is :literal, and the
name is a string then the string is still escaped but the symbol or string is
not downcased, regardless of the setting for *downcase-symbols* and the
hyphen and forward slash characters are not replaced with underscores.
Ignore-reserved-words is only used internally for column names which are allowed
to be reserved words, but it is not recommended."
  (declare (optimize (speed 3) (debug 0)))
  (let ((*print-pretty* nil)
        (name (if (and (consp name) (eq (car name) 'quote) (equal (length name)
                                                                  2))
                  (string (cadr name))
                  (string name))))
    (with-output-to-string (*standard-output*)
      (flet ((subseq-downcase (str from to)
               (let ((result (make-string (- to from))))
                 (loop :for i :from from :below to
                       :for p :from 0
                       :do (setf (char result p)
                                 (if (and *downcase-symbols*
                                          (not (eq escape-p :literal)))
                                     (char-downcase (char str i))
                                     (char str i))))
                 result))
             (write-element (str)
               (declare (type string str))
               (let ((escape-p (cond ((and (eq escape-p :auto)
                                           (not ignore-reserved-words))
                                      (gethash str *sqlite-reserved-words*))
                                     (ignore-reserved-words nil)
                                     (t escape-p))))
                 (when escape-p
                   (write-char #\"))
                 (if (and (> (length str) 1) ;; Placeholders like $2
                          (char= (char str 0) #\$)
                          (every #'digit-char-p (the string (subseq str 1))))
                     (princ str)
                     (loop :for ch :of-type character :across str
                           :do (if (or (eq ch #\*)
                                       (alphanumericp ch)
                                       (eq escape-p :literal))
                                   (write-char ch)
                                   (write-char #\_))))
                 (when escape-p
                   (write-char #\")))))

        (loop :for start := 0 :then (1+ dot)
              :for dot := (position #\. name) :then (position #\. name
                                                              :start start)
              :do (write-element (subseq-downcase name start
                                                  (or dot (length name))))
              :if dot :do (princ #\_)
                :else :do (return))))))

(defun from-sql-name (str)
  "Convert a string to a symbol, upcasing and replacing underscores with
hyphens."
  (map 'string (lambda (x) (if (eq x #\_) #\- x))
       (if (eq (readtable-case *readtable*) :upcase)
           (string-upcase str)
           str)))

(defun sqlite-column-type (sequence)
  "Return a format string for the most general type found in sequence
Use this for sequences of type T to determine how to declare the column to SQLite."
  (when (bit-vector-p sequence) (return-from sqlite-column-type "INTEGER"))
  (case (df:column-type sequence)
    (:single-float "REAL")
    (:double-float "REAL")
    (:integer "INTEGER")
    (:bit "INTEGER")
    (:symbol "TEXT")
    (t "TEXT")))

#| Experiment in using POMO's S-SQL
(defun strip-pg-parens (s-sql)
  "Strip the leading and trailing '(' and ')' characters from the output of s-sql:sql.
PostgreSQL doesn't care about these, but SQLite does."
  (subseq s-sql 1 (1- (length s-sql))))
|#
