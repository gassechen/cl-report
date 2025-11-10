(in-package :cl-report)

(defvar *query-test* nil)

(defun make-dataframe (data)
  (let* ((df-name (get-session-data-frame-name))
         (df-object (json-to-df:json-to-df data df-name)))
    
    (lisp-stat:heuristicate-types df-object)
    
    ;; Store the actual dataframe object in the session
    (setf (hunchentoot:session-value 'df-object) df-object)))


(defun get-session-data-frame-value ()
  "Get the dataframe object directly from the session."
  (get-session-data *session* 'df-object))


(defun query-lang (query-string)
  (let ((query (string-downcase (str:collapse-whitespaces query-string))))
    (pushnew query *query-test*)
    (print query)
    (handler-case
        (let ((result (sqldf:sqldf query (get-session-data-frame-value))))
          (if result
              result
              (error "La consulta no devolvió datos válidos.")))
      (error (e)
        (format t "Error ejecutando la consulta SQL: ~a~%" e)
        nil))))

(defun reverse-df (df)
  "Return DF with columns in reverse order"
  (lisp-stat:make-df (reverse (lisp-stat:keys df)) (reverse (lisp-stat:columns df))))

(defun my-parse-date (date-string)
  (local-time:format-timestring nil
                                (local-time:parse-timestring date-string)
                                :format
                                '(:year "-" (:month 2)"-"
                                  (:day 2) " "
                                  (:hour 2) ":"
                                  (:min 2) ":"
                                  (:sec 2))))

;;aux functions

(defun assoc-path (alist path &key (key #'identity) (test #'string=) (default nil))
  "Retrieve the value in the given ALIST represented by the given PATH"
  (or (reduce (lambda (alist k)
                (cdr (assoc k alist :key key :test test)))
              path
              :initial-value alist)
      default))

(defun :hex (value &optional (size 4))
  (format t "~v,'0X" size value))

(defun :bits (value &optional (size 8))
  (format t "~v,'0B" size value))

(defun bit-vector->integer (bit-vector)
  "Create a positive integer from a bit-vector."
  (reduce #'(lambda (first-bit second-bit)
              (+ (* first-bit 2) second-bit))
          bit-vector))

(defun integer->bit-vector (integer)
  "Create a bit-vector from a positive integer."
  (labels ((integer->bit-list (int &optional accum)
             (cond ((> int 0)
                    (multiple-value-bind (i r) (truncate int 2)
                      (integer->bit-list i (push r accum))))
                   ((null accum) (push 0 accum))
                   (t accum))))
    (coerce (integer->bit-list integer) 'bit-vector)))

(defun integer->bit-list (int &optional accum)
  (cond ((> int 0)
         (multiple-value-bind (i r) (truncate int 2)
           (integer->bit-list i (push r accum))))
        ((null accum) (push 0 accum))
        (t accum)))

(defun prune (test tree)
  (labels ((rec (tree acc)
             (cond ((null tree) (nreverse acc))
                   ((consp (car tree))
                    (rec (cdr tree)
                         (cons (rec (car tree) nil) acc)))
                   (t (rec (cdr tree)
                           (if (funcall test (car tree))
                               acc
                               (cons (car tree) acc)))))))
    (rec tree nil)))

(defun filter (fn lst)
  (let ((acc nil))
    (dolist (x lst)
      (let ((val (funcall fn x)))
        (if val (push val acc))))
    (nreverse acc)))

;;session hooks

(defun print-session-slot-values (session)
  "Print the values of various slots in a HUNCHENTOOT:SESSION instance."
  (format t "last-click: ~A~%" (slot-value session 'hunchentoot::last-click))
  (format t "max-time: ~A~%" (slot-value session 'hunchentoot::max-time))
  (format t "remote-addr: ~A~%" (slot-value session 'hunchentoot::remote-addr))
  (format t "session-data: ~A~%" (slot-value session 'hunchentoot::session-data))
  (format t "session-id: ~A~%" (slot-value session 'hunchentoot::session-id))
  (format t "session-start: ~A~%" (slot-value session 'hunchentoot::session-start))
  (format t "session-string: ~A~%" (slot-value session 'hunchentoot::session-string))
  (format t "user-agent: ~A~%" (slot-value session 'hunchentoot::user-agent)))

(defun get-session-data (session key)
  "Get the value associated with KEY in the session-data slot of the SESSION."
  (let ((session-data (slot-value session 'hunchentoot::session-data)))
    (cdr (assoc key session-data))))

(defun get-session-slot-value (session slot-name)
  "Get the value of the slot SLOT-NAME in the SESSION."
  (slot-value session slot-name))

(defun get-session-data-frame-name ()
  "Get the value associated with data-frame in the session-data slot of the SESSION."
  (symbol-name (get-session-data *session* 'cl-report::df-name)))
