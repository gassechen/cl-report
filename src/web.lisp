;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  NEW  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defpackage cl-report
    (:nicknames clreport :CL-REPORT)
    (:use common-lisp))

;; (defun export-1 (html)
;;    (let* ((name (cdr (car html)))  
;;          (route-name (intern (format nil "~a-route" name)))  
;;          (filename (concatenate 'string "report-" name ".lisp"))
	 
;;          (report-definition (list :report-name name (list :route-name route-name)) 
;;           ))
;;     (with-open-file (out filename :direction :output :if-exists :supersede)
;;       (with-standard-io-syntax
;; 	(write report-definition :stream out :escape t)))))

(defun page-new()
(spinneret:with-html-string
    (:doctype)
    (:html
     (:body 
      (header)
      (content "Main page" "")
      (make-new-report)
      (footer)))))


    
(defun header-preview ()
    (spinneret:with-html
    (:title "Dashboard")
    (:meta :name "viewport" :content "width=device-width, initial-scale=1")
    ;;(:link  :rel "stylesheet"  :href "https://www.w3schools.com/w3css/4/w3.css")
    ;;(:link :rel "stylesheet" :href "https://www.w3schools.com/lib/w3-theme-grey.css")

    (:link  :rel "stylesheet"  :href "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css")
    (:link  :rel "stylesheet"  :href "static/style.css")

    (:script :src "https://code.jquery.com/jquery-3.6.0.min.js")
    (:script :src "https://unpkg.com/htmx.org@1.9.4")
    (:script :src "https://cdnjs.cloudflare.com/ajax/libs/ace/1.4.12/ace.js")
    (:script :src "https://cdnjs.cloudflare.com/ajax/libs/ace/1.4.12/ext-language_tools.js")
   
    (:script :src "//cdn.rawgit.com/Mikhus/canvas-gauges/gh-pages/download/2.1.7/all/gauge.min.js")

    (:script :src "https://code.jquery.com/ui/1.13.2/jquery-ui.min.js")
    (:script :src "static/script.js")

    (:link  :rel "stylesheet"  :href "https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.min.css")
    


    ;;(:link :rel "stylesheet" :href "https://unpkg.com/material-components-web@latest/dist/material-components-web.min.css" )
    ;;(:script :src "https://unpkg.com/material-components-web@latest/dist/material-components-web.min.js")
    (:link :rel "stylesheet" :href "https://fonts.googleapis.com/icon?family=Material+Icons")
    
    (:link :rel "stylesheet" :href "https://cdn.jsdelivr.net/npm/uikit@3.17.8/dist/css/uikit.min.css" )
    
    (:script :src "https://cdn.jsdelivr.net/npm/uikit@3.17.8/dist/js/uikit.min.js")
    (:script :src "https://cdn.jsdelivr.net/npm/uikit@3.17.8/dist/js/uikit-icons.min.js")))





(defun build-preview-page (html)
(spinneret:with-html-string
  (:doctype)
  (:html
   (header-preview)
   (:body
    (:div :class "desktop"
	(:ul :class "windows-content" :id "windows-content" 
      (:raw (assoc-path html '("hiddenTextbox")))))))))








;;;;agreagar enlace en el menu y css areglarlo



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;    AUX    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(defun content (header section)
  (spinneret:with-html
    (:main
     (:span :style "font-size:30px;cursor:pointer" :onclick "openNav()" (:i :class "fa fa-bars"))
     (:h1 :class "w3-panel w3-theme-d1" header)
     (:section#section section))))
     


(defun footer ()
  (spinneret:with-html
    (:section#footer
     "Microtrack  © 2023")))



(defun context-menu()
  (spinneret:with-html
    (:div :id "context-menu" :class "context-menu"
          (:ul :class "w3-ul"
	       (:li :class "w3-theme-d4 w3-border w3-black" "Main")
	       (:li
		    :data-hx-get "/menu-links/new-report"
		    :data-hx-swap "beforeend"
		    :data-hx-target "#windows-content"
		    "New")
	       (:li :class "w3-black")
	       (:li :class "w3-theme-d4 w3-border w3-black" "Data")
	       (:li
		    :data-hx-get "/menu-links/data-src"
		    :data-hx-swap "beforeend"
		    :data-hx-target "#windows-content"
		    "Data Src")))))






(defun side-bar*()
  (spinneret:with-html
    (:div :id "sidebar" :class "w3-sidebar" 
	  (:a :href "javascript:void(0)" :class "closebtn"
	      :onclick "closeSidebar()"
	      (:i :class "fas fa-angle-double-right"))
	  (:h3 :class "w3-bar-item" "Visual Component")
	  
	  (:button  :onclick "MenuAccordion('graphics');" :class "w3-button w3-block w3-black w3-left-align" (:i :class "fas fa-chart-bar") "Graphics")
	  (:div :id "graphics" :class "w3-hide w3-container grid-container"
		(:ul :class "w3-ul"
		     (:li (:i :class "fas fa-chart-line") "Gráfico de líneas")
		     (:li (:i :class "fas fa-chart-pie") "Gráfico de pastel")
		     (:li (:i :class "fas fa-bar-chart") "Gráfico de barras")))
	  
	  
	  (:button :onclick "MenuAccordion('widgets');" :class "w3-button w3-block w3-black w3-left-align" (:i :class "fas fa-th") "Widgets") 
	  (:div :id "widgets" :class "w3-hide w3-container"
		(:ul :class "w3-ul"
		     (:li :data-hx-get "/menu-links/boolean-state"
			  :data-hx-swap "beforeend"
			  :data-hx-target "#windows-content"
			  (:i :class "fas fa-calendar") "Calendario")
			  
		     (:li :data-hx-get "/menu-links/"
			  :data-hx-swap "beforeend"
			  :data-hx-target "#windows-content"
			  (:i :class "fas fa-clock") "Reloj")
		     
		     (:li :data-hx-get "/menu-links/linear-gauge"
			  :data-hx-swap "beforeend"
			  :data-hx-target "#windows-content"
			  (:i :class "fas fa-thermometer-half") "Termómetro")))
	  
	  
	  (:button :onclick "MenuAccordion('maps');" :class "w3-button w3-block w3-black w3-left-align" (:i :class "fas fa-map-marked-alt") "Maps")
	  (:div :id "maps" :class "w3-hide w3-container"
		(:ul :class "w3-ul"
		     (:li (:i :class "fas fa-globe-americas") "Mapa mundial")
		     (:li (:i :class "fas fa-map-marker") "Marcador de mapa")
		     (:li (:i :class "fas fa-map") "Mapa genérico")))
	  
	  (:div :class "toggle-btn" :onclick "openSidebar()" (:i :class "fas fa-angle-double-left")))))






(defun page-preview ()
  (spinneret:with-html-string
    (:doctype)
    (:html
     (:body 
      (header)
      
      ;;(generate-table-form-server-api)
      ))))





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





(defun page-data-from-getawey ()
  (spinneret:with-html-string
    (:doctype)
    (:html
     (:body :class "theme-default"
      (header)
      (content "From Getawey" "messages parsed from getawey")
      (table-list *data*)
      (footer)))))



(defun page-data-from-server-api ()
  (spinneret:with-html-string
    (:doctype)
    (:html
     (:body :class "theme-default"
      (header)
      (content "From API" "messages parsed from api")
      ;;(generate-table-form-server-api)
      (footer)))))



(defun page-data-json-shock ()
  (spinneret:with-html-string
    (:doctype)
    (:html
     (:body :class "theme-default"
      (header)
      (content "JSON SHOCK" "messages parsed json shock")
      (consolidado)
      (generate-table-shock)
      (footer)))))


(defun number-panel (title value units)
(spinneret:with-html
  (:div :class "w3-card-4"
    (:header :class "w3-container w3-teal"
     (:i :class "fa fa-info-circle fa-3x w3-text-white" :aria-hidden "true"))
    (:div :class "w3-container w3-hover-shadow  w3-padding-48"
	  
	  (:span :class "w3-tag w3-jumbo w3-padding-large" value))
	  (:h2 units) 
  (:footer :class "w3-container w3-teal"
	   (:h4 title))
  (:div
  (:button :class "btn"
          :data-hx-post "/submit"
          :data-hx-prompt "Enter a string"
          :data-hx-confirm "Are you sure?"
          :data-hx-target "#response"
    "Prompt Submission")
  
  (:div :id "response")))))



(defun  boolean-state (title value)
(spinneret:with-html-string
  (:div :class "w3-card-4" :style "width:100%;"
    (:header :class "w3-container w3-teal"
     (:i :class "fa fa-info-circle fa-1x w3-text-white" :aria-hidden "true"))
    (:div :class "w3-container w3-hover-shadow w3-padding-64"
	  
	(if (zerop value) 
		    (:i :class "fa fa-window-close fa-1x w3-text-red"
			:aria-hidden "true")
		    (:i :class "fa fa-check-square fa-1x w3-text-green"
			:aria-hidden "true")))   
  (:footer :class "w3-container w3-teal"
  (:h5 title)))))
  

(defun  message-state (title value )
(spinneret:with-html
  (:div :class "w3-card-4" :style "width:100%;"
    (:header :class "w3-container w3-teal"
     (:i :class "fa fa-info-circle fa-3x w3-text-white" :aria-hidden "true"))
    (:div :class "w3-container w3-hover-shadow w3-padding-64"
	  
	(if (zerop value) 
		    (:i :class "fa  fa-files-o fa-5x w3-text-red"
			:aria-hidden "true")
		    (:i :class "fa fa-file-o fa-5x w3-text-green"
			:aria-hidden "true")))   
  (:footer :class "w3-container w3-teal"
  (:h4 title)))))




(defun fail-code-state (title value units)
(spinneret:with-html
  (:div :class "w3-card-4"
    (:header :class "w3-container w3-teal"
     (:i :class "fa fa-info-circle fa-3x w3-text-white" :aria-hidden "true"))
    (:div :class "w3-container w3-hover-shadow  w3-padding-48"
	  
	  (:span :class "w3-tag w3-xlarge w3-padding-large" value))
	  (:h2 units) 
  (:footer :class "w3-container w3-teal"
  (:h4 title)))))












(defun gauge (title  value units type)
  (let* ((data-min-value (if (zerop value) 0.0 (truncate (/ value 2.0))))
	 (data-max-value (if (zerop value) 100  (* 2 value)))
	 (data-major-ticks (join-with-commas
			    (generate-escale-range
			      (* data-min-value 1.0)
			      (* data-max-value 1.0)
			      (/  data-max-value 10)))))
   (spinneret:with-html-string
      (:div :class "w3-card-4" :style "width:100%;"
	    (:header :class "w3-container w3-teal"
		     (:i :class "fa fa-info-circle fa-3x w3-text-white" :aria-hidden "true"))
	    (:div :class "w3-container" :class title
		  (:canvas  :data-type type
			    :data-units units
			    :data-title "false"
			    :data-value value
			    :data-min-value data-min-value
			    :data-max-value data-max-value 
			    :data-exact-ticks "true"
			    :data-major-ticks data-major-ticks
			    :data-minor-ticks "2"
			    :data-highlights "0"
			    :data-width "210"
			    :data-height "210"
			    :data-value-box "true"
			    :data-font-numbers-size "25"))
	    (:footer :class "w3-container w3-teal"
		     (:h4 title))))))




(defun select-widget (title value units)
  
  (cond ((string= "Tensión" title) (gauge title value units "radial-gauge"))
	((string= "Power Supply" title) (gauge title value units "radial-gauge"))
        ((string= "Nivel" title) (gauge title value units "linear-gauge"))
	((string= "Ciclos" title) (number-panel title value units))
	((string= "Prod. diaria" title) (number-panel title value units))
	((string= "Bombas" title) (number-panel title value units))
	((string= "Run Time" title) (number-panel title value units))
	((string= "Potencia kW" title) (number-panel title value units))
	((string= "Maq. en falla 0:No, 1:Si" title) (boolean-state title value))
	((string= "Maq. en falla (0:No, 1:Si)" title) (boolean-state title value))
	((string= "Maq. en marcha 0:No, 1:Si" title) (boolean-state title value))
	((string= "Maq. en marcha (0:No, 1:Si)" title) (boolean-state title value))
	((string= "Msj. original 0:copia, 1:original" title) (message-state title value))
	((string= "Cod. Falla" title) (fail-code-state title value units))
	((string= "Cod. compulsivo" title) (number-panel title value units))
	((string= "Temperature" title) (gauge title value units "linear-gauge"))


	;;SHOCK
	((string= "Active range set point high" title) (number-panel title value units))
	((string= "Active range set point low" title) (number-panel title value units))
	((string= "Shock Event Value" title) (number-panel title value units))
        ((string= "Worst Shock Event Value" title) (number-panel title value units))


	((string= "Shock" title) (number-panel title value ""))
	((string= "Sin info" title) (number-panel title value ""))
	((string= "Solo posición" title) (number-panel title value ""))
	((string= "Comunicación correcta" title) (number-panel title value ""))
	((string= "Activos" title) (number-panel title value ""))
        (nil (spinneret:with-html (:p "" )))))


(defun table-gauges (lst)
  (spinneret:with-html  
    (:div :class "w3-container"
    (:ul :class "horizontal-list "
	    (loop for row in lst 
		  collect
		  (:li  :class "w3-center"
			(select-widget (car row)  (second row) (third row))))))))



(defun table-list (data)
  (spinneret:with-html
		
     (loop for row in data 
	   collect
	   (:br
	   (:br 
	    (:div :class "w3-bottombar w3-leftbar w3-topbar w3-rightbar  w3-light-grey" 
	     :class "w3-container w3-border w3-round-large w3-hover-border-green"
	     ;;TABLE HEADER
		 (:table :class "tabla-datos" :class "w3-table w3-large w3-bordered"
				     (:thead :class "w3-teal"
					     (:tr       
					      (:td   "Entity Id")
					      (:td   "ESN") 
					      (:td   "Date")
					      (:td  "Latitud")
					      (:td  "Longitud")))
				     (:tbody
				      (:tr :class "w3-center"
					   (:td :rowspan (+ 1 (length (nth 6 row)))
						(first row))
					   (:td :rowspan (+ 1 (length (nth 6 row)))
						(second row))
					   (:td :rowspan (+ 1 (length (nth 6 row)))
						(fourth row))
					   (:td :rowspan (+ 1 (length (nth 6 row)))
						(subseq (sixth row) 0 18))
					   (:td :rowspan (+ 1 (length (nth 6 row)))
						(subseq (fifth row) 0 18)))))
		 ;;TABLE SET 
		 (:div :class "tab-set"
		 (:div :class "w3-bar w3-teal"
		       (:button :class "w3-bar-item w3-button tablink w3-black" :data-city "panel" "Panel")
		       (:button :class "w3-bar-item w3-button tablink" :data-city "map" "Map")
		       (:button :class "w3-bar-item w3-button tablink" :data-city "table" "Table"))
		 ;;PANEL 
		 (:div :class "tab-content"
		       (:div :class "city" :data-city "panel" :style "display: block;"
    			     (:ul :class "w3-ul"
		       (:li  :class "w3-center"  
            		     (table-gauges (data-for-gauges-gw (nth 6 row))))))

		     ;;MAP 
		 (:div :class "city" :data-city "map" :style "display: none;"
		       	     (:div :class "map-container " :style "width:100%;max-width:700px"))

		 ;;TABLE
		 (:div :class "city" :data-city "table" :style "display: none;"     
		 
			     (:table :id "tabla-datos-list" :class "w3-table w3-large w3-bordered"
				     (:thead :class "w3-teal"
					     (:tr 
					      (:td  "Event Type")
					      (:td  :class "w3-right-align" "Value")
					      (:td  :class "w3-right-align" "Units")))
				     (:tbody
				      (:tr 
				       (loop for nested-col in (nth 6 row)
					     collect
					     (:tr :class "w3-hover-green"
						  (:td (car nested-col))
						  (:td :class "w3-right-align"
						       (cadr nested-col))
						  (:td :class "w3-right-align"
						       (caddr nested-col))))))))))))))))



(defun data-for-gauges-gw (lst)
  (mapcar #'(lambda (nested-col)
	    (list (car nested-col)
		  (cadr nested-col)
		  (caddr nested-col)))
	lst))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; from json data shock;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;



(defun  parse-json-shock-file()
  (with-open-file (json-stream "/home/mtk/projects/CL/lisp-web-template-productlist/src/data/json_shock/shock.json" :direction :input)
    (let ((lisp-data (yason:parse json-stream :object-as :alist)))
      lisp-data )))

(defparameter *shock-data* (cdr (nth 5 (parse-json-shock-file))))

;;;TABLA PARA LAS ESTADISTICAS
(defun calculate-statistics-shock (data)
  (let* ((stats (make-list 5 :initial-element 0))
         (unique-elements (make-hash-table :test 'equal)))
    (loop for item in data
          do (incf (nth 0 stats) (cdr (nth 6 item)))
             (incf (nth 1 stats) (cdr (nth 7 item)))
             (incf (nth 2 stats) (cdr (nth 8 item)))
             (incf (nth 3 stats) (cdr (nth 9 item)))
             (unless (gethash (cdr (nth 0 item)) unique-elements)
               (setf (gethash (cdr (nth 0 item)) unique-elements) t)
               (incf (nth 4 stats)))
          finally (return stats))))


;; Ejemplo de uso con una lista *dj* válida
(defun consolidado()
  (spinneret:with-html
    (:div :class "w3-bottombar w3-leftbar w3-topbar w3-rightbar  w3-light-grey" 
  (let ((result (calculate-statistics-shock *shock-data*)))
    (:div :class "city"
	  :data-city "panel"
	  :style "display: block;"
	  (:ul :class "w3-ul"
	       (:li  :class "w3-center"
                     (:div :class "w3-container"
			   (:ul :class "horizontal-list "
			        (:li  :class "w3-center"
		      		      (select-widget "Shock" (first result) ""))
				      
				 (:li  :class "w3-center"
				       (select-widget "Sin info" (second result) ""))
				       
				 (:li  :class "w3-center"
				       (select-widget "Solo posición" (third result) ""))
				 (:li  :class "w3-center"
			               (select-widget "Comunicación correcta" (fourth result) ""))
			 
				 (:li  :class "w3-center"
			        (select-widget "Activos" (fifth result) ""))
				)))))))))		 
			 


;;(*tt* (remove-if-not #'listp (nth 5 *dj*))			   


(defun generate-table-shock ()
  (spinneret:with-html
    (dolist (data (remove-if-not #'listp *shock-data*))
      (:br
       (:br 
	(:div :class "w3-bottombar w3-leftbar w3-topbar w3-rightbar  w3-light-grey" 
	 ;;TABLE SET 
		 (:div :class "tab-set"
		 (:div :class "w3-bar w3-teal"
		       (:button :class "w3-bar-item w3-button tablink w3-black"
				:data-city "panel" "Panel")
		       (:button :class "w3-bar-item w3-button tablink"
				:data-city "map" "Map")
		       (:button :class "w3-bar-item w3-button tablink"
				:data-city "table" "Table"))
		 
		 (:div :class "tab-content"
                      
		   ;;PANEL     
		       (:div :class "city"
			     :data-city "panel"
			     :style "display: block;"
			     
    		   (:ul :class "w3-ul"
			(:li  :class "w3-center"
                            (:div :class "w3-container"
				  (:ul :class "horizontal-list "
			          (prune #'null 
			           (loop for i from 0 below (length data) by 2
			             collect
				     (when (string= (car (nth i data)) "datosShock")
				         (:li  :class "w3-center"
		     
     			 (select-widget
			  (assoc-path (cdr (nth i  data)) '("nombre"))
			  (when (cdr (nth i  data))
			  (assoc-path (cdr (nth i  data)) '("valor")))
			  (assoc-path (cdr (nth i  data)) '("hora"))))))))))))

		       
                 ;;MAP 
		 (:div :class "city" :data-city "map" :style "display: none;"
		       (:div :class "map-container "
			     :style "width:100%;max-width:700px"))
		;;TABLE
	         (:div :class "city"
		       :data-city "table"
		       :style "display: none;"     
		       (:table :id "tabla-datos-list"
			       :class "w3-table w3-large w3-bordered"
			       (:thead :class "w3-blue-grey"
				       (:tr 
					(:td   "Event Type")
					(:td  :class "w3-right-align" "Value")))
					
			       (:tbody
				(:tr 
			         (loop for i from 0 below (length data) 
				       collect
				   (:tr :class "w3-hover-green"
			        	(:td (car (nth i data))
					     (:td :class "w3-right-align"
					 ;;(cdr (nth i data))
					  (parse-extra-data-shock
				            (nth i data))
					   (when
					      (string= (car (nth i data)) "datosShock")
					   (:tr :class "w3-hover-green"
					(:td (assoc-path (cdr (nth i  data)) '("nombre")))
						(:td :class "w3-right-align"
						(assoc-path (cdr (nth i  data)) '("valor")))))		 
							    
					   ))))))))))))))))


(defun parse-extra-data-shock (data)
    (cond ((string= "fecha" (car data)) (my-parse-date (cdr data)))
	((string= "latitud" (car data)) (format nil "~,F" (cdr data)))
	((string= "longitud" (car data)) (format nil "~,F" (cdr data)))
	(t  (cdr data))))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;
;; Start the web server.
;;

(defun main-5()
(handler-case
    (start-server)  ; Coloca aquí tu código para iniciar el servidor Hunchentoot
  (condition (error)
    (format t "Se ha producido un error en el servidor: ~A~%" error))))
  

(defun start-server (&key (port *port*))
  (format t "~&Starting the web server on port ~a" port)
  (force-output)
  (setf *server* (make-instance 'easy-routes:easy-routes-acceptor
                                :port (or port *port*)))
  (push (hunchentoot:create-folder-dispatcher-and-handler
       "/static/" (merge-pathnames "src/static/"  ;; starts without a /
                                   (asdf:system-source-directory :cl-report)))
	hunchentoot:*dispatch-table*)
  
  (hunchentoot:start *server*))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;; (defun read-table-1 (db table)
;;   "Read TABLE and return a data frame with the contents. Keys are interned in a package with the same name as TABLE."
;;   (let* ((nrows (sqlite:execute-single db (format nil "select count (*) from ~A" table)))
;; 	 (ncols (sqlite:execute-single db (format nil "select count(*) from pragma_table_info('~A')" table)))
;; 	 (names (execute-to-column db (format nil "select name from pragma_table_info('~A')" table)))
;; 	 (types (execute-to-column db (format nil "select type from pragma_table_info('~A')" table)))
;; 	 (*package* (cond
;; 		      ((find-package (string-upcase table)) (find-package (string-upcase table)))
;; 		      (t (make-package (string-upcase table)))))
;; 	 (columns (loop
;; 		    for name in names
;; 		    for type in types
;; 		    collect (cons (if (find-symbol name) (find-symbol name) (intern (string-upcase name)))
;; 				  (alexandria:switch (type :test #'string=)
;; 				    ("REAL"    (make-array nrows :element-type 'double-float))
;; 				    ("INTEGER" (make-array nrows :element-type 'integer))
;; 				    ("TEXT"    (make-array nrows)))))))

;;     (sqlite::with-prepared-statement stmt (db (format nil "select * from ~A" table) nil)
;;       (loop while (sqlite:step-statement stmt)
;; 	    for i = 0 then (1+ i)
;; 	    do (loop for j from 0 below ncols
;; 		 do (let ((value (sqlite:statement-column-value stmt j)))
;;      (if (null value)
;;          (setf (aref (cdr (nth j columns)) i) 0.00d0) ; Asignar un valor predeterminado (0.0 en este caso)
;;          (setf (aref (cdr (nth j columns)) i)  value)))    )))

    
    
     
    
;;     (data-frame:alist-df columns)))




;; (defun execute-to-column (db sql &rest parameters)
;;   (declare (dynamic-extent parameters))
;;   (sqlite::with-prepared-statement stmt (db sql parameters)
;;     (loop while (sqlite:step-statement stmt)
;;           collect (sqlite:statement-column-value stmt 0))))




 
