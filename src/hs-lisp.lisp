;; Define la estructura para comandos HyperScript
(defstruct hs-command
  type
  parameters)


;; Macro para crear un comando 'add' en HyperScript
(defmacro hs-add (type element &optional (target nil) (condition nil))
  `(string-downcase
    (concatenate 'string
                 "add "
                 (case ,type
                   (class (concatenate 'string "." (string-downcase ,element)))
                   (attribute (concatenate 'string "@" (string-downcase ,element)))
                   (literal (string-downcase ,element))
                   (otherwise "unknown"))
                 (when ,target
                   (concatenate 'string " to " (string-downcase ,target)))
                 (when ,condition
                   (concatenate 'string " where " (string-downcase ,condition))))))



(defmacro hs-append (element class-name)
  `(string-downcase (concatenate 'string "append " 
                                  (string-downcase ,class-name) " "
                                  (string-downcase ,element))))



;; Macro para crear un comando 'remove-class' y devolver el código HyperScript
(defmacro hs-remove (element class-name)
  `(string-downcase (concatenate 'string "remove " 
                                  (string-downcase ,class-name) " "
                                  (string-downcase ,element))))

;; Macro para crear un comando 'toggle-class' y devolver el código HyperScript
(defmacro hs-toggle (element class-name)
  `(string-downcase (concatenate 'string "toggle " 
                                  (string-downcase ,class-name) " "
                                  (string-downcase ,element))))

;; Macro para crear un comando 'set' y devolver el código HyperScript
(defmacro hs-set (element property value)
  `(string-downcase (concatenate 'string "set " 
                                  (string-downcase ,property) " to "
                                  (string-downcase ,value) " for "
                                  (string-downcase ,element))))

;; Macro para crear un comando 'log' y devolver el código HyperScript
;; Macro para crear un comando 'log' y devolver el código HyperScript
(defmacro hs-log (message)
  `(string-downcase (concatenate 'string "log " (string-downcase ,message))))


;;;;;;eventos
;; Macro para eventos con un comando asociado
;; Macro para eventos con un comando asociado
(defmacro hs-on-event (event element command)
  `(string-downcase (concatenate 'string "on " 
                                  (string-downcase ,event) " "
                                  (string-downcase ,element) " "
                                  ,command)))







(defparameter *contador* (window-number-generator))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun generate-select-script(num)
  "Generates an HTML select element for make hyperscript"
  (spinneret:with-html
    (:br)
      (:button :class "uk-button uk-button-primary uk-flex-right" :id "add-row"
	     :name "script-button"
	     :data-hx-get "/draw-new-input-script"
	     :data-hx-swap "beforeend"
	     :data-hx-target (str:concat "#input-script" num)
	     :data-hx-sync "closest form:queue last"
	     "+")))


(easy-routes:defroute /draw-new-input-script ("/draw-new-input-script" :method :get )()
  (setf (hunchentoot:content-type*) "text/html")
  (let* ((html (hunchentoot:get-parameters*)))
    (generate-inputs-for-script)))

(defun generate-inputs-for-script ()
  (spinneret:with-html-string
	 (:div :class " uk-grid" :data-uk-grid ""
	       (:div :class "uk-width-expand"
		     (:label :class "uk-form-label" "Comparator")
		     (:select :class "uk-select uk-form-width-small" :name "comparator"
		       (:option :value "==" :class "uk-text-large" "=")
		       (:option :value ">" :class "uk-text-large" ">")
		       (:option :value ">=" :class "uk-text-large" "≥")
		       (:option :value "<=" :class "uk-text-large" "≤")
		       (:option :value "<" :class "uk-text-large" "<")))
	       (:div :class "uk-width-expand"
		     (:label :class "uk-form-label" "Val")
		     (:input :type "text" :class "uk-input uk-form-width-small" :placeholder "Enter value" :name "refvalue"))
	       (:div :class "uk-width-expand"
		     (:label :class "uk-form-label" "Color")
		     (:select :class "uk-select uk-form-width-small" :name "color"
		       (:option :value "" :class "uk-text-large")
		       (:option :value ".uk-text-primary" :class "uk-text-primary" "Primary")
		       (:option :value ".uk-text-success" :class "uk-text-success" "Success")
		       (:option :value ".uk-text-warning" :class "uk-text-warning" "Warning")
		       (:option :value ".uk-text-danger" :class "uk-text-danger" "Danger")))
	       (:div :class "uk-width-expand"
		     (:label :class "uk-form-label" "Target")
		     (:select :class "uk-select uk-form-width-small" :name "target"
		       (:option :value "none" :class "uk-text-large" "")
		       (:option :value "icon" :class "uk-text-large" "Icon")
		       (:option :value "body" :class "uk-text-large" "Body")
		       (:option :value "val" :class "uk-text-large" "Value")))
	       ;;(:div :class "uk-width-expand"
		;;     (:label :class "uk-form-label" "")
		 ;;    (:button :class "uk-button uk-button-primary" :id "add-row" "+"))

	       (:div :class "uk-width-expand"
		     (:label :class "uk-form-label" "")
	             (:button :type "button" :class "uk-button uk-button-danger remove-row"
			      :data-script "on click remove closest .uk-grid" "-"))
	       )))




 (proccess-from-script *h*) ;; ok esto esta bien


(defun proccess-from-script (html)
  (let ((clean-list   
	  (car
	   (remove-if 'null
		      (maplist (lambda(x)
				 (if (string= (caar x) "comparator")
				     x
				     nil))
			       html)))))
    (mapcar (lambda (x) (cdr x)) clean-list)))



(mapcar (lambda (index) (nth index *t*)) '(3 7 11 15))


(let ((a *t*))
  (cond
    ((= (length a) 4)  (mapcar (lambda (index) (nth index *t*)) '(0 1 2 3)))
    ((= (length a) 8)  (mapcar (lambda (index) (nth index *t*)) '(1 3 5 7)))
    ((= (length a) 12) (mapcar (lambda (index) (nth index *t*)) '(2 5 8 11)))
    ((= (length a) 16) (mapcar (lambda (index) (nth index *t*)) '(3 7 11 15)))
    (t "Other")))



'(0 1 2 3 1 3 5 7 2 5 8 11 4 9 14 19)


(defun pp (lst)
  (if (or (string= (car lst) "==")
          (string= (car lst) ">")
          (string= (car lst) "<"))
      (cons (list (first lst)
                    (third lst)
                    (fifth lst)
                    (seventh lst))
              (pp (cdr lst)))
    (when (cdr lst)
      (pp (cdr lst)))))




(defun make-script (lst )
  (let* ((comp (first lst))
	 (ref (second lst))
	 (color (third lst))
	 (target (fourth lst))

	 (for-value (str:concat
                    "def rmclass()
                  remove .uk-text-primary
                  end
                  on load
                  rmclass()
                  get the textContent of me
                     if it as Float "comp ref"
                       add "color" to me"))
	
	(for-icon (str:concat
		   "def rmclass()
                  remove .uk-text-primary
                  end
                  on load
                  rmclass()
                  add "color" to previous <i/>" ))
	
         (alert-color
	   (if (> (length color) 0)
	       color
	       ".uk-text-primary"))
	 
	(for-alert (str:concat
		   "init js UIkit.notification({message: '"ref"',pos: 'top-right',status:'"(subseq alert-color 9)"', timeout: 0 })" )))

    (cond ((string= "none"  target) (format nil "" )) 
	  ((string= "icon"  target)(format nil "~a" for-icon))
	  ((string= "val"   target)(format nil "~a" for-value))
	  
	  )
    
    ))

;; "on click toggle between .uk-text-primary and .uk-text-success on me"

;; (defun s-change-value-color(op value color) 
;;   (str:concat
;;    "on load get the textContent of me
;;           then log it
;;           if it as Float "op  value"
;;           toggle between .uk-text-primary
;;           and .uk-text-success on me
;;           else
;;           toggle between .uk-text-primary
;;           and .uk-text-danger on me"

;; 	 ))


;; def rmclass()
;; remove .uk-text-primary
;; end 

;; def mayor()
;; get the textContent of me
;;           then log it
;;           if it as Float  > 5 
;;           toggle between .uk-text-primary
;;           and .uk-text-success on me
;; end
;; def menor()
;; get the textContent of me
;;           then log it
;;           if it as Float < 5 
;;           toggle between .uk-text-primary
;;           and .uk-text-danger on me
;; end

;; ;;;icon change color 
;; def chcoloricon()
;; add .uk-text-primary  to previous <i/>
;; end



;; def s()
;; rmclass()
;; mayor()
;; menor()
;; end
;; on load  s()












