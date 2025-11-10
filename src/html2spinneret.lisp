(in-package :cl-report)

(defun build-sexp (str)
  (labels ((iter (root)
             (cond
               ((plump:text-node-p root)
                (let ((txt (string-trim '(#\Space #\Newline #\Backspace #\Tab 
                                          #\Linefeed #\Page #\Return #\Rubout)
                                        (plump:text root))))
                  (if (equal txt "") "" (format nil " \"~A\"" txt))))
               (t
                (let ((attrs (plump:attributes root)))
                  (format nil "~%(:~A~:{ :~A \"~A\"~}~{~A~})"
                          (plump:tag-name root)
                          (loop for key being the hash-key of attrs
                                for value being the hash-value of attrs
                                collect (list key value))
                          (map 'list #'iter (plump:children root))))))))
    (apply #'concatenate (cons 'string (map 'list #'iter (plump:children (plump:parse str)))))))



(defmacro main-layout (title &body body)
  `(spinneret:with-html-string 
     (:html
      (:head
       (:meta :charset "utf-8")
       (:meta :name "viewport" :content "width=device-width, initial-scale=1")
       (:title ,title)
       (:link :rel "stylesheet" :href "https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css"))
      (:body
       (:section :class "section"
                 (:div :class "container" 
                       ,@body))))))


(define-easy-handler (html-to-lisp :uri "/htmltolisp") (txt-html)
  (let ((txt-html (if txt-html txt-html ""))
        (result
          (if txt-html
              (build-sexp txt-html)
              "")))
    (main-layout "Convert"
      (:h1 :class "title" "Convert HTML to Spinneret")
      (:p :class "subtitle" "Fill the text area with your HTML")
      (:form :action "/htmltolisp" :method "POST"
             (:div :class "field"
                   (:div :class "control"
                         (:textarea :class "textarea" :name "txt-html" (write-string txt-html))))
             (:div :class "control"
                   (:input :class "button" :type "submit")))
      (:div :class "container m-1" (:pre (write-string result))))))
      ;;(:pre (string-to-lisp-code )))))


(defun string-to-lisp-code ()
  (spinneret:interpret-html-tree
   (read (make-string-input-stream *html-result*))))
