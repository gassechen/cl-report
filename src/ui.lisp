(in-package :cl-report)

(defvar *my-cascade* 10)

(defun window-number-generator ()
  (let ((contador 0))
    (lambda ()
      (incf contador))))

(defparameter *win-num* (window-number-generator))


(defun make-cascade-windows ()
  (setf *my-cascade* (+ 5 *my-cascade*))
  (if (< *my-cascade* 400)
      (format nil "left: ~apx; top: ~apx;" *my-cascade* (truncate (/ *my-cascade* 1.1 )))
      (setf *my-cascade* 5)))



(defun alert (&key (style "primary") (text "Data Loaded Successfully"))
  "There are several style modifiers available. Just add one of the following classes to apply a different look
primary  success warning danger"
  (spinneret:with-html-string
    (:div :class (str:concat "uk-alert-" style) :data-uk-alert "animation: uk-animation-scale-up; duration: 1000 "
      (:a :href "#" :class "uk-alert-close" :data-uk-close "")
      (:p text))))


;; ver este falta algo en el close
(defun notification (&key (style "primary") (text "Data Loaded Successfully"))
  "There are several style modifiers available. Just add one of the following classes to apply a different look
primary  success warning danger"
  (let ((message (str:concat "UIkit.notification(\""text"\", {status:'"style"',pos:'top-right'});")))   
  (spinneret:with-html-string
    (:script (:raw message)))))


(defun header ()
  (spinneret:with-html
    (:title "Dashboard")
    (:meta :name "viewport" :content "width=device-width, initial-scale=1")
    ;;(:link  :rel "stylesheet"  :href "https://www.w3schools.com/w3css/4/w3.css")
    ;;(:link :rel "stylesheet" :href "https://www.w3schools.com/lib/w3-theme-grey.css")

    (:link  :rel "stylesheet"  :href "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css")
    (:link  :rel "preconnect" :href "https://rsms.me/")
    (:link  :rel"stylesheet" :href "https://rsms.me/inter/inter.css")
    (:style (:raw "body { font-family: 'Inter', sans-serif; background-color: #222; color: #eee; }"))
    (:link  :rel "stylesheet"  :href "static/style.css")
    ;;(:link  :rel "stylesheet"  :href "https://unpkg.com/tabulator-tables@5.5.2/dist/css/tabulator.min.css" )
    (:script :type "text/javascript" :src "https://unpkg.com/tabulator-tables@5.5.2/dist/js/tabulator.min.js")
    (:link  :rel "stylesheet"  :href "static/table_meterialize.min.css")
    (:link  :rel "stylesheet"  :href "static/table_materialize.min.css.map")


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

    (:link :rel "stylesheet" :href "https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.css" )
    (:script :src "https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.js")

    
    (:link :rel "stylesheet" :href "https://cdn.jsdelivr.net/npm/uikit@3.24.2/dist/css/uikit.min.css" )
    (:script :type "text/javascript" :src "https://cdn.jsdelivr.net/npm/vega@5")
    (:script :type "text/javascript" :src "https://cdn.jsdelivr.net/npm/vega-lite@5")
    (:script :type "text/javascript" :src "https://cdn.jsdelivr.net/npm/vega-embed@6")

    ;;(:script :src "https://polyfill.io/v3/polyfill.min.js?features=default")
    (:script :src "https://cdn.jsdelivr.net/npm/sweetalert2@11")
    (:script :src "/static/public/cljs-out/dev-main.js")
    
    (:script :src "https://unpkg.com/hyperscript.org@0.9.12")
    (:script :src "https://maps.googleapis.com/maps/api/js?key=AIzaSyB9bZPIs9Pz87A_ahoOztICA6jgD6iOwBE&callback=initMap&libraries=marker&v=beta&libraries=marker"
	     :defer "")
    (:script :src "https://cdn.jsdelivr.net/npm/uikit@3.24.2/dist/js/uikit.min.js")
    (:script :src "https://cdn.jsdelivr.net/npm/uikit@3.24.2/dist/js/uikit-icons.min.js")))
    


(defun top-menu ()
  (spinneret:with-html
    (:nav :class "uk-navbar-container uk-background-primary"
	  (:div :class "uk-navbar uk-background-primary"
		(:div :class "uk-navbar-center"
		      (:ul :class "uk-navbar-nav uk-light"
			   (:li :class "uk-parent"
				(:button
				 :class "uk-button uk-button-text "
				 :type "button"
				 :data-uk-toggle "target: #win-offcanvas-nav"
				 (:span :class "uk-margin-small-right"
					:data-uk-icon "icon: thumbnails")
				 "Windows"))
			   
			   (:li :class "uk-parent"
				(:button :class "uk-button uk-button-text"
					 :data-hx-get "/menu-links/new-report"
					 :data-hx-swap "beforeend"
					 :data-hx-target "#modals-new-report"
					 (:span :class "uk-margin-small-right"
						:data-uk-icon "icon: file")
					 "New Report"))
			   (:li :class "uk-parent"
				(:button :class "uk-button uk-button-text"
					 :data-hx-get "/menu-links/data-src"
					 :data-hx-swap "beforeend"
					 :data-hx-target "#windows-content" 
					 (:span :class "uk-margin-small-right"
						:data-uk-icon "icon: server")
					 "Data Source"))
			   
			   (:li  :class "uk-parent"
				 (:button :class "uk-button uk-button-text"
					  :data-hx-get "/menu-links/table-data"
					  :data-hx-swap "beforeend"
					  :data-hx-target "#windows-content"
					  (:span :class "uk-margin-small-right"
						 :data-uk-icon "icon: table")
					  "SQL"))
			   (:li :class "uk-parent"
				(:button
				 :onclick "toggleEditContent();"
				 :class "uk-button uk-button-text"
				 (:span :class "uk-margin-small-right"
					:data-uk-icon "icon: pencil")
				 "Edit"))
			   
			   (:li :class "uk-parent"
				(:button
				 :onclick "save();"
				 :class "uk-button uk-button-text"
				 (:span :class "uk-margin-small-right"
					:data-uk-icon "icon: database")
				 "Save"))
			   
			   (:li :class "uk-parent"
				(:form :action "/make-preview" :target "_blank" :method "post" 
				       (:input :class "uk-input"
					       :type "hidden"
					       :id "hiddenTextbox"
					       :name "hiddenTextbox"
					       )
				       (:button :class "uk-button uk-button-text"
						(:span :class "uk-margin-small-right"
						       :data-uk-icon "icon: eye")
						"Preview")))
			   (:li :class "uk-parent"
				(:button
				 :class "uk-button uk-button-text"
				 :type "button"
				 :data-uk-toggle "target: #offcanvas-nav"
				 (:span :class "uk-margin-small-right"
					:data-uk-icon "icon: table")
				 "Widgets"))

			   (:li :class "uk-parent"
				;;:data-hx-get "/session-check"
				;;:data-hx-swap "innerHTML"
  				;;:data-hx-target "body"
				;;:data-hx-trigger "every 3600s"
				)

			   ))))))




(defun side-bar()
  (spinneret:with-html
    (:div :id "offcanvas-nav" :data-uk-offcanvas "flip: true"
	  :class "uk-offcanvas uk-open"
	  (:div :class "uk-offcanvas-bar"
		(:button :class "uk-offcanvas-close uk-close-large uk-icon uk-close"
			 :type "button"
			 :data-uk-close ""
			 :data-uk-toggle "cls: uk-close-large; mode: media; media: @s" :data-aria-label "Close")

		(:ul :class "uk-nav uk-nav-default"
		     (:li :class "uk-nav-header" "Html Widgets")

		     (:li :data-hx-get "/menu-links/make-tab-widget"
			  :data-hx-swap "beforeend"
			  :data-hx-target "#windows-content"
			  (:i :class "fas fa fa-tablet") "Hz-Tab")

		     (:li :data-hx-get "/menu-links/make-editor-widget"
			  :data-hx-swap "beforeend"
			  :data-hx-target "#windows-content"
			  (:i :class "fa fa-file-text") "Editor")

		     (:li :data-hx-get "/menu-links/make-bwsch-widget"
			  :data-hx-swap "beforeend"
			  :data-hx-target "#windows-content"
			  (:i :class "fa fa-file-text") "Bwsch")

		     
		     
		     (:li :class "uk-nav-header" "Widgets")

		     (:li :data-hx-get "/menu-links/linear-gauge"
			  :data-hx-swap "beforeend"
			  :data-hx-target "#windows-content"
			  (:i :class "fas fa-thermometer-half") "Linear Gauge")

		     (:li :data-hx-get "/menu-links/radial-gauge"
			  :data-hx-swap "beforeend"
			  :data-hx-target "#windows-content"
			  (:i :class "fa fa-tachometer") "Radial Gauge")

		     (:li :data-hx-get "/menu-links/message-num-widget"
			  :data-hx-swap "beforeend"
			  :data-hx-target "#windows-content"
			  (:i :class "far fa-window-maximize") "Msg Num Box")
		     
		     (:li :data-hx-get "/menu-links/message-list-widget"
			  :data-hx-swap "beforeend"
			  :data-hx-target "#windows-content"
			  (:i :class "far fa-window-maximize") "Msg List Box")
		     
		     (:li :data-hx-get "/menu-links/make-table-widget"
			  :data-hx-swap "beforeend"
			  :data-hx-target "#windows-content"
			  (:i :class "fa fa-table") "Table Box")


		     (:li :class "uk-nav-divider")
		     (:li :class "uk-nav-header" "Multimedia")

		     (:li :data-hx-get "/menu-links/make-galery-images-widget"
			  :data-hx-swap "beforeend"
			  :data-hx-target "#windows-content"
			  (:i :class "fa  fa-camera") "Image Gallery")

		     (:li :data-hx-get "/menu-links/make-galery-video-widget"
			  :data-hx-swap "beforeend"
			  :data-hx-target "#windows-content"
			  (:i :class "fa fa-video-camera") "Video Gallery")
		     
		     
		     

		     (:li :class "uk-nav-divider")
		     (:li :class "uk-nav-header" "Charts")

		     (:li :data-hx-get "/menu-links/make-chart-line-widget"
			  :data-hx-swap "beforeend"
			  :data-hx-target "#windows-content"
			  (:i :class "fa fa-line-chart") "Chart Line Box")

		     (:li :data-hx-get "/menu-links/make-chart-pie-widget"
			  :data-hx-swap "beforeend"
			  :data-hx-target "#windows-content"
			  (:i :class "fa fa-pie-chart") "Chart pie Box")

		     (:li :class "uk-nav-divider")
		     (:li :class "uk-nav-header" "Charts")
		     (:li :data-hx-get "/menu-links/make-map-widget"
			  :data-hx-swap "beforeend"
			  :data-hx-target "#windows-content"
			  (:i :class "fas fa-map") "Map Box")

		     
		     )))))


;; (defun win-bar()
;;   (spinneret:with-html
;; 	  :class "uk-offcanvas uk-open"
;; 	  (:div :class "uk-offcanvas-bar"
;; 		(:button :class "uk-offcanvas-close uk-close-large uk-icon uk-close"
;; 			 :type "button"
;; 			 :data-uk-close ""
;; 			 :data-uk-toggle "cls: uk-close-large; mode: media; media: @s" :data-aria-label "Close")

;; 		(:ul :class "uk-nav uk-nav-default"
;; 		     (:li :class "uk-nav-header" "Projects")
;; 		     (dolist (project-id (get-all-project-user (hunchentoot:session-value 'user-name) ))
;; 		       (let ((name (get-project-name project-id)))
;; 			 (:li :class "uk-parent"

;; 			      (:form :action (str:concat "/project-links/" name) :target "_blank" :method "post" 
;; 			         (:button :class "uk-button uk-button-default"
;; 				      (:span :class "uk-margin-small-right"
;; 					     :data-uk-icon "icon: eye")
;; 				      name))
			           
;; 			      ))))

;; 		(:div :id "minimized-windows"))))) 



(defun list-reports ()
  (spinneret:with-html-string
    (let ((project-list (reverse (get-all-project-user (hunchentoot:session-value 'user-name)))))
    
    (dolist (project-id project-list)
      (let ((name (get-project-name project-id)))
	(:div :class "uk-container"
	          (:div :class "uk-child-width-1-2@m uk-grid-small uk-grid-match" :data-uk-grid ""
			(:div :class "uk-card uk-card-default uk-card-body"
			      (:div :class "uk-column-1-2"
				    (:p (:span :class "uk-margin-small-right"
					       :data-uk-icon "icon: nut;ratio: 2.5")
					name)    
			      (:form :action (str:concat "/project-links/" name) :target "_blank" :method "post" 
				     (:button :class "uk-button  uk-button-text uk-width-1-1"
					      (:span :class "uk-margin-small-right"
						     :data-uk-icon "icon: file ")
					      "Open"))

			      (:button :class "uk-button uk-button-danger uk-button-text uk-width-1-1"
				       :data-hx-confirm "Are you sure you wish to delete project?"
				       :data-hx-post (str:concat "/project-links-delete/"(write-to-string project-id))
				       :data-hx-swap "innerHTML swap:1s"
				       :data-hx-target "#list-report"
				       (:span :class "uk-margin-small-right"
					      :data-uk-icon "icon: minus ")
				       "Delete")
			      (:a :class "uk-link-muted" :href (str:concat "/report-links/"(write-to-string project-id))
				  (str:concat "/report-links/"(write-to-string project-id))))))))))))

    



(defun windows (window-name window-content)
  (let ((num (write-to-string (funcall *win-num*))))
    (spinneret:with-html-string
      (:li :id (str:concat "w3-card" num)
	   :class "uk-card uk-card-small uk-card-hover uk-card-default resizable-card"
	   :style (str:concat (make-cascade-windows) "z-index:" "10")
	   (:header :class "uk-card-header"
		    (:div :class "uk-grid uk-grid-small"
			  (:div :class "uk-grid uk-grid-small"
				(:div :class "uk-width-auto" (:h5 window-name num))

				(:span :class "close-button w3-margin-right" :onclick (str:concat "closeWindow("num")")
				       (:i :class "fa fa-close" :style "font-size:16px;color:red"))
				(:span :class "w3-right w3-margin-right" :onclick (str:concat "minimizeWindow("num",'"window-name"')")
				       (:i :class "fa fa-minus" :style "font-size:16px"))

				(:span :class "close-button w3-margin-right" :onclick (str:concat "toggleDrag(this,"num")")
				       (:i :class "fa fa-thumb-tack" :aria-hidden "true" :style "font-size:16px;color:green"))

				(:a :href (str:concat "#modal-container" num) :data-uk-toggle "" 
				    
				    (:span :class "w3-right w3-margin-right" 
					   (:i :class "fa fa-gear" :style "font-size:16px"))
				    "")
				(:span :class "w3-right w3-margin-right " :onclick (str:concat "toggleHeader("num")")
				       (:i :class "fa fa-eye-slash" :style "font-size:16px"))

				)))
	   
	   (:div  (:raw window-content))))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;mover a widgets
(defun widget-session-expired()
  (spinneret:with-html-string
    (:div  :class "uk-container"
	   (:br)
	   (:br)
	   (:br)

    (:div :class "uk-card uk-card-default uk-grid-collapse uk-child-width-1-2@s uk-margin uk-grid" :data-uk-grid ""
	  (:div :class "uk-card-media-left uk-cover-container uk-first-column"
		(:img
		 :src "https://aadcdn.msftauthimages.net/dbd5a2dd-zow3gagy6j4ngoqpmmjvfsc-vk1-fc-atq9v6pl2nlq/logintenantbranding/0/illustration?ts=636531167203788632"
		 :alt ""
		 :data-uk-img ""))
	  (:div
	   (:div :class "uk-card-body"
		 (:h3 :class "uk-card-title" "Session Expired")
		 (:p "Please login   "
		     (:a :href "/login" "click Login"))))))))
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun desktop () 
  (spinneret:with-html
    (:div :class "desktop"
	  (:nav :class "uk-navbar-container uk-background-primary"
		(:div :class "uk-navbar uk-background-primary"
		      (:div :class "uk-navbar-center"
			    (:a :class "uk-navbar-toggle"
				;;:data-hx-get "/session-check"
				;;:data-hx-swap "innerHTML"
  				;;:data-hx-target "body"
				;;:data-hx-trigger "every 3600s"
				:data-uk-navbar-toggle-icon "" :href "#"))))
	  
	  (:div :class "uk-child-width-1-2@s uk-grid-match" :data-uk-grid ""
		(:div
		 (:div :class "uk-card uk-card-default uk-card-hover uk-card-body"
		       (:h3 :class "uk-card-title" "Make New Report")
		       (:a :href "#modals-new-report" :class "uk-button  uk-button-text uk-width-1-1"
			   :data-uk-toggle "" "New")))
		(:div
		 (:div :class "uk-card  uk-card-default uk-card-hover uk-card-body"
		       (:h3 :class "uk-card-title" "Load Saved Report")
		       (:button :class "uk-button  uk-button-text uk-width-1-1"
				:data-hx-get "/project-list-reports"
				:data-hx-swap "innerHTML"
				:data-hx-target "#list-report"
				"Open"))))

	  
	  (:div :id "modals-new-report"  :data-uk-modal ""
		(:button :class "uk-modal-close-default" :type "button" :data-uk-close "")
		(:raw (make-new-report)))

	  (:br)
	  (:div :id "list-report" :class "uk-flex-top" )
	  (:ul :class "windows-content" :id "windows-content")

	  (:div :class "hidden" :style "position:absolute;bottom:0;width:1px;height:1px;"
		(:input :class "uk-input" :type "hidden" :id "hiddenTextbox" :name "hiddenTextbox"))
	   

	  )))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun make-new-report()
  (spinneret:with-html-string
    (:div :class "uk-modal-dialog"
    	  (:div :class "uk-card uk-card-body"
   		(:h5 :class "uk-card-title" "New Report Name")
		(:form :id "make-new-report" :class "uk-form-stacked"
		       :data-hx-post "/make-new-report-post"
		       ;;:data-hx-swap "outerHTML"
		       :data-hx-target "#modals-new-report"
		      (:input :class "uk-input"
			      :type "text"
			      :placeholder "NEW REPORT NAME"
			      :style "font-size: 12pt; font-family: Arial;"
			      :id "fname"
			      :name "fname"
			      :required t)
		      (:br)
		      (:br)
		      (:button :class "uk-button uk-button-default" "SEND"))))))


(defun make-form-data-src ()
  (spinneret:with-html-string
    (:div :class "uk-modal-dialog"
    	  (:div :class "uk-card uk-card-body"
   		(:h5 :class "uk-card-title" "URL Data Source")
		(:form :id "url-data-src" :class "uk-form-stacked"
		       :data-hx-post "/process-url-src"
		       ;;:data-hx-swap "beforeend"
		       :data-hx-target "#modals-new-report"
		      (:input :class "uk-input"
			      :type "url"
			      :placeholder "http://your-data-src"
			      :style "font-size: 16pt; font-family: Arial;"
			      :id "urlname"
			      :name "urlname"
			      :required t)
		      (:br)
		      (:button :class "uk-button uk-button-default" "SEND"))))))



(defun produce-url-data-src-form (html)
  (let* ((url (coerce (cdr (car html)) 'string))
         (params-form (quri:uri-query-params (quri:uri url)))
	 (uri (concatenate 'string
			   (quri:uri-scheme (quri:uri url)) "://"
			   (quri:uri-host (quri:uri url))
			   (quri:uri-path (quri:uri url)))))
    
    (spinneret:with-html-string
      (:div :class "uk-modal-dialog"
	    (:div :class "uk-card uk-card-body"
   		  (:h5 :class "uk-card-title" "Form URL Data SRC")		
		  (:form :id "url-data-src" :class "uk-form-stacked"
			 :data-hx-post "/make-from-src-report" 
			 :data-hx-target "#windows-content"
   			 :data-hx-on "htmx:afterRequest: makeProject();"
			
			 (:label :class "uk-form-label"
				 (:b "URL SOURCE"))
			 (:input :class "uk-input" :type "hidden" :name "name" :value "url-src" )
			 (:input :class "uk-input" :type "url" :name "url-src" :value uri  :readonly t)
			 
			 (:input :class "uk-input" :type "hidden" :name "url-src" :value "hidden")
			 (:hr)
			 
			 (:label :class "uk-form-label"
				 (:b "PARAMETERS"))
			 (:br)

			 (dolist (param params-form)
			   (:div :class "w3-container  w3-cell"
				 (:label :class "uk-form-label" (:b "Name"))
				 (:input :class "uk-input"
					 :type "text" :name "name" :value (car param) :readonly t))
			   
			   (:div :class "w3-container  w3-cell"
				 (:label :class "uk-form-label" (:b "Default Value"))
				 (:input :class "uk-input" :name (car param) :type "text" :value (cdr param)))
			   
			   ;; (:div :class "w3-container  w3-cell"
			   ;; 	   (:label :class "uk-form-label" (:b "Optional/Required"))
			   ;; 	   (:select :class "uk-select uk-form-width-small"  :name (car param)
			   ;; 	     (:option :value "" :disabled "selected" "Choose your option")
			   ;; 	     (:option :value "optional" "Optional")
			   ;; 	     (:option :value "required" "Required")))
			   
			   (:div :class "w3-container  w3-cell"
				 (:label :class "uk-form-label" (:b "Html5 data types"))
				 (html-input-types (car param)))
			   (:br))

			 (:div :class "w3-container  w3-cell"
			       (:label :class "uk-form-label" (:b "Name"))
			       (:input :class "uk-input"
				       :type "text" :name "name" :value "auth" :readonly t))
			 
			 (:div :class "w3-container  w3-cell"
			       (:label :class "uk-form-label" (:b "Default Value"))
			       (:div :class "uk-form-controls"
				     (:label (:input :class "uk-radio" :type "radio" :name "auth" :value "1"  )  "Yes")
				     (:br)
				     (:label (:input :class "uk-radio" :type "radio" :name "auth" :value "0" :checked "")  "No")))

			 (:input :class "uk-input" :type "hidden" :name "auth" :value "hidden")
			 (:br) (:br)
			 
			 (:button
			   ;;:data-hx-trigger "confirmed" 
			   ;;:onClick " save();" 
			  :class "uk-button uk-button-default" "SEND")))
	    (:div :id "from-report-result" :class "uk-container")))))


(defun make-form-for-report (hash-table)
  (spinneret:with-html-string
    (:div :class "uk-card uk-card-body"
	  (:div :id "from-report-result" :class "uk-card uk-card-body"
   		(:h5 :class "uk-card-title" "Form Get Data")		

		(:form :id "report-form-src" :class "uk-form-stacked"
		       :data-hx-post "/get-data-from-url-src"
		       :data-hx-swap "none"
		       ;;:data-hx-trigger "click,load delay:1s"
		       ;;:data-hx-target "#data-frame-report-result"
		       (loop for key being the hash-keys of hash-table
                             for value = (gethash key hash-table)
                             collect
			     (unless (string= key "name")
                               (:div 
				(unless (string= (car value) "hidden")
                                  (:label :class "uk-form-label" (:b key)))
                                (:input :class (str:concat "uk-input" )
					:type (car value) :name key :value (car (cdr value))))
                               (:br)))
                       (:button :class "uk-button uk-button-default" "SEND"))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun page-main()
  (spinneret:with-html-string
    (:doctype)
    (:html :class "uk-dark"
     (header)
     (:body
     (desktop)))))



(defun page-root()
  (spinneret:with-html-string
    (:doctype)
    (:html
     (header)
     (:body
      (:raw (widget-session-expired))))))


;;;;;;;;;;;PREVIEW;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun header-preview ()
  (spinneret:with-html
    (:title "Dashboard")
    (:meta :name "viewport" :content "width=device-width, initial-scale=1")
    ;;(:link  :rel "stylesheet"  :href "https://www.w3schools.com/w3css/4/w3.css")
    ;;(:link :rel "stylesheet" :href "https://www.w3schools.com/lib/w3-theme-grey.css")

    (:link  :rel "stylesheet"  :href "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css")
    (:link  :rel "stylesheet"  :href "../static/style.css")
    ;;(:link  :rel "stylesheet"  :href "https://unpkg.com/tabulator-tables@5.5.2/dist/css/tabulator.min.css" )
    (:script :type "text/javascript" :src "https://unpkg.com/tabulator-tables@5.5.2/dist/js/tabulator.min.js")
    (:link  :rel "stylesheet"  :href "../static/table_meterialize.min.css")
    (:link  :rel "stylesheet"  :href "../static/table_materialize.min.css.map")


    (:script :src "https://code.jquery.com/jquery-3.6.0.min.js")
    (:script :src "https://unpkg.com/htmx.org@1.9.4")
    (:script :src "https://cdnjs.cloudflare.com/ajax/libs/ace/1.4.12/ace.js")
    (:script :src "https://cdnjs.cloudflare.com/ajax/libs/ace/1.4.12/ext-language_tools.js")

    (:script :src "//cdn.rawgit.com/Mikhus/canvas-gauges/gh-pages/download/2.1.7/all/gauge.min.js")
    

    (:script :src "https://code.jquery.com/ui/1.13.2/jquery-ui.min.js")
    (:script :src "../static/script.js")

    (:link  :rel "stylesheet"  :href "https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.min.css")
    ;;(:link :rel "stylesheet" :href "https://unpkg.com/material-components-web@latest/dist/material-components-web.min.css" )
    ;;(:script :src "https://unpkg.com/material-components-web@latest/dist/material-components-web.min.js")
    (:link :rel "stylesheet" :href "https://fonts.googleapis.com/icon?family=Material+Icons")
    
    (:link :rel "stylesheet" :href "https://cdn.jsdelivr.net/npm/uikit@3.24.2/dist/css/uikit.min.css" )
    (:script :type "text/javascript" :src "https://cdn.jsdelivr.net/npm/vega@5")
    (:script :type "text/javascript" :src "https://cdn.jsdelivr.net/npm/vega-lite@5")
    (:script :type "text/javascript" :src "https://cdn.jsdelivr.net/npm/vega-embed@6")


    (:link :rel "stylesheet" :href "https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.css" )
    (:script :src "https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.js")


    ;;(:script :src "https://polyfill.io/v3/polyfill.min.js?features=default")
    (:script :src "https://cdn.jsdelivr.net/npm/sweetalert2@11")
    (:script :src "https://unpkg.com/hyperscript.org@0.9.12")

    (:script :src "/static/public/cljs-out/dev-main.js")
    
    (:script :src "https://maps.googleapis.com/maps/api/js?key=AIzaSyB9bZPIs9Pz87A_ahoOztICA6jgD6iOwBE&callback=initMap&libraries=marker&v=beta&libraries=marker"
	     :defer "")
    (:script :src "https://cdn.jsdelivr.net/npm/uikit@3.24.2/dist/js/uikit.min.js")
    (:script :src "https://cdn.jsdelivr.net/npm/uikit@3.24.2/dist/js/uikit-icons.min.js")))
    


(defun build-preview-page ()
  (spinneret:with-html-string
    (:doctype)
     (:html
     (header-preview)
     (:body
      (:div :class "desktop"
	    (:ul :class "windows-content" :id "windows-content"
		 (:raw
		  (get-project-code (get-project-id
				     (hunchentoot:session-value 'user-name)
		                     (hunchentoot:session-value 'project-name))))))))))



(defun build-project-page (x)
  (spinneret:with-html-string
    (:doctype)
    (:html
     (header-preview)
     (:body
      (top-menu)
      (side-bar)
     
      (:div :class "desktop"
	    (:ul :class "windows-content" :id "windows-content"
		  :data-uk-scrollspy "cls: uk-animation-fade; target: .uk-card; delay: 150; repeat: true"
		 (:raw
		  (get-project-code (get-project-id
				     (hunchentoot:session-value 'user-name)
		                     x )))))))))



(defun build-report-page (x)
  (spinneret:with-html-string
    (:doctype)
    (:html
     (header-preview)
     (:body
      (:div :class "desktop"
	    (:ul :class "windows-content" :id "windows-content"
		 (:raw
		  ;;(get-project-code (get-project-id
		  ;;		     (hunchentoot:session-value 'user-name)
		  ;;                   x )

		  (get-project-code x))))))))
				    






