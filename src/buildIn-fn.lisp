(in-package :cl-report)

(defun str-to-key (str)
  "Converts a string to a keyword by prepending a colon."
    (read-from-string (str:concat "SQLDF::" str)))

(defun minim (column-name df)
   "Returns the minimum value in the specified column of the DataFrame."
  (let ((key  (str-to-key column-name))) 

  (reduce #'min
	  (remove-na (lisp-stat:select df t key)))))

(defun maxim (column-name df)
  "Returns the maximum value in the specified column of the DataFrame."
  (reduce #'max
          (remove-na (lisp-stat:select df t
		       (str-to-key column-name)))))

(defun mean (column-name df)
  "Calculates the mean (average) value of the specified column in the DataFrame."
  (float (lisp-stat:mean
          (remove-na
	   (lisp-stat:select df t
             (str-to-key column-name))))))

(defun median (column-name df )
  "Calculates the median value of the specified column in the DataFrame."
  (float (lisp-stat:median
	  (remove-na
           (lisp-stat:select df t
             (str-to-key column-name))))))

(defun variance (column-name df)
  "Calculates the variance of the specified column in the DataFrame."
  (float (lisp-stat:variance
	  (remove-na
           (lisp-stat:select df t
             (str-to-key column-name))))))


(defun tabulate (column-name df)
  "Tabulates the occurrences of unique values in the specified column of the DataFrame."
  (lisp-stat:tabulate
   (lisp-stat:select df t
     (str-to-key column-name))))

(defun select-range (column-name df &optional (ini 0) end)
  "Selects values from the specified column in the DataFrame within the specified range [ini, end).
   If 'end' is not provided, it defaults to the end of the column."
  (lisp-stat:select df (lisp-stat:range ini end)
    (str-to-key column-name)))


(defun last-data(column-name df)
  (aref (reverse
	  (remove-na
	   (lisp-stat:select df t
             (str-to-key column-name))))
	0))


(defun get-column-data  (column-name  )
  (coerce (remove-duplicates
	   (lisp-stat:select (get-session-data-frame-value) t
	     (read-from-string (str:concat ":" column-name))))
	  'list))


(defun remove-na (vector)
  (remove-if #'(lambda (x) (and (stringp x) (string= x "NA"))) vector))


(defun hyperscript (s)
  (cond
    ((string= s "content-editable") "on click toggle @contenteditable=true on me then toggle .editable")
    ;;((string= s "data-src") "")
    (t ""))) 	 

