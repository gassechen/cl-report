;;(defparameter *csp-header*  "default-src 'self'; script-src 'self'; style-src 'self'; img-src 'self'; object-src 'none'; frame-ancestors 'self'; form-action 'self'")
(in-package :cl-report)

(defparameter *server* nil
  "Server instance (Hunchentoot acceptor).")
(defparameter *csp-header*  "frame-ancestors 'self'; form-action 'self'")

(defparameter *port* 8000
  "We can override it in the config file or from an environment variable.")

(defvar *static-files-directory* "/static/")

(defvar *connection*)



;; (defun main (&optional (port 8000))
;;   (handler-case
;;       (progn
;;         (format t "Starting server on port ~A~%" port)
;;         (start-server :port port)

;;         ;; Captura la señal de Ctrl+C y sale limpiamente
;;         (sb-sys:signal-handler
;;          sb-sys:sigint
;;          (lambda (signal)
;;            (format t "~&Interrupción detectada. Apagando servidor...~%")
;;            (stop-server)
;;            (sb-ext:quit :unix-status 0)))

;;         ;; Espera a que el hilo del servidor termine
;;         (sb-thread:join-thread
;;          (find-if (lambda (th)
;;                     (search "hunchentoot-listener" (sb-thread:thread-name th)))
;;                   (sb-thread:list-all-threads))))

;;     ;; Manejador de errores
;;     (error (e)
;;       (format t "Se ha producido un error: ~A~%" e)
;;       (stop-server)  ;; Detener el servidor en caso de error
;;       (sb-ext:quit :unix-status 1))
    
;;     ;; Manejador de salida limpia al cerrar con Ctrl+C
;;     (:no-error ()
;;       (stop-server)  ;; Detener el servidor si todo sale bien
;;       (sb-ext:quit :unix-status 0))))




(defun main (&optional (port 8000) (swank-port 4005))
  (unwind-protect
    	 (start-server :port port)
	 (start-swank-server swank-port)
         (sb-thread:join-thread
          (find-if (lambda (th)
                     (search "hunchentoot-listener" (sb-thread:thread-name th)))
                   (sb-thread:list-all-threads)))))
    



;;
;; Start the web server.
;;



;; (defun main (argv)
;;   (start-web-server 8000)
;;   (connect-db)
;;   (sb-thread:join-thread (find-if
;;                           (lambda (th)
;;                             (search "hunchentoot-listener" (sb-thread:thread-name th)))
;;                           (sb-thread:list-all-threads))))

(defun start-swank-server (&optional (port 4005))
  (swank:create-server :port port :dont-close t)
  (format t "Swank server started on port ~A~%" port))


(defun start-server (&key (port *port*))
  (format t "~&Starting the web server on port ~a" port)
  (force-output)
  
  (setf *server* (make-instance 'easy-routes:easy-routes-acceptor
                                :port (or port *port*)))
  (push (hunchentoot:create-folder-dispatcher-and-handler
       "/static/" (merge-pathnames "src/static/"  ;; starts without a /
                                   (asdf:system-source-directory :report-builder)))
	hunchentoot:*dispatch-table*)
  
  (hunchentoot:start *server*))

(defun stop-server ()
  (hunchentoot:stop *server*))



