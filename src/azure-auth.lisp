

(in-package :cl-report)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Classes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass OpenIDConfiguration ()
  ((issuer :accessor issuer)
   (authorization_endpoint :accessor authorization_endpoint)
   (token_endpoint :accessor token_endpoint)
   (end_session_endpoint :accessor end_session_endpoint)
   (jwks_uri :accessor jwks_uri)
   (response_modes_supported :accessor response_modes_supported)
   (response_types_supported :accessor response_types_supported)
   (scopes_supported :accessor scopes_supported)
   (subject_types_supported :accessor subject_types_supported)
   (id_token_signing_alg_values_supported :accessor token_signing_alg_values_supported)
   (token_endpoint_auth_methods_supported :accessor token_endpoint_auth_methods_supported)
   (claims_supported :accessor claims_supported)))


(defclass JWT ()
  ((nbf :accessor jwt-nbf)
   (c_hash :accessor jwt-c-hash)
   (tfp :accessor jwt-tfp)
   (emails :accessor jwt-emails)
   (family_name :accessor jwt-family-name)
   (extension_MicrotrackUsuarioID :accessor jwt-extension-microtrack-usuario-id)
   (given_name :accessor jwt-given-name)
   (name :accessor jwt-name)
   (auth_time :accessor jwt-auth-time)
   (iat :accessor jwt-iat)
   (nonce :accessor jwt-nonce)
   (exp :accessor jwt-exp)
   (aud :accessor jwt-aud)
   (sub :accessor jwt-sub)
   (iss :accessor jwt-iss)
   (ver :accessor jwt-ver)))

(defmethod user-name ((jwt JWT))
  (car (slot-value jwt 'emails)))

(defmethod nonce ((jwt JWT))
  (slot-value jwt 'nonce))

(defmethod expire-session ((jwt JWT))
      (slot-value jwt 'exp))

(defmethod c-hash ((jwt JWT))
  (slot-value jwt 'c_hash))





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Additional Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun make-api-url* (scope)
  (construct-api-endpoint-url
   :endpoint (token_endpoint *openid-config*)
   :grant_type "authorization_code"
   :client-id *client-id*
   :response-type "token"
   :redirect-uri "http://localhost:8000/getAToken"
   :response-mode "form_post"
   :scope scope
   :prompt "none"))


(defun make-api-url (scope)
  (construct-api-endpoint-url
   :token-endpoint "https://mtkb2c.b2clogin.com/tfp/mtkb2c.onmicrosoft.com/b2c_1_ropc/oauth2/v2.0/token"
   :grant_type "password"
   :client-id *client-id*
   :response-type "token"
   :redirect-uri "http://localhost:8000/getAToken"
   :response-mode "form_post"
   :scope scope
   :policy "ropc"
   :prompt "none"))



;; no se usa por ahora

;; (defun get-api-token-access-cli-secret(api-url code client-secret)
;;  (let ((respuesta
;;          (yason:parse   
;; 	  (dex:post api-url 
;; 		    :headers '(("x-client-sku". "MSAL.Python")
;; 			       ("Content-Type" . "application/x-www-form-urlencoded")
;; 			       ("x-client-ver". "1.22.0")
;; 			       ("x-client-os" . "linux")
;; 			       ("x-client-cpu" . "x64")
;; 			       ("x-ms-lib-capability" . "retry-after, h429"))
;; 		    :content `(("client_info" . "1") 
;; 			       ("client_secret" . ,client-secret)
;; 			       ("code" . ,code)))
;; 	  :object-as :hash-table)))
;;    respuesta))



(defun get-api-token-access (api-url code username password)
  (let ((respuesta
          (yason:parse   
	   (dex:post api-url 
		     :headers '(("x-client-sku". "MSAL.Python")
				("Content-Type" . "application/x-www-form-urlencoded")
				("x-client-ver". "1.22.0")
				("x-client-os" . "linux")
				("x-client-cpu" . "x64")
				("x-ms-lib-capability" . "retry-after, h429"))
		     :content `(("client_info" . "1")
				("username" . ,username)
				("password" . ,password)
			        ("code" . ,code)))
	   :object-as :hash-table)))
    respuesta))



(defun get-call-api-data (url-api access-token)
  (let* ((url url-api)  
         (headers `(("Authorization" . ,(format nil "Bearer ~A" access-token))))
	 (yason:*parse-json-arrays-as-vectors* t)
         (yason:*parse-json-booleans-as-symbols* t)
         (response
	   (handler-case (dex:get url :headers headers)
	     (dex:http-request-failed (e)
	       (format *error-output* "The server returned ~D" (dex:response-status e))
	       (get-call-api-data url-api (hunchentoot:session-value 'refresh_token))))
	   
	   ))
    response))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Helper Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun select-random-item (seq)
  (elt seq (random (length seq))))

(defun random-string (&optional (len 16))
  (map 'string (lambda (_) (select-random-item *charset*)) (make-string len)))

(defun create-openid-configuration (response)
  (let ((config (make-instance 'OpenIDConfiguration)))
    (dolist (entry response)
      (destructuring-bind (key . value) entry
        (setf (slot-value config (intern (string-upcase key) "MYPROJECT")) value)))
    config))

(defun get-openid-configuration (tenant-name user-flow)
  (let* ((url (format nil "https://~a.b2clogin.com/~a.onmicrosoft.com/~a/v2.0/.well-known/openid-configuration" tenant-name tenant-name user-flow))
         (response (yason:parse (dex:get url) :object-as :alist)))
    response))

(defun set-openid-config ()
  (setf *openid-config*
        (create-openid-configuration
         (get-openid-configuration *tenant-name* *user-flow*))))


(defun auth-token (id_token openid-config)
  (setf *jwt*
	(unpack-and-check-jwt id_token (get-openid-key openid-config))))


(defun construct-auth-endpoint-url (&key endpoint client-id response-type redirect-uri response-mode scope)
  (let ((state (random-string 16))
        (nonce (random-string 16)))
    (format nil "~A?client_id=~A&response_type=~A&redirect_uri=~A&response_mode=~A&scope=~A&state=~A&nonce=~A"
            endpoint client-id response-type redirect-uri response-mode scope state nonce)))


(defun construct-api-endpoint-url (&key token-endpoint grant_type client-id response-type redirect-uri response-mode scope policy prompt)
  (let* ((state (random-string 16))
         (nonce (random-string 16)))
    (format nil
            "~A?grant_type=~A&client_id=~A&policy=~A&response_type=~A&redirect_uri=~A&response_mode=~A&scope=~A&state=~A&nonce=~A&prompt=~A"
            token-endpoint grant_type client-id policy response-type redirect-uri response-mode scope state nonce prompt)))



(defun get-openid-key (openid-config)
  (let ((url (jwks_uri openid-config)))
    (car (gethash "keys" (yason:parse (dex:get url))))))

(defun unpack-and-check-jwt (id-token public-key)
  (handler-case
      (let* ((jwt-data
	       (if (jose:verify :rs256 (jwk-to-rsa-key public-key) id-token)
                   (multiple-value-bind (tokinfo keyinfo _)
		       (jose:inspect-token id-token)
		     (declare (ignore keyinfo))
		     (declare (ignore _))
		     tokinfo)
                   (error "not valid key")))
	     (config (make-instance 'JWT)))
	(dolist (entry jwt-data)
	  (destructuring-bind (key . value) entry
	    (setf (slot-value config (intern (string-upcase key) "MYPROJECT")) value)))
	config)
    (error ()
      (hunchentoot:redirect "/login")
      'error)))
    


(defun jwk-to-rsa-key (jwk)
  "Convertir una clave JWK a clave RSA pública."
  (assert (equal (gethash "kty" jwk) "RSA")
          nil
          "Solo se admite el tipo de clave RSA.")
  (let* ((modulus-b64 (gethash "n" jwk))
         (modulus (jose/base64:base64url-decode modulus-b64))
         (exponent-b64 (gethash "e" jwk))
         (exponent (jose/base64:base64url-decode exponent-b64)))
    (ironclad:make-public-key :rsa
			      :n (ironclad:octets-to-integer modulus)
			      :e (ironclad:octets-to-integer exponent))))




;;;;;;;;;;;;;;;;;;;;;CALL API ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun make-fn-get-events-from-api (html)
  (if (string= "1" (assoc-path html '("auth")))
      (call-api-with-auth  html)
      (call-api-without-auth  html)))
      

;;; base de datos de apis con 3 campos url, cliente secret  y scope de la api  
(defun get-api-token ()
  ;;SOCPE DE LA API "https://mtkb2c.onmicrosoft.com/webapivehiculos/user_impersonation+offline_access"
  (let* ((api-url (make-api-url "https://mtkb2c.onmicrosoft.com/webapivehiculos/user_impersonation+offline_access"))
	 (response
	   (handler-case (get-api-token-access api-url (hunchentoot:session-value 'code) *username* *password*)
	     (dex:http-request-bad-request ()
	       ;; Runs when 400 bad request returned
	       (hunchentoot:redirect "/error"))
	     (dex:http-request-failed (e)
	       ;; For other 4xx or 5xx
	       (hunchentoot:redirect "/error")
	       (format *error-output* "The server returned ~D" (dex:response-status e))))))
    (setf (hunchentoot:session-value 'refresh_token)
	  (gethash "refresh_token" response))

    (setf (hunchentoot:session-value 'access_token)
	  (gethash "access_token" response))))  
  


(defun call-api-with-auth (html)
  (let* ((clean-params (remove-if (lambda (pair) (string= "" (cdr pair))) (cdr html)))
	 (params (butlast (cdr html)))
	 (url-get (quri:make-uri :defaults (cdr (car html)) :query params)))
    (get-api-token)
    (get-call-api-data url-get (hunchentoot:session-value 'access_token))))



(defun call-api-without-auth (html)
  (let* ((params (remove-if (lambda (pair) (string= "" (cdr pair))) (cdr html)))
	 (url-get (quri:make-uri :defaults (cdr (car html)) :query params))
         (yason:*parse-json-booleans-as-symbols* t)
	 (respuesta
	   (yason:parse
            (dex:get url-get
                     :keep-alive t
                     :use-connection-pool t
                     :connect-timeout 60
                     :want-stream t))))
    respuesta))




;; (defun create-jwt (jwt-data)
;;   (let ((config (make-instance 'JWT)))
;;     (dolist (entry jwt-data)
;;       (destructuring-bind (key . value) entry
;;         (setf (slot-value config (intern (string-upcase key))) value)))
;;     config))


(defun get-nonce (id-token)
   (assoc-path (jose:inspect-token id-token) '("nonce")))


 (defun get-user-name (id-token)
   (car (assoc-path (jose:inspect-token id-token) '("emails"))))


(defun expired-session (id-token)
  (let ((exp (local-time:unix-to-timestamp
	      (assoc-path (jose:inspect-token id-token) '("exp"))))
	(now  (local-time:now)))
    
    (if (local-time:timestamp<= exp now)
	t
	nil)))
