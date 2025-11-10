(in-package :cl-report)

(defvar *query-test* nil)

;;;;;;;;SELECT FILTERS ;;;;;;;;;;;;;;;;
(defun generate-select-keys(&optional (name "select-keys") (num "") (sub-name ""))
  "Generates an HTML select element for selecting column keys from the DataFrame."
  (spinneret:with-html
    (:select :class "uk-select" :id "select-keys"
      :name (str:concat name sub-name)
      :data-hx-get "/models"
      :data-hx-target (str:concat "#models" num)
      :data-hx-swap "innerHTML"
      :data-hx-sync "closest form:queue first"
      (:option :value "Select" "Select" )
      (dolist (input-type (coerce (lisp-stat:keys (get-session-data-frame-value)) 'list))
        (:option :value input-type input-type )))))


(easy-routes:defroute /models ("/models" :method :get )()
  (setf (hunchentoot:content-type*) "text/html")
  (let* ((html (hunchentoot:get-parameters*)))
     (generate-filter-column-data (assoc-path html '("eje-y-filter")))))


(defun generate-checkboxes-keys()
  "Generates HTML checkboxes for selecting column keys from the DataFrame in a grid layout."
  (spinneret:with-html
    (:label :class "uk-form-label" (:b "Column Data Src "))
    (:div :class "uk-grid-small uk-grid-divider uk-grid-stack" :data-uk-grid ""
      (dolist (input-type (coerce (lisp-stat:keys (get-session-data-frame-value)) 'list))
        (:div
          (:label :class "uk-form-label"
            (:input :class "uk-checkbox" :type "checkbox" :name "select-keys" :value input-type)
            input-type))))))


(defun generate-select-buildIn-filters()
  "Generates an HTML select element for selecting built-in filters."
  (let ((input-data-types '("DLAST" "DMIN" "DMAX" "DAVERAGE" "DMEDIAN" "DVAR" )))
    (spinneret:with-html
      (:label :class "uk-form-label" (:b "Build In  "))
      (:select :class "uk-select" :id "filter" :name "filter" 
        ;;(:option :value "Select" "Select")
        (dolist (input-type input-data-types)
          (:option :value input-type input-type)))
      (:hr))))

(defun select-query-sql()
  "Generates an HTML select element for selecting SQL queries."
  (spinneret:with-html
    (:label :class "uk-form-label" (:b "Sql Querys"))
    (:select :class "uk-select" :id "sql-querys" :name "sql-querys"
      (dolist (input-type *query-test*)
        (:option :value input-type input-type)))))


(defun filters-acction ()
  "Generates an HTML form with selectors for column keys, built-in filters, and SQL queries."
  (spinneret:with-html
    ;;(generate-select-keys)
    (generate-select-buildIn-filters)
    (select-query-sql)))


(defun material-icons-select ()
  "Generates an HTML select element with Material Icons as options."
  (spinneret:with-html
    (let ((icon-names *material-icons*))
      (:select :class "material-icons-select" :id "icon-name" :name "icon-name"
        (loop for icon-name in icon-names
              :collect
              (:option :value icon-name 
                       (:i :class (str:concat "material-icons") icon-name)))))))


(defun generate-axis-type-data (name)
  (let ((input-data-types '("quantitative" "temporal" "nominal" "ordinal" "geojson")))
    (spinneret:with-html
      (:select :class "uk-select" :id "html-input-type" :name name
               (dolist (input-type input-data-types)
                 (:option :value input-type input-type))))))


(defun generate-filter-column-data (name)
  (when name
  (let ((input-data-types (get-column-data name)))
    (spinneret:with-html-string
      (:select :class "uk-select" :id "html-input-type" :name name
	 ;;(:option :value "Select" "Select")
               (dolist (input-type input-data-types)
                 (:option :value input-type input-type)))))))


(defun filter-data-cell (html )

  (let* ((eje-x (assoc-path html '("eje-x")))
	 (eje-y (assoc-path html '("eje-y")))
	 (eje-y-filter (assoc-path html '("eje-y-filter")))
	 (cell-filter (assoc-path html `(,eje-y-filter))))
    
	 (if (string= "Select" eje-y-filter)
	     (str:concat "select " eje-x","eje-y " from " (lisp-stat:name (get-session-data-frame-value)))
	     (str:concat "select " eje-x","eje-y " from "(lisp-stat:name (get-session-data-frame-value)) " where "eje-y-filter"= " cell-filter))))


(defun filter-data-cell-box (html )
  (let* ((eje-y (assoc-path html '("eje-y")))
	 (eje-y-filter (assoc-path html '("eje-y-filter")))
	 (cell-filter (assoc-path html `(,eje-y-filter))))
	 (if (string= "Select" eje-y-filter)
	     (str:concat "select " eje-y " from " (lisp-stat:name (get-session-data-frame-value)))
	     (str:concat "select " eje-y " from " (lisp-stat:name (get-session-data-frame-value)) " where "eje-y-filter"= " cell-filter))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;HANDE CASE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun safe-query (query html)
  (handler-case
      (let ((data (query-lang query)))
        (get-value-from-keys (assoc-path html '("filter"))
                             (assoc-path html '("eje-y"))
                             data))
    (error (e)
      (format t "Error al ejecutar la consulta: ~a~%" e)
      "error")))

  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun get-value-from-keys (filter select-keys df)
  "Gets the statistical value based on the selected filter and column keys."
  (cond ((string= filter "DMIN") (minim select-keys df))
        ((string= filter "DMAX") (maxim select-keys df))
        ((string= filter "DAVERAGE") (mean select-keys df))
        ((string= filter "DMEDIAN") (median select-keys df))
	((string= filter "DVAR")  (variance select-keys df))
	((string= filter "DLAST") (last-data select-keys df )))) 


;;AUX FUNCTIONS DATA CONDITIONING
(defun split (list count)
  "Splits a list into two parts: the first part containing 'count' elements, and the second part with the remaining elements."
  (if (> (length list) count)
      (values (subseq list 0 count) (nthcdr count list))
    list))

(defun generate-escale-range (from to step)
  "Generates a list of numbers in the specified range with a given step."
  (loop for num from from to to by (abs step)
        collect (format nil "~a" (truncate num))))

(defun join-with-commas (list)
  "Joins the elements of a list into a string, separated by commas."
  (format nil "~{~a~^, ~}" list))


(defun modal-window (&optional num fn )
  (spinneret:with-html
    (:div :id (str:concat "modal-container" num)  :data-uk-modal ""
          (:div :class "uk-modal-dialog uk-modal-body"
		(:button :class "uk-modal-close-default" :type "button" :data-uk-close "")
		(if (functionp fn)
                    (funcall fn num)
                    "Error: 'fn' no es una función válida.")))))
		



;;;;;;; LINEAR GAUGE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-linear-gauge ()
  (let ((num (write-to-string (+ (funcall *win-num*) 1))))
    (spinneret:with-html-string
      (:div :class "uk-card-body" 
	    (:div :id (str:concat "linear-gauge-place" num)
		  (:label :class "uk-align-center"
			  (:i :class "fas fa-thermometer-half" :style "font-size:120px;"))))
      (:span :class "eye-icon" :onclick (str:concat "toggleHeader("num")")
	     (:i :class "fa fa-eye" :style "font-size:10px"))
      (:footer :class "uk-card-footer"
	       (modal-window num #'linear-gauge-form)))))	

  
(defun linear-gauge-form (num)
  (spinneret:with-html
    (:form :class "uk-form-stacked" :id "canvasConfigForm"
	   :data-hx-post "/draw-linear-gauge"
	   :data-hx-swap "innerHTML"
  	   :data-hx-target (str:concat "#linear-gauge-place"num)
	   :data-hx-trigger "click,my-custom-event from:body, submit delay:1s"
	   (:label "Data Column")
	   (generate-select-keys "eje-y" num)
	   (:label "Aggregate Functions")
	   (generate-select-buildIn-filters)
	   (:label " Column Filter data ")
	   (generate-select-keys "eje-y-filter" num)
	   (:label " Column Filter aplly ")
	   (:div :id (str:concat "models" num))
           (:hr)
	   
	   (:label :class "uk-form-label" :for "canvasWidth" "Ancho:")
	   (:input :class "uk-input"
		   :type "number"
		   :name "canvasWidth"
		   :id "canvasWidth"
		   :value "160"
		   :min "10"
		   :max "600"
		   :step "10")
	   
	   (:label :class "uk-form-label" :for "canvasHeight" "Alto:")
	   (:input :class "uk-input"
		   :type "number"
		   :name "canvasHeight"
		   :id "canvasHeight"
		   :value "300" :min "10"
		   :max "900"
		   :step "10")
	   
	   (:label :class "uk-form-label" :for "canvasValue" "Valor:")
	   (:input :class "uk-input"
		   :type "number"
		   :name "canvasValue"
		   :id "canvasValue"
		   :value "99")
	   
	   (:label :class "uk-form-label" :for "canvasTitle" "Título:")
	   (:input :class "uk-input"
		   :type "text"
		   :name "canvasTitle"
		   :id "canvasTitle"
		   :value "Temperature")
	   
	   (:label :class "uk-form-label" :for "canvasUnits" "Unidades:")
	   (:input :class "uk-input"
		   :type "text"
		   :name "canvasUnits"
		   :id "canvasUnits"
		   :value "°C")
	   
	   (:label :class "uk-form-label" :for "canvasMinorTicks" "Marcas Menores:")
	   (:input :class "uk-input"
		   :type "number"
		   :name "canvasMinorTicks"
		   :id "canvasMinorTicks"
		   :value "10")
	    (:hr)
	      	   (:button :class "uk-button uk-button-default" "send"))))



(easy-routes:defroute /draw-linear-gauge ("/draw-linear-gauge" :method :post )()
  (setf (hunchentoot:content-type*) "text/html")
  (let* ((html (hunchentoot:post-parameters*)))
    (gauge-linear html)))
    

(defun gauge-linear (html)
	 (let* ((query (filter-data-cell-box html))
		(data (query-lang query))
		(value (if data
			   (get-value-from-keys (assoc-path html '("filter")) (assoc-path html '("eje-y")) data) nil))
		
		(data-min-value (if (and value (not (zerop value)))
				    (truncate (/ value 2.0))
				    0.0))

		(data-max-value (if (and value (not (zerop value)))
				    (* 1.3 value)
				    100))

		
		(data-major-ticks (join-with-commas
				   (generate-escale-range
				    (* data-min-value 1.0)
				    (* data-max-value 1.0)
				    (/  data-max-value 10)))))
	   

	   (if value
	       (spinneret:with-html-string
		 (:canvas  :data-type "linear-gauge" 
			   :data-width (assoc-path html '("canvasWidth"))
			   :data-height (assoc-path html'("canvasHeight"))
			   :data-border-radius "20"
			   :data-borders "1"
			   :data-bar-begin-circle "false"
			   :data-title (assoc-path html'("canvasTitle"))
			   :data-units (assoc-path html'("canvasUnits"))
			   :data-color-units "#f00"
			   :data-title "false"
			   :data-value (write-to-string value) 
			   :data-min-value data-min-value
			   :data-max-value data-max-value 
			   :data-exact-ticks "false"
			   :data-major-ticks data-major-ticks
			   :data-highlights "0"
			   :data-tick-side "right"
			   :data-number-side "right"
			   :data-needle-side "right"
			   ;;:data-animation-rule "bounce"
			   ;;:data-animation-duration "750"
			   :data-bar-stroke-width "1"
			   :data-value-box-border-radius "0"
			   :data-use-Min-Path "false"
			   :data-value-text-shadow "false"))
	       (format nil "No data selected"))))


;;;;;;;;;;;;;;;;;;;;;;;;RADIAL-GAUGE-WIDGET;;;;;;;;;;;;;;;;;;;;;;;

(defun make-radial-gauge ()
  (let ((num (write-to-string (+ (funcall *win-num*) 1))))
    (spinneret:with-html-string
      (:div :class "uk-card-body" 
	    (:div :id (str:concat "radial-gauge-place" num)
		  (:label :class "uk-align-center"
			  (:i :class "far fa-clock" :style "font-size:120px;"))))
      
      (:span :class "eye-icon" :onclick (str:concat "toggleHeader("num")")
	     (:i :class "fa fa-eye" :style "font-size:10px"))

      (:footer :class "uk-card-footer"
	         (modal-window num #'radial-gauge-form)))))	


(defun radial-gauge-form (num)
  "Generates an HTML form for configuring a linear gauge. The form includes input fields for adjusting various parameters such as width, height, value, title, units, and the number of minor ticks.
   The form uses Htmx attributes for asynchronous communication with the server, triggering updates on click, custom events, and form submission. The form data is sent to the server endpoint '/draw-linear-gauge' and updates the content of the HTML element with the ID 'linear-gauge-place' appended with the provided 'num'."
  (spinneret:with-html
    (:form :class "uk-form-stacked" :id "canvasConfigForm"
	   :data-hx-post "/draw-radial-gauge"
	   :data-hx-swap "innerHTML"
  	   :data-hx-target (str:concat "#radial-gauge-place"num)
	   :data-hx-trigger "click,my-custom-event from:body, submit delay:1s"
	   (:label "Data Column")
	   (generate-select-keys "eje-y" num)
	   (:label "Aggregate Functions")
	   (generate-select-buildIn-filters)
	   (:label " Column Filter data ")
	   (generate-select-keys "eje-y-filter" num)
	   (:label " Column Filter aplly ")
	   (:div :id (str:concat "models" num))
           (:hr)
	   (:label :class "uk-form-label" :for "canvasWidth" "Ancho:")
	   (:input :class "uk-input"
		   :type "number"
		   :name "canvasWidth"
		   :id "canvasWidth"
		   :value "160"
		   :min "10"
		   :max "600"
		   :step "10")
	   
	   (:label :class "uk-form-label" :for "canvasHeight" "Alto:")
	   (:input :class "uk-input"
		   :type "number"
		   :name "canvasHeight"
		   :id "canvasHeight"
		   :value "300" :min "10"
		   :max "900"
		   :step "10")

	   (:label :class "uk-form-label" :for "canvasTitle" "Title:")
	   (:input :class "uk-input"
		   :type "text"
		   :name "canvasTitle"
		   :id "canvasTitle"
		   :value "Temperature")
	   
	   (:label :class "uk-form-label" :for "canvasUnits" "Unidades:")
	   (:input :class "uk-input"
		   :type "text"
		   :name "canvasUnits"
		   :id "canvasUnits"
		   :value "°C")
	   
	   (:label :class "uk-form-label" :for "canvasMinorTicks" "Marcas Menores:")
	   (:input :class "uk-input"
		   :type "number"
		   :name "canvasMinorTicks"
		   :id "canvasMinorTicks"
		   :value "10")
	   (:hr)
	      	   (:button :class "uk-button uk-button-default" "send"))))
	   


(easy-routes:defroute /draw-radial-gauge ("/draw-radial-gauge" :method :post )()
  (setf (hunchentoot:content-type*) "text/html")
  (let* ((html (hunchentoot:post-parameters*)))
    (gauge-radial html)))
    

(defun gauge-radial (html)

  (let* ((query (filter-data-cell-box html))
	 (data (query-lang query))
	 (value (if data
		    (get-value-from-keys (assoc-path html '("filter")) (assoc-path html '("eje-y")) data) nil))
	 
	 (data-min-value (if (and value (not (zerop value)))
			 (truncate (/ value 2.0))
			 0.0))

	 (data-max-value (if (and value (not (zerop value)))
			     (* 1.3 value)
			     100))

	 
	 (data-major-ticks (join-with-commas
			    (generate-escale-range
			     (* data-min-value 1.0)
			     (* data-max-value 1.0)
			     (/  data-max-value 10)))))
    (if value
	(spinneret:with-html-string
	  (:canvas  :data-type "radial-gauge" 
		    :data-width (assoc-path html '("canvasWidth"))
		    :data-height (assoc-path html'("canvasHeight"))
		    :data-border-radius "20"
		    :data-borders "1"
		    :data-bar-begin-circle "false"
		    :data-title (assoc-path html'("canvasTitle"))
		    :data-units (assoc-path html'("canvasUnits"))
		    :data-color-units "#f00"
		    :data-title "false"
		    :data-value (write-to-string value) 
		    :data-min-value data-min-value
		    :data-max-value data-max-value 
		    :data-exact-ticks "false"
		    :data-major-ticks data-major-ticks
		    :data-highlights "0"
		    :data-tick-side "right"
		    :data-number-side "right"
		    :data-needle-side "right"
		    ;;:data-animation-rule "bounce"
		    ;;:data-animation-duration "750"
		    :data-bar-stroke-width "1"
		    :data-value-box-border-radius "0"
		    :data-use-Min-Path "false"
		    :data-value-text-shadow "false"))
	(format nil "~A" "No data selected" ))))



;;;;;;;;;;;;;MSG-NUM-WIDGET;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-message-num-widget ()
  (let ((num (write-to-string (+ (funcall *win-num*) 1))))
    (spinneret:with-html-string
      (:div :class "uk-card-body" 
	    (:div :id (str:concat "message-num-widget-place" num)
		  (:label :class "uk-align-center"
			  (:i :class "far fa-window-maximize" :style "font-size:120px;"))))

      (:span :class "eye-icon" :onclick (str:concat "toggleHeader("num")")
	     (:i :class "fa fa-eye" :style "font-size:10px"))

      (:footer :class "uk-card-footer"
	       (modal-window num #'message-num-widget-form)))))


(defun  message-num-widget-form (num)
  (spinneret:with-html
    (:form :class "uk-form-stacked" :id "messageConfigForm"
	   :data-hx-post "/draw-message-num-widget"
	   :data-hx-swap "innerHTML"
  	   :data-hx-target (str:concat "#message-num-widget-place" num)
	   :data-hx-trigger "click,my-custom-event from:body"
	   
	   (material-icons-select)
	   (:br)
	   (editor-text-area num)
	   (:input :type "hidden" :id (str:concat "editor-content" num) :name "editor-content")
	   
    	   (:br)
	   (:label "Data Column")
	   (generate-select-keys "eje-y" num)
	   (:label "Aggregate Functions")
	   (generate-select-buildIn-filters)
	   (:label " Column Filter data ")
	   (generate-select-keys "eje-y-filter" num)
	   (:label " Column Filter aplly ")
	   (:div :id (str:concat "models" num))
           ;;(:textarea :name "script"   :class "uk-textarea" :rows "5" :placeholder "" :aria-label "Textarea" )
	   
	   
	   (:button :class "uk-button uk-button-default" "send"))))
	   
	   

(easy-routes:defroute /draw-message-num-widget ("/draw-message-num-widget" :method :post )()
  (setf (hunchentoot:content-type*) "text/html")
  (let* ((html (hunchentoot:post-parameters*)))
    (message-num-widget html)))


(defun message-num-widget (html)
  (let* ((query (filter-data-cell-box html))
	 (data (query-lang query))
	 (title (assoc-path html '("editor-content")))
	 (value (if data
		    (get-value-from-keys (assoc-path html '("filter")) (assoc-path html '("eje-y")) data) nil))
	 (icon (assoc-path html '("icon-name"))))

    (if value
	(spinneret:with-html-string
	  (:div :class "uk-text-small"
		(:span (:i  :class "material-icons uk-border-circle" :style "font-size:36px;" icon))
		(:raw title)
		(:h1
		 :data-script ""
		 :class "uk-heading-primary uk-text-center uk-text-primary" value)))
	(format nil "~A" "No data selected"))))




;;;;;;;;;;;;;MSG-list-WIDGET;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-message-list-widget ()
    (let ((num (write-to-string (+ (funcall *win-num*) 1))))
    (spinneret:with-html-string
      (:div :class "uk-card-body" 
	    (:div :id (str:concat "message-list-widget-place" num)
		  (:label :class "uk-align-center"
			  (:i :class "far fa-window-maximize" :style "font-size:120px;"))))

      (:span :class "eye-icon" :onclick (str:concat "toggleHeader("num")")
	     (:i :class "fa fa-eye" :style "font-size:10px"))

      (:div :class "uk-card-footer"
	       (modal-window num #'message-list-widget-form)))))


(defun  message-list-widget-form (num)
  (spinneret:with-html
    (:form :class "uk-form-stacked" :id "messageListConfigForm"
	   :data-hx-post "/draw-message-list-widget"
	   :data-hx-swap "innerHTML"
  	   :data-hx-target (str:concat "#message-list-widget-place" num)
	   :data-hx-trigger "click,my-custom-event from:body, submit delay:1s"
	   (material-icons-select)
	   (:br)
	   (:label "Data Column")
	   (generate-select-keys "eje-y" num)
	   (:label " Column Filter data ")
	   (generate-select-keys "eje-y-filter" num)
	   (:label " Column Filter aplly ")
	   (:div :id (str:concat "models" num))
           (:hr)
	   (:input :type "hidden" :name "num" :value num)
	   (:button :class "uk-button uk-button-default" "send"))))


(easy-routes:defroute /draw-message-list-widget ("/draw-message-list-widget" :method :post )()
  (setf (hunchentoot:content-type*) "text/html")
  (let* ((html (hunchentoot:post-parameters*)))
        (message-list-widget html)))


(defun message-list-widget (html)
  (let* ((value (get-column-data (assoc-path html '("eje-y"))))
	 (col-name (assoc-path html '("eje-y")))
	 (window-num (assoc-path html '("num")))
	 (icon (assoc-path html '("icon-name"))))
    (spinneret:with-html-string
      (:div :class "uk-text-small"
	    (:span (:i  :class "material-icons uk-border-circle" :style "font-size:36px;" icon) "Title")
	    (:table :id (str:concat "table-data" window-num) :class "uk-table uk-table-striped"
                    (:thead
                      (:tr
                        (:th col-name))) 
                    (:tbody
                      (dolist (item value)
                        (:tr (:td item)))))))))


;;;;;;;;;;;;;;;;;;;;;;;;; TABLE WIGDET ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;      

(defun make-table-widget ()
  "Generates an HTML representation of a table widget"
  
    (let ((num (write-to-string (+ (funcall *win-num*) 1))))
    (spinneret:with-html-string
      (:div :class "uk-card-body" 
	    (:div :id (str:concat "table-widget-place" num)
		  (:label :class "uk-align-center"
			  (:i :class "fas fa-table" :style "font-size:120px;"))))

      (:span :class "eye-icon" :onclick (str:concat "toggleHeader("num")")
	     (:i :class "fa fa-eye" :style "font-size:10px"))

    (:footer :class "uk-card-footer"
	        (modal-window num #'table-widget-form)))))


(defun  table-widget-form (num)
  "Generates an HTML form for configuring a table widget."
  (spinneret:with-html
    (:form :class "uk-form-stacked" :id "messageConfigForm"
	   :data-hx-post "/draw-table-widget"
	   :data-hx-swap "innerHTML"
  	   :data-hx-target (str:concat "#table-widget-place" num)
	   :data-hx-trigger "my-custom-event from:body, submit delay:1s"
	   (material-icons-select)
	   (:br)
	   (:label "Title")
	   (editor-text-area num)
	   (:input :type "hidden" :id (str:concat "editor-content" num) :name "editor-content")
    	   (:br)

	   (generate-checkboxes-keys)
	   (:input :type "hidden" :name "num" :value num)
	   (:br)
	   (:button :class "uk-button uk-button-default" "send"))))
	   

(easy-routes:defroute /draw-table-widget ("/draw-table-widget" :method :post )()
  (setf (hunchentoot:content-type*) "text/html")
  (let* ((html (hunchentoot:post-parameters*)))
    (setf *h* html)
   (table-widget html)))
   

(defun table-widget (html)
  "Generates an HTML representation of a table widget based on the input parameters provided in the 'html' variable."
    (let* ((value (get-vals-for-keyword html "select-keys"))
	   (icon (assoc-path html '("icon-name")))
	   (title (assoc-path html '("editor-content")))
	   (window-num (assoc-path html '("num"))))
    (spinneret:with-html-string
      (:div :class "uk-text-small"
	    (:span (:i  :class "material-icons uk-border-circle" :style "font-size:36px;" icon))
	    (:raw title)
	    (:raw (print-html-query
	     (query-lang
	      (format nil (str:concat "select ~{~A~^, ~} from  " (lisp-stat:name (get-session-data-frame-value)))
		     value))
	     :row-numbers t :window-num window-num ))))))

(defun get-vals-for-keyword (data keyword)
  (mapcar #'cdr (remove-if-not
		 (lambda (entry)
		   (equal (car entry) keyword))
		 data )))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;CHARTS WIDGETS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;CHART SIMPLE LINE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun make-chart-line-widget ()
  "Generates an HTML representation of a chart  widget"
  
    (let ((num (write-to-string (+ (funcall *win-num*) 1))))
    (spinneret:with-html-string
      (:div :class "uk-card-body" 
	    (:div :id (str:concat "chart-line-widget-place" num)
		  (:label :class "uk-align-center"
			  (:i :class "fa fa-line-chart" :style "font-size:120px;"))))

      (:span :class "eye-icon" :onclick (str:concat "toggleHeader("num")")
	     (:i :class "fa fa-eye" :style "font-size:10px"))

      (:footer :class "uk-card-footer"
	       	       (modal-window num #'chart-line-widget-form)))))


(defun  chart-line-widget-form (num)
  "Generates an HTML form for configuring a chart widget."
  (spinneret:with-html
    (:form :class "uk-form" :id "messageConfigForm"
	   :data-hx-post "/draw-chart-line-widget"
	   :data-hx-swap "innerHTML"
  	   :data-hx-target (str:concat "#chart-line-widget-place" num)
	   :data-hx-trigger "click,my-custom-event from:body, submit delay:1s"
	   (material-icons-select)
	   (:br)
	   (:hr)
	   (:label "Title")
	   (editor-text-area num)
	   (:input :type "hidden" :id (str:concat "editor-content" num) :name "editor-content")
	   (:br)
	   (:label "Type Char")
	   (chart-input-types)
	   (:hr)
	   (:label "Axis X")
	   (generate-select-keys "eje-x" num)
	   (:label "Axis X Data type")
	   (generate-axis-type-data "eje-x-type")
	   (:label "Axis Y")
	   (generate-select-keys "eje-y" num)
	   (:label "Axis Y Data type")
	   (generate-axis-type-data "eje-y-type")
	   (:label " Axis Y Filter data ")
	   (generate-select-keys "eje-y-filter" num)
	   (:label " Axis Y Filter ")
	   (:div :id (str:concat "models" num))

	   (:label :class "uk-form-label" :for "canvasWidth" "Ancho:")
	   (:input :class "uk-input"
		   :type "number"
		   :name "canvasWidth"
		   :id "canvasWidth"
		   :value "500"
		   :min "300"
		   :max "800"
		   :step "10")
	   
	   (:label :class "uk-form-label" :for "canvasHeight" "Alto:")
	   (:input :class "uk-input"
		   :type "number"
		   :name "canvasHeight"
		   :id "canvasHeight"
		   :value "500" :min "300"
		   :max "900"
		   :step "10")

	   (:button :class "uk-button uk-button-default" "send"))))


 
(easy-routes:defroute /draw-chart-line-widget ("/draw-chart-line-widget" :method :post )()
  (setf (hunchentoot:content-type*) "text/html")
  (let* ((html (hunchentoot:post-parameters*)))
   (chart-line-widget html)))


(defun chart-line-widget (html)
  (let* ((icon (assoc-path html '("icon-name")))
	 (query (filter-data-cell html))
	 (title (assoc-path html '("editor-content")))
	 (data (query-lang query))
	 (spec
	   (if data
	       (write-vega-spec
                (vega:defplot simple-line-plot
		  `(
		    :width  ,(read-from-string (assoc-path html '("canvasWidth")))
		    :height ,(read-from-string (assoc-path html'("canvasHeight")))
		    :data ,data
   	            :mark (:type ,(assoc-path html '("type-char"))  :point t :tooltip t) 
		    :params #((:name "brush"
			       :select (:type "interval"
					:resolve "union"
					:on "[mousedown[event.shiftKey], window:mouseup] > window:mousemove!"
					:translate "[mousedown[event.shiftKey], window:mouseup] > window:mousemove!"
					:zoom "wheel![event.shiftKey]"))
			      (:name "grid"
			       :select (:type "interval"
					:resolve "global"
					:translate "[mousedown[!event.shiftKey], window:mouseup] > window:mousemove!"
					:zoom "wheel![!event.shiftKey]")
			       :bind :scales))

		    
		    :encoding (
			       :x
			       (:field ,(assoc-path html '("eje-x"))
				:type  ,(assoc-path html '("eje-x-type"))
				:axis (:label-angle 0  :title-font-size 20 :label-font-size 20))
			       :y
			       (:field ,(assoc-path html '("eje-y"))
				:type  ,(assoc-path html '("eje-y-type")))

			       :color
			       (:field ,(assoc-path html '("eje-y"))))))
		nil)))
	   
           (spec-string (if spec
			    (with-open-file (stream spec)
                              (read-line stream))
                             "Query failed, graph could not be generated.")))


	 
	 (spinneret:with-html-string
	   (:div :class "uk-text-small"
		 (:span (:i  :class "material-icons uk-border-circle" :style "font-size:36px;" icon))
		 (:raw title)
		 (:br)
		 (:raw 
		  spec-string )))))




;;;;;;;;;;;;;;;;;;;;;;;;;;CHART SIMPLE PIE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-chart-pie-widget ()
  "Generates an HTML representation of a chart  widget"
  
  (let ((num (write-to-string (+ (funcall *win-num*) 1))))
    (spinneret:with-html-string
      (:div :class "uk-card-body" 
	    (:div :id (str:concat "chart-pie-widget-place" num)
		  (:label :class "uk-align-center"
			  (:i :class "fa fa-pie-chart" :style "font-size:120px;"))))
      (:span :class "eye-icon" :onclick (str:concat "toggleHeader("num")")
	     (:i :class "fa fa-eye" :style "font-size:10px"))

      (:footer :class "uk-card-footer"
	       
	       (modal-window num #'chart-pie-widget-form)))))


(defun  chart-pie-widget-form (num)
  "Generates an HTML form for configuring a chart widget."
  (spinneret:with-html
    (:form :class "uk-form-stacked" :id "messageConfigForm"
	   :data-hx-post "/draw-chart-pie-widget"
	   :data-hx-swap "innerHTML"
  	   :data-hx-target (str:concat "#chart-pie-widget-place" num)
	   :data-hx-trigger "click,my-custom-event from:body, submit delay:1s"
	   (material-icons-select)
	   (:br)
	   (:label "Title")
	   (editor-text-area num)
	   (:input :type "hidden" :id (str:concat "editor-content" num) :name "editor-content")
	   (:br)
	   (:label "Axis X")
	   (generate-select-keys "eje-x" num)
	   (:label "Axis X Data type")
	   (generate-axis-type-data "eje-x-type")
	   (:label "Axis Y")
	   (generate-select-keys "eje-y" num)
	   (:label "Axis Y Data type")
	   (generate-axis-type-data "eje-y-type")
	   (:label " Axis Y Filter data ")
	   (generate-select-keys "eje-y-filter" num)

	   (:label " Axis Y Filter ")
	   (:div :id (str:concat "models" num))
	   
	   (:label :class "uk-form-label" :for "canvasWidth" "Ancho:")
		 (:input :class "uk-input"
			 :type "number"
			 :name "canvasWidth"
			 :id "canvasWidth"
			 :value "500"
			 :min "300"
			 :max "900"
			 :step "10")
      
		 (:label :class "uk-form-label" :for "canvasHeight" "Alto:")
		 (:input :class "uk-input"
			 :type "number"
			 :name "canvasHeight"
			 :id "canvasHeight"
			 :value "500"
			 :min "100"
			 :max "900"
			 :step "10")

	   (:button :class "uk-button uk-button-default" "send"))))
	   

(easy-routes:defroute /draw-chart-pie-widget ("/draw-chart-pie-widget" :method :post )()
  (setf (hunchentoot:content-type*) "text/html")
  (let* ((html (hunchentoot:post-parameters*)))
    (setf *html* html)
   (chart-pie-widget html)))


(defun chart-pie-widget (html)
  (let* ((icon (assoc-path html '("icon-name")))
	 (query (filter-data-cell html))
	 (title (assoc-path html '("editor-content")))
	 (data (query-lang query))
	 (spec
	   (if data
	       (write-vega-spec
                (vega:defplot  pie-chart
		  `(
		    :width  ,(read-from-string (assoc-path html '("canvasWidth")))
		    :height ,(read-from-string (assoc-path html'("canvasHeight")))
		    :data ,data
		    :mark :arc
		    :params #((:name "brush"
			       :select (:type "interval"
					:resolve "union"
					:on "[mousedown[event.shiftKey], window:mouseup] > window:mousemove!"
					:translate "[mousedown[event.shiftKey], window:mouseup] > window:mousemove!"
					:zoom "wheel![event.shiftKey]"))
			      (:name "grid"
			       :select (:type "interval"
					:resolve "global"
					:translate "[mousedown[!event.shiftKey], window:mouseup] > window:mousemove!"
					:zoom "wheel![!event.shiftKey]")
			       :bind :scales))

		    :encoding (:theta (:field ,(assoc-path html '("eje-x"))
			               :type  ,(assoc-path html '("eje-x-type")))
		               :color (:field ,(assoc-path html '("eje-y")))))))
		
		nil))
	 
	 (spec-string (if spec
			  (with-open-file (stream spec)
			    (read-line stream))
		      "Query failed, graph could not be generated.")))


  (spinneret:with-html-string
    (:div :class "uk-text-small"
	  (:span (:i  :class "material-icons uk-border-circle" :style "font-size:36px;" icon))
	  (:raw title)
	  (:br)
          (:raw 
           spec-string )))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MAP WIDGET;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-map-widget ()
  "Generates an HTML representation of a map  widget"
  
    (let ((num (write-to-string (+ (funcall *win-num*) 1))))
    (spinneret:with-html-string
      (:div :class "uk-card-body" 
	    (:div :id (str:concat "map-widget-place" num)
		  (:label :class "uk-align-center"
			  (:i :class "fas fa-map" :style "font-size:120px;"))))
      (:span :class "eye-icon" :onclick (str:concat "toggleHeader("num")")
	     (:i :class "fa fa-eye" :style "font-size:10px"))

    (:footer :class "uk-card-footer"
	     (modal-window num #'map-widget-form)))))



(defun map-widget-form (num)
  "Generates an HTML form for configuring a map widget."
  (spinneret:with-html
    (:form :class "uk-form" :id "mapConfigForm"
	   :data-hx-post "/draw-map-widget"
	   :data-hx-swap "innerHTML"
  	   :data-hx-target (str:concat "#map-widget-place" num)
	   :data-hx-trigger "click,my-custom-event from:body"
	   
	   (:ul :data-uk-accordion "multiple: true"
		:onclick "event.stopPropagation();"
		(:li :class "uk-open"
		     (:a :class "uk-accordion-title" :href "" "Title Map")
		     (:div :class "uk-accordion-content"
			   (material-icons-select)
			   (:br)
			   (:label "Title Map")
			   (:input :type "text" :class "uk-input" :name "title" )))

		(:li 
		     (:a :class "uk-accordion-title" :href "" "Data Map")
		     (:div :class "uk-accordion-content"
			   
			   (:label "Marker Label")
			   (generate-select-keys "label-marker" num)

			   (:label "Latitude ")
			   (generate-select-keys "eje-x" num)
			   
			   (:label "Longitude ")
			   (generate-select-keys "eje-y" num)
			   
			   (:label "Filter Column ")
			   (generate-select-keys "eje-y-filter" num)
			   (:label " Filter ")
			   (:div :id (str:concat "models" num))))
		
		(:li 
		     (:a :class "uk-accordion-title" :href "" "Info Windows")
		     (:div :class "uk-accordion-content"
			   (:fieldset 
			    (:label "Label for Info Windows")
			    (add-select-for-info-windows num)
			    (:div :id (str:concat "select-infow-windows" num))))))
	   
		(:button :class "uk-button uk-button-default" "send"))))


(easy-routes:defroute /draw-map-widget ("/draw-map-widget" :method :post )()
  (setf (hunchentoot:content-type*) "text/html")
  (let* ((html (hunchentoot:post-parameters*)))
    (setf *html* html)
   (map-widget html)))


(defun map-widget (html)
  (let* ((query (filter-data-cell html))
         (data (query-lang query))
         (label (assoc-path html '("label-marker")))
	 (coordinates (when data
                        (string2-coordenates data)))

	 (center (when coordinates
                   (format nil "~,8f ,~,8f" (caar coordinates) (cadar coordinates))))
	 
         (title (assoc-path html '("title")))
         (label-marker (if (or (null label) (string= "" label) (string= "Select" label))
                           (make-list (length coordinates) :initial-element "No Label")
                           (get-column-data label)))

	 (keys-list-info-windows (remove "Select"
		   (remove  nil (mapcar (lambda (x)
					  (when (search "label-marker-" (car x) )
					    (cdr x)))
					html))
		   :test #'string=))
	 
	 
	 (data-info-windows (array-to-list (df-to-array keys-list-info-windows))))

    (if (and data coordinates)
        (spinneret:with-html-string
	  (:label (assoc-path html '("title")))
	  (:br)
	  (:select :class "uk-select" :id "select-keys" :onchange "filterMarkers(this.value)"
	    :name "filter-markers"
	    (:option :value "all" "All" )
	    (dolist (input-type (remove-duplicates label-marker :test #'string= ))
              (:option :value input-type input-type )))
	  
          (:div :id "map" 
                (:gmp-map :center center :zoom "6" :map-id "MAP_ID" :title title :style "height: 400px"
                          (dolist (coord coordinates)
                            (let ((label (pop label-marker))
			          (data (pop data-info-windows)))
			      
                              (:gmp-advanced-marker :position (format nil "~,8f ,~,8f" (first coord) (second coord))
                                                    :title label
					            :gmp-clickable "true"
						    :infowindow (info-window data keys-list-info-windows)
                                                    
						    ))))))
        (format nil "~A" "No data selected"))))


(defun info-window(data keys)
  (spinneret:with-html-string
    (:div :class "uk-card uk-card-default uk-width-1-2@m"
	  (dolist (d data)
	    (:div :class "uk-card-body"
		  (let ((d-str (princ-to-string d)))
		    (print d-str)
		    (if (or (string= "NA" d-str)
			    (string= "" d-str))
			(:p "")
			(:p (:strong (format nil "~A: " (pop keys))) d-str))))))))

(defun array-to-list (array)
  (when array
  (let ((rows '()))
    (dotimes (i (array-dimension array 0))
      
      (push (loop for j below (array-dimension array 1)
		  collect (aref array i j))
	    rows))
    (setq rows (reverse rows)))))


(defun df-to-array (keys)
  (let* ((data keys))
    (when data	 
      (aops:as-array  (query-lang
		       (format nil (str:concat "select ~{~A~^, ~} from  " (get-session-data-frame-name))
			       data))))))


(defun string2-coordenates (data)
  (let ((array (aops:as-array data)))
    (loop for i from 0 below (array-dimension array 0)
          collect (list (if (not (stringp (aref array i 0)))
                           (aref array i 0)
                           (read-from-string (aref array i 0)))
                        (if (not (stringp (aref array i 1)))
                            (aref array i 1)
                            (read-from-string (aref array i 1)))))))



(defun extract-label-markers (params)
  "Extrae y agrupa todos los valores asociados con la clave 'label-marker' en PARAMS."
  (let ((label-markers (loop for (key . value) in params
                             when (string= key "label-marker")
                               collect value)))
       (format nil "~{~A~^,~}" label-markers)))



(defun add-select-for-info-windows(num)
  "Generates an HTML select element for make hyperscript"
  (spinneret:with-html
    (:br)
    (:button :class "uk-button uk-button-primary uk-flex-right" :id "add-row"
	     :name "script-button"
	     :data-hx-get "/draw-new-input-for-info-windows"
	     :data-hx-swap "beforeend"
	     :data-hx-target (str:concat "#select-infow-windows" num)
	     :data-hx-sync "closest form:queue drop"
	     :onclick "event.stopPropagation();"
	     "+")))


(easy-routes:defroute /draw-new-input-for-info-windows ("/draw-new-input-for-info-windows" :method :get )()
  (setf (hunchentoot:content-type*) "text/html")
  (let* ((html (hunchentoot:get-parameters*)))
    (generate-select-for-info-windows)))

(defun generate-select-for-info-windows ()
  (spinneret:with-html-string
	 (:div :class " uk-grid" :data-uk-grid ""
	       (:div :class "uk-width-expand"
		     (generate-select-keys "label-marker" "0" "-1"))
	       (:div :class "uk-width-expand"
		     (:label :class "uk-form-label" "")
	             (:button :type "button" :class "uk-button uk-button-danger remove-row"
			      :data-script "on click remove closest .uk-grid" "-")))))
		     








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;GALERY IMAGES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun make-galery-images-widget ()
  
    (let ((num (write-to-string (+ (funcall *win-num*) 1))))
    (spinneret:with-html-string
      (:div :class "uk-card-body" 
	    (:div :id (str:concat "galery-images-widget-place" num)
		  (:label :class "uk-align-center"
			  (:i :class "far fa-window-maximize" :style "font-size:120px;"))))

      (:span :class "eye-icon" :onclick (str:concat "toggleHeader("num")")
	     (:i :class "fa fa-eye" :style "font-size:10px"))

      (:footer :class "uk-card-footer"
	      
	       (modal-window num #'galery-images-widget-form)))))


(defun galery-images-widget-form (num)
  (spinneret:with-html
    (:form :class "uk-form-stacked" :id "galeryImagesConfigForm"
	   :data-hx-post "/draw-galery-images-widget"
	   :data-hx-swap "innerHTML"
  	   :data-hx-target (str:concat "#galery-images-widget-place" num)
	   :data-hx-trigger "click,my-custom-event from:body, submit delay:1s"
	   :onclick "event.stopPropagation();"
	   (material-icons-select)
	   (:br)
	   (:label "Title")
	   (editor-text-area num)
	   (:input :type "hidden" :id (str:concat "editor-content" num) :name "editor-content")
	   (:br)
	   (:label "Data Column")
	   (generate-select-keys "eje-y" num)
     	   (:button :class "uk-button uk-button-default" "send"))))


(easy-routes:defroute /draw-message-text-widget ("/draw-galery-images-widget" :method :post )()
  (setf (hunchentoot:content-type*) "text/html")
  (let* ((html (hunchentoot:post-parameters*)))
        (galery-images-widget html)))


(defun galery-images-widget (html)
  (let* ((value (get-column-data (assoc-path html '("eje-y"))))
  	 (icon (assoc-path html '("icon-name")))
	 (title (assoc-path html '("editor-content"))))

    (spinneret:with-html-string
      (:div :class "uk-text-small"
  	    (:span (:i  :class "material-icons uk-border-circle" :style "font-size:36px;" icon)))
      (:raw title)
      ;;verificar si images es una url
      (:div :class "uk-position-relative uk-visible-toggle uk-light" :tabindex "-1" :data-uk-slideshow "animation: scale"
	    (:div :class "uk-slideshow-items"
		  (dolist (image value)
		    (unless (keywordp image)
		    (if (or (str:starts-with-p "http" image)
			    (str:starts-with-p "data:image/" image))
			(progn 
			(:div
			 (:img :src image :alt "" :data-uk-cover "" :loading "lazy")))
			(progn 
			(:div
			 (:img :src (str:concat "data:image/png;base64," image) :alt "" :data-uk-cover "" :loading "lazy")))))))
      	    
	    (:a :class "uk-position-center-left uk-position-small uk-hidden-hover"
		:href ""
		:data-uk-slidenav-previous ""
		:data-uk-slideshow-item "previous")
	    (:a :class "uk-position-center-right uk-position-small uk-hidden-hover"
		:href ""
		:data-uk-slidenav-next ""
		:data-uk-slideshow-item "next")))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;GALERY VIDEO;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun make-galery-video-widget ()
  
    (let ((num (write-to-string (+ (funcall *win-num*) 1))))
    (spinneret:with-html-string
      (:div :class "uk-card-body" 
	    (:div :id (str:concat "galery-video-widget-place" num)
		  (:label :class "uk-align-center"
			  (:i :class "far fa-window-maximize" :style "font-size:120px;"))))

      (:span :class "eye-icon" :onclick (str:concat "toggleHeader("num")")
	     (:i :class "fa fa-eye" :style "font-size:10px"))

      (:footer :class "uk-card-footer"
	      
	       (modal-window num #'galery-video-widget-form)))))


(defun galery-video-widget-form (num)
  (spinneret:with-html
    (:form :class "uk-form-stacked" :id "galeryVideoConfigForm"
	   :data-hx-post "/draw-galery-video-widget"
	   :data-hx-swap "innerHTML"
  	   :data-hx-target (str:concat "#galery-video-widget-place" num)
	   :data-hx-trigger "click,my-custom-event from:body, submit delay:1s"
	   (material-icons-select)
	   (:br)
	   (:label "Data Column")
	   (generate-select-keys "eje-y" num)
     	   (:button :class "uk-button uk-button-default" "send"))))


(easy-routes:defroute /draw-message-text-widget ("/draw-galery-video-widget" :method :post )()
  (setf (hunchentoot:content-type*) "text/html")
  (let* ((html (hunchentoot:post-parameters*)))
        (galery-video-widget html)))


(defun galery-video-widget (html)
  (let* ((value (get-column-data (assoc-path html '("eje-y"))))
  	 (icon (assoc-path html '("icon-name"))))
    
    (spinneret:with-html-string
      (:div :class "uk-text-small"
  	    (:span (:i  :class "material-icons uk-border-circle" :style "font-size:36px;" icon) "Title"))
      ;;verificar si images es una url
      (:div :class "uk-position-relative uk-visible-toggle uk-light" :tabindex "-1" :data-uk-slideshow "animation: scale"
	    (:div :class "uk-slideshow-items"
		  
		  (dolist (video value)
		    (unless (keywordp video)
		    	(:div
			 (:video :src video  :data-uk-cover "" :controls "")))))
      	    
	    (:a :class "uk-position-center-left uk-position-small uk-hidden-hover"
		:href ""
		:data-uk-slidenav-previous ""
		:data-uk-slideshow-item "previous")
	    (:a :class "uk-position-center-right uk-position-small uk-hidden-hover"
		:href ""
		:data-uk-slidenav-next ""
		:data-uk-slideshow-item "next")))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sql-area()
  (spinneret:with-html
    (:div :class "uk-container"
	  (:h5 "SQL QUERY" )
	  (:form :id "sqlForm" 
		 :data-hx-post "/test-data-frame"
		 :data-hx-swap "outerHTML"
		 :data-hx-target "#query-result"
		 (:div :id "editor" 
		       :class "editor"
		       :style "height: 50px; width: 700px;")
		 (:input :type "hidden" :id "editorContent" :name "editorContent")
		 (:input :class "uk-button uk-button-default" :type "submit" :value "Send"))
	  (:hr)
	  (:input :class "uk-button uk-button-default" :type "submit" :value "Data Types"
		  
   		  :data-hx-get "/data-frame-describe-object"
		  :data-hx-swap "beforeend"
		  :data-hx-target "#windows-content" 
		  
		  (:br)))
    (:div :id "query-test-list" :class "uk-container")))



;;no me acuerdo que hace esto
(defun query-test-list ()
  (spinneret:with-html-string
    (:div :id "query-test-list"  :class "w3-container"
	  (:h5 "SQL QUERY TEST LOAD")
	  (:div 
	   (:ul :class "w3-ul w3-card-4"	       
		(dolist (x *query-test*)
		  (:li :class "w3-display-container"
		       (:form
			:data-hx-post "/report-query-widget"
			:data-hx-swap "outerHTML"
			:data-hx-target "#report-query-widget" 
			(:div :class "w3-container  w3-cell"
			      (:label :class "w3-text-blue" (:b "Title"))
			      (:input :class "w3-input w3-border" :name "name" :type "text" :value "" ))
			(:div :class "w3-container  w3-cell"
			      (:label :class "w3-text-blue" (:b "Query"))
			      (:input :class "w3-input w3-border" :disabled t :name "sqlquery" :type "text" :value x))
			
			(:div :class "w3-container  w3-cell"
			      (:label :class "w3-text-blue" (:b "Widget type"))
		              (html-widget-types "wdgt-bolean"))
			
			(:button :type "submit" "Send"))
		       
		       (:span :onclick "this.parentElement.style.display='none'"
			      :class "w3-button w3-transparent w3-display-right" "X")))))
	  (:div :id "report-query-widget"))))
  



(defun page-data-frame ()
  (spinneret:with-html-string
    (:div :id "data-frame-report-result" :class "uk-container"
	  :data-hx-get "/widget-refresh/table-data"
	  :data-hx-trigger "my-custom-event from:body"
	  :data-hx-swap "innerHTML"
	  (:h5 "Data Frame:"(lisp-stat:name (get-session-data-frame-value)))
       	  
	  (sql-area)
	  
	  (:raw (head-html (get-session-data-frame-value))))))


(defun page-describe-object ()
  (spinneret:with-html-string
    (:div :id "data-frame-report-result" :class "uk-container"
          (:div :class "uk-card uk-card-body"
		(:h5 "Data Frame:"(lisp-stat:name (get-session-data-frame-value)))
		(describe-object-html (get-session-data-frame-value)))
	  )))


(defun html-input-types (name)
  (let ((input-data-types '("button" "checkbox" "color" "date" "datetime-local" "email" "file" "hidden" "image" "month" "number" "password" "radio" "range" "reset" "search" "submit" "tel" "text" "time" "url" "week")))
    (spinneret:with-html
      (:select :class "uk-select" :id "html-input-type" :name name
               (dolist (input-type input-data-types)
                 (:option :value input-type input-type))))))


(defun chart-input-types ()
  (let ((input-data-types '("line" "bar" "circle" "point" "tick" "rect")))
    (spinneret:with-html
      (:select :class "uk-select" :id "html-input-type" :name "type-char"
               (dolist (input-type input-data-types)
                 (:option :value input-type input-type))))))




(defun agrupar-valores (pairs)
  (let ((hash-table (make-hash-table :test 'equal))) 
    (dolist (pair pairs)
      (let* ((key (car pair))
             (value (cdr pair)))
        (push value (gethash key hash-table '())))) 
    hash-table))


(defun  parse-parameter-url-src (html)
  (let* ((query-param '())
	 (domain (car (reverse (agrupar-por-clave html))))
	 (url-src (list(cons (car domain) (cdr domain))))
	 
	 (grouped-data (rest (rest (reverse (agrupar-por-clave html))))))
    (dolist (x grouped-data)
      (push (cons (car x) (fourth x)) query-param))
    (union   url-src query-param)))





(defun print-html-table (df &key (row-numbers nil))
  "Print data frame DF as an HTML table with Spinneret, to STREAM.
   If ROW-NUMBERS is true, also include row numbers."
  (spinneret:with-html-string
    (let* ((array (aops:as-array df)))
      ;; Print opening <table> tag
      (:div :id "query-result" 
	    (:table :id "table-data" :class ""
		    ;; Print header row
		    (:thead
		    (:tr 
		     (when row-numbers (:th "#" ))
		     (map nil #'(lambda (x)
				  (:th x ))
			  (data-frame:keys df))))

		    ;; Print data rows
		    (:tbody
		    (aops:each-index i
		      (:tr
		       (when row-numbers (:td i ))
		       (aops:each-index j
			 (:td (aref array i j)))))))))))


(defun print-html-query (df &key (row-numbers nil) (window-num "0"))
  "Print data frame DF as an HTML table with Spinneret, to STREAM.
   If ROW-NUMBERS is true, also include row numbers."
  (spinneret:with-html-string
    (let* ((array (aops:as-array df)))
	   
      ;; Print opening <table> tag
      
      (:div :id "query-result" :class "uk-overflow-auto"
	    (:table :id (str:concat "table-data" window-num) :class "uk-table uk-table-striped"
		    ;; Print header row
		    (:thead
		    (:tr 
		     ;;(when row-numbers (:th "#" ))
		     (map nil #'(lambda (x)
				  (:th x ))
			  (data-frame:keys df))))
		    
		    (:tfoot 
		    (:tr 
		     ;;(when row-numbers (:th "#" ))
		     (map nil #'(lambda (x)
				  (:th x ))
			  (data-frame:keys df))))

		    ;; Print data rows
		    (:tbody
		    (aops:each-index i
		      (:tr
		       ;;(when row-numbers (:td i ))
		       (aops:each-index j
			 (:td (aref array i j) )))))
		    )))))


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
		    (:div :id "data-types" 
			  (:table :id "table-data-types" 
				  (:tr :class "w3-blue-grey"
				       (mapcar (lambda (header)
						 (:th header))
					       (car rows))
				       (:th "edit"))
				  
				  (loop for row in (cdr rows)
					do (:tr :class "w3-white"
						(loop for cell in row
						      do (:td  cell ))
						(:td (:button  :data-hx-trigger "click" "Edit" ))))))))))





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
	      (:input :class "uk-button uk-button-default" :type "submit" :value "Send")))))
	


(defun head-html (df  &optional (to 6) (from 0))
  "Return the first N rows of DF; N defaults to 6"
  (if (< (aops:nrow df) 6)
      (setf to (aops:nrow df)))
  (print-html-table
   (lisp-stat:select df (lisp-stat:range from to) t) :row-numbers t))




;;;;;;;;;;;;;;;;;;;;;;;GRAPHS AUX ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun write-vega-spec (p  &optional html-loc spec-url )
  (let ((plot-pathname (cond ((uiop:file-pathname-p html-loc) html-loc)
			     ((uiop:directory-pathname-p html-loc)
			      (uiop:merge-pathnames*
			       (uiop:pathname-directory-pathname html-loc)
			       (make-pathname :name (string-downcase (plot:plot-name p))
					      :type "html")))
			     (t (uiop:merge-pathnames* (uiop:physicalize-pathname #P"PLOT:TEMP;")
					;(uiop:pathname-directory-pathname plot:*temp*) ;unwind move to physical paths
						       (make-pathname :name (string-downcase (plot:plot-name p))
								      :type "html")))))
	(num (write-to-string (* 100 (funcall *win-num*)))))
    (ensure-directories-exist plot-pathname)
    (with-open-file (f plot-pathname :direction :output :if-exists :supersede)
      (who:with-html-output (f)
	(:div :id (str:concat "vis" num ))
	(:script
	 (cl-who:esc (cl-who:conc "var spec" num "=")) 
	 (if spec-url
	     spec-url
	     (vega:write-spec p :spec-loc f))
	 ";vegaEmbed(\"#vis"(cl-who:esc num) "\", spec"(cl-who:esc num)").then(result => console.log(result)).catch(console.warn);")))
    plot-pathname))



;;;;;;;;;;;;;;;;;;;;;;;;;;;HTML WIDGETS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;TAB WIDGET;;;;;;;;;;;;;;;;;;;;;;;

(defun make-tab-widget ()
    (let ((num (write-to-string (+ (funcall *win-num*) 1))))
    (spinneret:with-html-string
      (:div :class "uk-card-body" 
	    (:div :id (str:concat "tab-widget-place" num)
		  (:label :class "uk-align-center"
			  (:i :class "far fa-window-maximize" :style "font-size:120px;"))))
      (:span :class "eye-icon" :onclick (str:concat "toggleHeader("num")")
	     (:i :class "fa fa-eye" :style "font-size:10px"))

      (:footer :class "uk-card-footer"
	              (modal-window num #'tab-widget-form)))))


(defun  tab-widget-form (num)
  (spinneret:with-html
    (:form :class "uk-form-stacked" :id "tabConfigForm"
	   :data-hx-post "/draw-tab-widget"
	   :data-hx-swap "innerHTML"
  	   :data-hx-target (str:concat "#tab-widget-place" num)
	   ;;:data-hx-trigger "click"
	   (material-icons-select)
	   (:br)
	   
	   (:label "Tabs Column Number")
	   (:input :class "uk-input" :type "number" :name "tabsnum" :min 1 :max 8 :required t)
	   (:input :type "hidden" :name "id-num" :value num )
	   
	   (:div :id (str:concat "models" num))
           (:hr)
	   
   	   (:button :class "uk-button uk-button-default" "send"))))


(easy-routes:defroute /draw-tab-widget ("/draw-tab-widget" :method :post )()
  (setf (hunchentoot:content-type*) "text/html")
  (let* ((html (hunchentoot:post-parameters*)))
    (print html)
    (tab-widget html)))


(defun tab-widget (html)
  (let* ((icon (assoc-path html '("icon-name")))
	 (tabs-num (parse-integer (assoc-path html '("tabsnum"))))
	 (id-num (assoc-path html '("id-num"))))
    
    (spinneret:with-html-string
      (:div :class "tab-widget"
	    (:div :class "uk-text-small"
		  (:span (:i  :class "material-icons uk-border-circle" :style "font-size:36px;" icon) "Title"))
	    (:div :data-uk-switcher "toggle: > *"
		  
		  (dotimes (i  tabs-num)
		    (:button  :class "uk-button uk-button-default" :type "button" (format nil "Item~a" i)))
		  )
	    (:div :class "uk-switcher uk-margin"
		  (dotimes (i  tabs-num)
		    (:div :class "ui-widget-header ui-droppable uk-active droppable"
			  :id (format nil "droppable~a-~a" id-num i)
			  :role "tabpanel"
			  :aria-labelledby "uk-switcher-31-tab-0"
			  (:ul :class "inner" :id (format nil "droppable-inner~a-~a" id-num i)))))))))



     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;; IMAGE WIDGET ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-editor-widget ()
  (let ((num (write-to-string (+ (funcall *win-num*) 1))))
    (spinneret:with-html-string
      (:div :class "uk-card-body" 
	    (:div :id (str:concat "editor-widget-place" num)
		  (:form :class "uk-form-stacked" :id "imageConfigForm"
			 :data-hx-post "/draw-editor-widget"
			 :data-hx-swap "innerHTML"
  			 :data-hx-target (str:concat "#editor-widget-place" num)
			 (:textarea :id (str:concat "summernote" num) :name "editordata")
			 (:br)
			 (:div :id (str:concat "models" num))
			 (:button  :class "uk-button uk-button-default" "Send"))))
	    
	    (:span :class "eye-icon" :onclick (str:concat "toggleHeader("num")")
		   (:i :class "fa fa-eye" :style "font-size:10px"))
	    
	    (:footer :class "uk-card-footer"
		     (modal-window num #'editor-widget-form)))))


(defun  editor-widget-form (num)
  (print num))

(easy-routes:defroute /draw-editor-widget ("/draw-editor-widget" :method :post )()
  (setf (hunchentoot:content-type*) "text/html")
  (let* ((html (hunchentoot:post-parameters*)))
    (editor-widget html)))

(defun editor-widget (html)
  (format nil "~A" (assoc-path html '("editordata"))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;no work;;;;;;;;;;;;;;;;;;;;;;;

(defun make-cl-widget ()
  (let ((num (write-to-string (+ (funcall *win-num*) 1))))
    (spinneret:with-html-string
      (:div :class "uk-card-body" 
	    (:div :id (str:concat "cl-widget-place" num)
		  (:form :class "uk-form-stacked" :id "imageConfigForm"
			 :data-hx-post "/draw-cl-widget"
			 :data-hx-swap "innerHTML"
  			 :data-hx-target (str:concat "#cl-widget-place" num)
			 ;;(:textarea :id (str:concat "summernote" num) :name "editordata")
		 	 (:div :id "terminal")

			 (:br)
			 (:script :src "https://cdn.jsdelivr.net/npm/biwascheme@0.8.0/release/node_biwascheme.min.js")
			
			 (:div :id (str:concat "models" num))
			 (:button  :class "uk-button uk-button-default" "Send"))))
	    
	    (:span :class "eye-icon" :onclick (str:concat "toggleHeader("num")")
		   (:i :class "fa fa-eye" :style "font-size:10px"))
	    
	    (:footer :class "uk-card-footer"
		     (modal-window num #'cl-widget-form)))))


(defun  cl-widget-form (num)
  (print num))

(easy-routes:defroute /draw-cl-widget ("/draw-cl-widget" :method :post )()
  (setf (hunchentoot:content-type*) "text/html")
  (let* ((html (hunchentoot:post-parameters*)))
    (cl-widget html)))

(defun cl-widget (html)
  (format nil "~A" (assoc-path html '("editordata"))))



(defun editor-text-area(num)
  (spinneret:with-html
    (:div :class "my-editor" :contenteditable "true"
	  :id (str:concat "editable-content" num)
	  :aria-label "Editable Div"
	  :oninput (str:concat "copyContentToHidden("num");" ))

    (:div :id (str:concat "menu-texarea" num)
	  (:div :class "uk-button-group"
	  (:button :onclick "document.execCommand('undo', false, '')" (:i :class "fa fa-undo"))
	  (:button :onclick "document.execCommand('redo', false, '')" (:i :class "fa fa-repeat"))
	  (:button :onclick "document.execCommand('bold', false, '')" (:i :class "fa fa-bold"))
	  (:button :onclick "document.execCommand('italic', false, '')" (:i :class "fa fa-italic"))
	  (:button :onclick "document.execCommand('underline', false, '')"  (:i :class "fa fa-underline"))
	  (:button :onclick "document.execCommand('justifyLeft', false, '')" (:i :class "fa fa-align-left"))
	  (:button :onclick "document.execCommand('justifyCenter', false, '')" (:i :class "fa fa-align-center"))
	  (:button :onclick "document.execCommand('justifyRight', false, '')" (:i :class "fa fa-align-right"))

	  (:select :onclick "document.execCommand('foreColor', false, this.value)"
	    (:option :value "black" "Color")
	    (:option :value "blue" "Primary")
	    (:option :value "green" "Success")
	    (:option :value "yellow" "Warning")
	    (:option :value "red" "Danger"))

	  (:select :onclick "document.execCommand('fontSize', false, this.value)"
	    (:option :value "3" "Size")
	    (:option :value "1" "1")
	    (:option :value "2" "2")
	    (:option :value "3" "3")
	    (:option :value "4" "4")
	    (:option :value "5" "5")
	    (:option :value "6" "6")
	    (:option :value "7" "7"))))))


