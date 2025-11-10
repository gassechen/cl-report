(in-package :cl-report)

(defparameter *csp-header* "frame-ancestors 'self'; form-action 'self'; script-src https://mtkb2c.b2clogin.com/mtkb2c.onmicrosoft.com")
(defparameter *charset* "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")

(defvar *acceptor* nil)
(defvar *my-session* nil)
(defvar *my-session-secret* nil)
(setf hunchentoot:*session-max-time* 36000)
(setf *session-secret* *my-session-secret*)

(easy-routes:defroute main-route ("/" :method (:get :post)) ()
  (let ((html (page-main)))
    (setf (hunchentoot:content-type*) "text/html")
    (setf (hunchentoot:header-out "Content-Security-Policy") *csp-header*)
    (setf (hunchentoot:header-out "X-Frame-Options") "DENY")
    (setf (hunchentoot:header-out "X-Content-Type-Options") "nosniff")
    (setf (hunchentoot:session-value 'project-name) "")
    (setf (hunchentoot:session-value 'df-name) 'df2)
    (setf (hunchentoot:session-value 'user-name) "ppx")
    (setf *my-session* (hunchentoot:start-session))
    (print *my-session*)
    (hunchentoot:start-session)
    (format nil "~a" html)))


(easy-routes:defroute test ("/test" :method :post)()
  (setf (hunchentoot:content-type*) "text/html")
  (let ((html (hunchentoot:post-parameters*)))
    (format nil "~a "  html)))

(easy-routes:defroute main-new ("/new" :method :get) ()
  (let ((html (page-new)))
    (setf (hunchentoot:content-type*) "text/html")
    (setf (hunchentoot:header-out "Content-Security-Policy") *csp-header*)
    (setf (hunchentoot:header-out "X-Frame-Options") "DENY")
    (setf (hunchentoot:header-out "X-Content-Type-Options") "nosniff")
    (format nil "~a" html)))


(easy-routes:defroute make-preview ("/make-preview" :method :post) ()
  (setf (hunchentoot:content-type*) "text/html")
  (let ((html (hunchentoot:post-parameters*)))
   (build-preview-page)))


;; ver aca la generacion del symbol
(easy-routes:defroute make-new-report-post ("/make-new-report-post" :method :post) ()
  (setf (hunchentoot:content-type*) "text/html")
  
  (let ((html (hunchentoot:post-parameter "fname" )))
    (setf (hunchentoot:session-value 'project-name) (str:snake-case html))
    (setf (hunchentoot:session-value 'df-name) (intern (str:upcase (concatenate 'string "DF_" (random-string))) :cl-report ))
    (create-project 
     (hunchentoot:session-value 'user-name)
     (hunchentoot:session-value 'project-name)
     "" )
    (make-form-data-src)))


(easy-routes:defroute process-url-src ("/process-url-src" :method :post)()
  (setf (hunchentoot:content-type*) "text/html")
  (let ((html (hunchentoot:post-parameters*)))
    ;;(windows "From Url Data Source" (produce-url-data-src-form html))))
    (produce-url-data-src-form html)))

;; (easy-routes:defroute making-report-route ("/making-report" :method :post) ()
;;   (setf (hunchentoot:content-type*) "text/html")
;;   (let ((html (hunchentoot:post-parameters*)))
;;     (making-report html)))
    
(easy-routes:defroute make-form-src-report ("/make-from-src-report" :method :post)()
  (setf (hunchentoot:content-type*) "text/html")
  (let ((html (hunchentoot:post-parameters*)))
    (windows "Form To Report" (make-form-for-report(agrupar-valores html)))))
    


(easy-routes:defroute get-data-from-url-src ("/get-data-from-url-src" :method :post)()
  (setf (hunchentoot:content-type*) "text/html")
  (setf (hunchentoot:header-out "hx-trigger") "my-custom-event")
  (let* ((html (hunchentoot:post-parameters*))
	 (data (make-fn-get-events-from-api html)))
    (make-dataframe data)
    (notification :style "success" :text "Successfully uploaded data")))


(easy-routes:defroute table-data ("/widgets/:x" :method :get)()
  (setf (hunchentoot:content-type*) "text/html")
  (let ((html (hunchentoot:post-parameters*)))
    (format nil "~a "  (print-html-table (get-session-data *session* 'cl-report::df-name) :row-numbers t))))


(easy-routes:defroute widget-refresh ("/widget-refresh/:x") ()
  (cond ((string= x "table-data") (page-data-frame))
	((string= x "linear-gauge") (make-linear-gauge))
	((string= x "boolean-state") (windows "BST" (boolean-state "BST" 1 ) ))
	((string= x "table-data-nova") (windows "Table Data" (page-data-frame) ))))


(easy-routes:defroute data-frame-describe-object ("/data-frame-describe-object" :method :get)()
  (setf (hunchentoot:content-type*) "text/html")
  (let ((html (hunchentoot:get-parameters*)))
    (windows "Data Frame Data types" (page-describe-object))))


(easy-routes:defroute edit-row-data-types ("/edit-row-data-type" :method :post)()
  (setf (hunchentoot:content-type*) "text/html")
  (let ((html (hunchentoot:post-parameters*)))
    (format nil "~a" html))) 


(easy-routes:defroute test-data-frame ("/test-data-frame" :method :post)()
  (setf (hunchentoot:content-type*) "text/html")
  (let ((html (hunchentoot:post-parameters*)))
        (format nil "~a "  (print-html-query (query-lang (cdr (car html))) :row-numbers t))))

(easy-routes:defroute query-test ("/query-test" :method :get)()
  (setf (hunchentoot:content-type*) "text/html")
  (let ((html (hunchentoot:get-parameters*)))
    (format nil "~a " (query-test-list))))

(easy-routes:defroute report-query-widget ("/report-query-widget" :method :post)()
  (setf (hunchentoot:content-type*) "text/html")
  (let ((html (hunchentoot:post-parameters*)))
    (format nil "~a " html)))


(easy-routes:defroute menu-links ("/menu-links/:x") ()
  (cond ((string= x "new-report") (make-new-report) )
	((string= x "data-src") (windows "Data Source"  (make-form-data-src) ))
	((string= x "linear-gauge") (windows  "Linear Gauge" (make-linear-gauge )))
	((string= x "radial-gauge") (windows  "Radial Gauge" (make-radial-gauge )))
	((string= x "message-num-widget") (windows  "Msg Num Box" (make-message-num-widget )))
	((string= x "message-list-widget") (windows  "Msg Txt Box" (make-message-list-widget )))
	((string= x "make-table-widget") (windows  "Table" (make-table-widget )))
	
	((string= x "make-chart-line-widget") (windows  "Chart Line" (make-chart-line-widget)))
	((string= x "make-chart-pie-widget") (windows  "Chart Pie" (make-chart-pie-widget )))
	((string= x "make-map-widget") (windows  "Map" (make-map-widget)))

	((string= x "make-tab-widget") (windows  "Tab" (make-tab-widget)))
	((string= x "make-editor-widget") (windows  "Editor" (make-editor-widget)))
	((string= x "make-bwsch-widget") (windows  "cl" (make-cl-widget)))
	
	((string= x "make-galery-images-widget") (windows  "Image Gallery " (make-galery-images-widget)))
	((string= x "make-galery-video-widget") (windows  "Video Gallery" (make-galery-video-widget)))
	
	((string= x "table-data") (windows  "Table Data" (page-data-frame)))))




(easy-routes:defroute project-list-reports ("/project-list-reports" :method :get) ()
  (list-reports))


(easy-routes:defroute project-links ("/project-links/:x" :method :post) ()
(setf (hunchentoot:session-value 'df-name) (intern (str:upcase (concatenate 'string "DF_" (random-string))) :cl-report ))
  (hunchentoot:start-session)
  (build-project-page x))



(easy-routes:defroute project-links-delete ("/project-links-delete/:x" :method :post) ()
  (delete-project x)
  (list-reports ))


(easy-routes:defroute report-links ("/report-links/:x" :method :get) ()
  (setf (hunchentoot:session-value 'project-name) (get-project-name x))
  (setf (hunchentoot:session-value 'df-name) (intern (str:upcase (concatenate 'string "DF_" (random-string))) :cl-report ))
  (hunchentoot:start-session)
  (build-report-page x))



(easy-routes:defroute save-test ("/save-test" :method :post)()
  (setf (hunchentoot:content-type*) "text/html")
  (let* ((raw-data (hunchentoot:raw-post-data))
	 (html (flexi-streams:octets-to-string raw-data :external-format :utf-8)))
    (save html)))


(defun save (html)
  (let ((project-code  html)
	(id-project (get-project-id
		     (hunchentoot:session-value 'user-name)
		     (hunchentoot:session-value 'project-name))))
    (update-project id-project  project-code)))


