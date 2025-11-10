(in-package :cl-report)

;;;;;;;;;;DB;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar *db* nil)
(defvar *query-test* nil)

(defun dump-db ()
  (format t "~{~{~a:~10t~a~%~}~%~}" *db*))


(defun save-db (filename)
  (with-open-file (out filename
                       :direction :output
                       :if-exists :supersede)
    (with-standard-io-syntax
      (print *db* out))))


(defun load-db (filename)
  (with-open-file (in filename)
    (with-standard-io-syntax
      (setf *db* (read in)))))

(defun print-result (data)
  (format t "~{~{~a:~10t~a~%~}~%~}" data))


(defun select (selector-fn)
  (remove-if-not selector-fn *db*))

(defun make-comparison-expr (field value)
  `(equal (getf cd ,field) ,value))

(defun make-comparisons-list (fields)
  (loop while fields
	collecting (make-comparison-expr (pop fields) (pop fields))))


(defun make-comparison-expr* (field value)
  (if (string= value "*")
      `(not (null (getf cd ,field)))
      `(equal (getf cd ,field) ,value)))


(defmacro where (&rest clauses)
  `#'(lambda (cd) (and ,@(make-comparisons-list clauses))))

(defun select-column-values (key alist)
  (mapcar (lambda (pair)
            (getf pair key))
          alist))


(defun extract-keys-columns (data)
  (let ((flat-data (alexandria:flatten data)))
    (remove-duplicates(remove-if-not #'symbolp flat-data))))



(defun make-data-frame (key-list values)
  (let ((na-value :na))  ; Definir el valor de reemplazo para NIL
    (reverse-df(lisp-stat:make-df key-list
				  (mapcar (lambda (key)
					    (let ((column-values (select-column-values key values)))
					      ;; Reemplazar NIL por :na en la lista de valores
					      (setq column-values (mapcar (lambda (value)
									    (if (null value) na-value value))
									  column-values))
					      (coerce column-values 'vector)))
					  key-list)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; aca voy

;;;inicializar dataframe
;; desde archivo response 1
(defun  parse-json-1-file()
  (with-open-file (json-stream "~/projects/CL/lisp-web-template-productlist/src/data/csv_informe/respuesta1.json" :direction :input)
    (let ((lisp-data (yason:parse json-stream )))
      lisp-data )))

(defun  parse-json-4-file()
  (with-open-file (json-stream "~/projects/CL/lisp-web-template-productlist/src/data/csv_informe/respuesta4.json" :direction :input)
    (let* ((yason:*parse-json-arrays-as-vectors* t)
           (yason:*parse-json-booleans-as-symbols* t)
	   ;;(yason:*parse-object-as*   :vector)
           (result (yason:parse json-stream)))
      result)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar *data* nil)
(defvar *data-frame* nil)
(defparameter *count* 0)

;;devuelve alist
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun process-hash-table (hash-table &optional key-prefix tmp-list)
  
  (maphash (lambda (key value)
             (let ((full-key
                     (if key-prefix (concatenate 'string key-prefix "_" key) key)))
               (if (typep value 'hash-table)
		   
		   (setf tmp-list (process-hash-table value full-key tmp-list)))
	       
	       (progn
		 (when (typep value 'list)
		   (let ((counter-value 0))
		     (dolist (l value)
		       
		       (push  l tmp-list)
		       (push (alexandria:make-keyword
			      (string-upcase
			       (concatenate 'string full-key "_"
					    (write-to-string (incf counter-value)))))
			     tmp-list))))
		 (unless (or
			  (typep value 'hash-table)
			  (typep value 'list))
		   (push value tmp-list)
                   (push (alexandria:make-keyword
			  (string-upcase full-key))
			 tmp-list)
                   ))))
	   
           hash-table)
  tmp-list)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun get-hash-table-list (key)
  (let ((hash-table (gethash key *data*)))
    (cdr hash-table)))

(defun process-hash-table-list (hash-table-list)
  (let ((tmp-list '()))
    (dolist (hash-table hash-table-list)
      (setq *db*
	    (append *db*
		    (list (process-hash-table hash-table tmp-list)))))))


(defun get-keys-as-list (hash-table)
  (let ((keys '()))
    (maphash (lambda (key value)
	       (push key keys))
             hash-table)
    keys))

(defun make-dataframe (data)
  (when (lisp-stat:boundp 'df2) (lisp-stat:undef df2))
  (setf *data* data)

  (setf *db* 'nil)
  (let* ((keys-list (get-keys-as-list *data*)))
    (dolist (key keys-list)
      (let* ((hash-table-list (get-hash-table-list key)))
        (process-hash-table-list hash-table-list)))
    
    (dump-db)
    (lisp-stat:defdf df2
	
        (make-data-frame (extract-keys-columns *db*) *db*))
    (lisp-stat:heuristicate-types df2)))



(defun query-lang (query-string )
  (let ((query (string-downcase (str:collapse-whitespaces query-string ))))
    (pushnew  query *query-test*)
    (remove-duplicates *query-test* :test #'string=)
    (sqldf:sqldf  query)))


(defun query-lang (query-string )
  (let ((query (string-downcase (str:collapse-whitespaces query-string ))))
    (pushnew  query *query-test*)
    (setf *query-test* (remove-duplicates *query-test* :test #'string=))
    (sqldf:sqldf  query)))





(defun print-html-table (df &key (row-numbers nil))
  "Print data frame DF as an HTML table with Spinneret, to STREAM.
   If ROW-NUMBERS is true, also include row numbers."
  (spinneret:with-html-string
    (let* ((array (aops:as-array df)))
      ;; Print opening <table> tag
      (:div :id "query-result" 
	    (:table :id "table-data" :class "uk-table uk-table-responsive uk-table-striped uk-table-divider uk-table-small"
		    

		    ;; Print header row
		    (:tr 
		     (when row-numbers (:th "#" ))
		     (map nil #'(lambda (x)
				  (:th x ))
			  (data-frame:keys df)))

		    ;; Print data rows
		    (aops:each-index i
		      (:tr
		       (when row-numbers (:td i ))
		       (aops:each-index j
			 (:td (aref array i j) )))))))))


(defun print-html-query (df &key (row-numbers nil))
  "Print data frame DF as an HTML table with Spinneret, to STREAM.
   If ROW-NUMBERS is true, also include row numbers."
  (spinneret:with-html-string
    (let* ((array (aops:as-array df)))
      ;; Print opening <table> tag
      
      (:div :id "query-result" :class "uk-overflow-auto"
	    (:table :id "table-data" :class "uk-table uk-table-striped"
		    ;; Print header row
		    (:tr :class "w3-blue-grey"
			 (when row-numbers (:th "#" ))
			 (map nil #'(lambda (x)
				      (:th x ))
			      (data-frame:keys df)))

		    ;; Print data rows
		    (aops:each-index i
		      (:tr
		       (when row-numbers (:td i ))
		       (aops:each-index j
			 (:td (aref array i j) )))))))))


(defun describe-object-html (df )
  (let ((name  (lisp-stat:name df))
        (rows (list '("Variable" "Type" "Unit" "Label"))))
    (when name
      (loop for key across (lisp-stat:keys df)
            for sym = (find-symbol (string-upcase (symbol-name key)) (find-package name))
            do (push (list (symbol-name key)
                           (get sym :type)
                           (get sym :unit)
                           (get sym :label))
                     rows)))
    (let ((rows (reverse rows)))
      (spinneret:with-html
	(:input :name "SSSS" :value "DDDDD" :data-hx-post "/edit-row-data-type" )
	(:button  :data-hx-trigger "click" "Edit")
	
	(:div :class "w3-row w3-border"
	      (:div :class "w3-container"
		    (:h2 "Data Frame Description")
		    (:div :id "div-data-types" :style "overflow-x:auto;"
			  (:table :id "table-data-types" :class "w3-table-all"
				  (:tr :class "w3-blue-grey"
				       (mapcar (lambda (header)
						 (:th header))
					       (car rows))
				       (:th "edit"))
				  
				  (loop for row in (cdr rows)
					do (:tr :class "w3-white"
						(loop for cell in row
						      do (:td (:input :name cell :value cell :data-hx-post "/edit-row-data-type" )))
						(:td (:button  :data-hx-trigger "click" "Edit" ))))))))))))





(defun form-change-data-types(rows)
  (spinneret:with-html
    (:div :class "w3-container w3-half"
	  (:h2 "Change data types")
	  (:form :id "report-form-src" :class "w3-container"
		 :data-hx-post "/get-data-from-url-src"
		 :data-hx-swap "beforeend"
  		 :data-hx-target "#windows-content"
		 (:div :class "w3-container  w3-cell"
		       (:label :class "w3-text-blue" (:b "dddd"))
		       (:select :class "w3-select w3-border"
			 :id "html-method"
			 :name 
			 (:option  (mapcar (lambda (header)
					     (::value header))
					   (car rows))))
                       
                       (:br))
                 (:button :class "w3-button w3-black" "SEND")))))



(defun head-html (df  &optional (to 6) (from 0))
  "Return the first N rows of DF; N defaults to 6"
  (if (< (aops:nrow df) 6)
      (setf to (aops:nrow df)))
  (print-html-table
   (lisp-stat:select df (lisp-stat:range from to) t) :row-numbers t))



(defun reverse-df (df)
  "Return DF with columns in reverse order"
  (lisp-stat:make-df (reverse (lisp-stat:keys df)) (reverse (lisp-stat:columns df))))
