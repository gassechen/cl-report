(in-package :cl-report)

;; Configurar la conexión a la base de datos
;;(defvar *connection* (mito:connect-toplevel :sqlite3 :database-name "db-projects"))

(defun connect-db ()
  (mito:connect-toplevel :sqlite3 :database-name (merge-pathnames "db-projects"
                                                                (asdf:system-source-directory :cl-report))))

;; Definir la clase que representa la tabla projects
(defclass project ()
  ((user-name
    :col-type (:varchar 64)
    :initarg :user-name
    :accessor user-name)
   (project-name
    :col-type (:varchar 64)
    :initarg :project-name
    :accessor project-name)
   (project-code
    :col-type :text
    :initarg :project-code
    :accessor project-code))
  (:metaclass mito:dao-table-class))


(defun create-project (user-name project-name project-code)
  "Crea un nuevo proyecto con los detalles proporcionados."
  (mito:save-dao (make-instance 'project
                                :user-name user-name
                                :project-name project-name
                                :project-code project-code)))

(defun get-project-id (user-name project-name)
  "Devuelve el project-code de un proyecto dado el user-name y project-name."
  (let ((project (first (mito:select-dao 'project()
                                         (sxql:where (:and (:= :user-name user-name)
                                                     (:= :project-name project-name)))))))
    (when project
      (mito:object-id project))))


(defun get-all-project-user (user-name)
  "Devuelve todos los IDs de los proyectos dado el user-name."
  (let ((projects (mito:select-dao 'project
                                   (sxql:where (:= :user-name user-name)))))
    (mapcar #'mito:object-id projects)))



(defun get-project-by-id (id)
  "Obtiene un proyecto por su ID."
  (mito:find-dao 'project :id id))

(defun get-all-projects ()
  "Obtiene todos los proyectos."
  (mito:select-dao 'project))

(defun update-project (id project-code)
  "Actualiza un proyecto existente con los detalles proporcionados."
  (let ((proj (mito:find-dao 'project :id id)))
    (when proj
      (setf (project-code proj) project-code)
      (mito:save-dao proj))))


(defun delete-project (id)
  "Elimina un proyecto por su ID."
  (let ((proj (mito:find-dao 'project :id id)))
    (when proj
      (mito:delete-dao proj))))


(defun get-project-code (id)
  "Devuelve el project-code de un proyecto dado el user-name y project-name."
  (let ((project (mito:find-dao 'project :id id)))
    (when project
      (project-code project))))


(defun get-project-name (id)
  "Devuelve el project-code de un proyecto dado el user-name y project-name."
  (let ((project (mito:find-dao 'project :id id)))
    (when project
      (project-name project))))







;; (defparameter *db* (make-instance 'mito:sqlite3 :database-name "projects.db"))





;; (defvar *connection* (mito:connect-toplevel :sqlite3 :database-name "myapp"))


;; (defun connect ()
;;   "Connect to the DB."
;;   (mito:connect-toplevel :sqlite3 :database-name "myapp"))


;; (mito:deftable projects ()
;;   ((name :col-type (:varchar 64))
;;    (email :col-type (or (:varchar 128) :null))
;;    (project-name :col-type (:varchar 64))
;;    (code-project :col-type (:varchar 512))))


;; (defvar me
;;   (make-instance 'project :name "Eitaro Fukamachi" :email "e.arrows@gmail.com" :project-name "test project" :code-project "(+ 1 2 3)"))

;; (mito:create-dao 'projects :name "Eitaro Fukamachi" :email "e.arrows@gmail.com" :project-name "test project" :code-project "(+ 1 2 3)" )



;; (mito:insert-dao me)



;; (defvar *connection* (mito:connect-toplevel :mysql :database-name "satelital" :username "root" :password "pl,okmijn"))


;; (mito:deftable conf-satelital-payload ()
;;   ((ent-id :col-type (:integer) :primary-key t :not-null t)
;;    (vigenciahastaconf :col-type (:datetime) :null t)
;;    (serieeqp :col-type (:varchar 50) :not-null t)
;;    (param-nro :col-type (:integer) :not-null t)
;;    (nombreparametro :col-type (:varchar 150) :not-null t)
;;    (posicionini :col-type (:integer) :not-null t)
;;    (largo :col-type (:integer) :not-null t)
;;    (tipodato :col-type (:varchar 50) :not-null t)
;;    (multiplicador :col-type (:integer) :not-null t :default 1)
;;    (divisor :col-type (:integer) :not-null t :default 1)
;;    (unidad :col-type (:varchar 50) :null t)
;;    (tipomensaje :col-type (:varchar 150) :not-null t)
;;    (orden :col-type (:integer) :not-null t)
;;    (condiparamnro :col-type (:integer) :null t)
;;    (condiparamvalor :col-type (:integer) :null t)))


;; (mito:deftable entidad-payload ()
;;   ((ent-id :col-type (:integer) :not-null t)
;;    (fecha :col-type (:datetime) :not-null t)
;;    (fecha-reg :col-type (:datetime) :not-null t)
;;    (payload :col-type (:varchar 500) :not-null t)
;;    (mensajeudp :col-type (:text) :not-null t)
;;    (lat :col-type (:integer) :null t)
;;    (lon :col-type (:integer) :null t)))
  

;; (defun select-cantidad-horas (&optional (hours 24))
  
;;       (select-dao 'entidad-payload()
;; 	(sxql:where (:> :fecha
;; 			(local-time:format-timestring  nil (local-time:timestamp- (local-time:now) hours :hour))))))


;; (defun select-cantidad-dias (&optional (dias 7))
  
;;       (select-dao 'entidad-payload()
;; 	(sxql:where (:> :fecha
;; 			(local-time:format-timestring  nil (local-time:timestamp- (local-time:now) dias :day))))))


;; (defun select-cantidad-meses (&optional (meses 1))
  
;;       (select-dao 'entidad-payload()
;; 	(sxql:where (:> :fecha
;; 			(local-time:format-timestring  nil (local-time:timestamp- (local-time:now) meses :month))))))



;; (defun select-rango-fechas (fecha-ini fecha-fin)
;;      (select-dao 'entidad-payload()
;; 	(sxql:where (:and
;; 		     (:> :fecha fecha-ini)
;; 		     (:< :fecha fecha-fin)))))

;; ;;(dolist (x (select-cantidad-horas 174)) 
;; ;;  (search 'Unidad Nitrogeno' (slot-value x 'mensajeudp)))
		

