(in-package :cl-report)

(defvar *connection* nil)
(defparameter *server* nil
  "Server instance (Hunchentoot acceptor).")
(defparameter *csp-header*  "frame-ancestors 'self'; form-action 'self'")

(defparameter *port* 8000
  "We can override it in the config file or from an environment variable.")

(defvar *static-files-directory* "/static/")

(defparameter *my-session-secret* "my-custom-secret")


;;
;; Start the web server.
;;
(defun start-swank-server (&optional (port 4005))
  (swank:create-server :port port :dont-close t)
  (format t "Swank server started on port ~A~%" port))


(defun main (&optional (port 8000) (swank-port 4005))
  (start-server :port port)
  (start-swank-server swank-port)
  (sb-thread:join-thread
   (find-if (lambda (th)
              (search "hunchentoot-listener" (sb-thread:thread-name th)))
            (sb-thread:list-all-threads))))



;;(defun main (&optional (port 8000))
;;  (start-server :port port)
;;  (sb-thread:join-thread
;;   (find-if (lambda (th)
;;              (search "hunchentoot-listener" (sb-thread:thread-name th)))
;;            (sb-thread:list-all-threads))))


(defun start-server (&key (port *port*))
  (format t "~&Starting the web server on port ~a" port)
  (force-output)
  (setf *connection* (connect-db))
  (mito:ensure-table-exists 'project)

  (setf *server* (make-instance 'easy-routes:easy-routes-acceptor
                                :port (or port *port*)))
  (push (hunchentoot:create-folder-dispatcher-and-handler
       "/static/" (merge-pathnames "src/static/"  ;; starts without a /
                                   (asdf:system-source-directory :cl-report)))
	hunchentoot:*dispatch-table*)

  (setf *session-secret* *my-session-secret*)
  (hunchentoot:start *server*))

(defun stop-server ()
  (hunchentoot:stop *server*))



