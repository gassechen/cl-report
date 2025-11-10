(asdf:defsystem "cl-report"
  :version "0.1"
  :author ""
  :license "WTFPL"
  :depends-on (:cl-slug
               :local-time
               :cl-ppcre
               :hunchentoot
               :easy-routes
               :log4cl
	       :alexandria
	       :yason
	       :dexador
	       :cl-csv
	       :cl-date-time-parser
	       :spinneret
	       :spinneret/ps
	       :parenscript
	       :mito
	       :sxql
	       :cl-json
	       :lisp-stat 
	       :data-frame
	       :quri
	       :jose
	       :ironclad
	       :cl-base64
	       :jose/jwt
	       :plot
	       :plump
	       :plot/vega
               :str
      	       :sqldf
       	       :swank
               :json-to-df)

  
  :components ((:module "src"
                :components
                ((:file "cl-report")
		 (:file "azure-auth")
		 (:file "db")
		 (:file "routes")
		 (:file "ui")
		 (:file "buildIn-fn")
		 (:file "widgets")
		 (:file "process-json")
		 (:file "server")
		 (:file "html2spinneret")
		 (:file "icons"))))


    ;; To build a binary:
  :build-operation "program-op"
  :build-pathname "cl-report"
  :entry-point "cl-report::main"

  :description "A web template"
  ;; :long-description
  ;; #.(read-file-string
  ;;    (subpathname *load-pathname* "README.md"))
  :in-order-to ((test-op (test-op "cl-report-test"))))

;; Smaller binary.
#+sb-core-compression
(defmethod asdf:perform ((o asdf:image-op) (c asdf:system))
  (uiop:dump-image (asdf:output-file o c) :executable t :compression t))

