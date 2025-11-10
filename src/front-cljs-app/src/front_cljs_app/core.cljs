(ns ^:figwheel-hooks front-cljs-app.core
  (:require
   [goog.dom :as gdom]
   [goog.dom.classlist :as classlist]
   [goog.events :as gevents]
   [reagent.core :as reagent :refer [atom]]
   [reagent.dom :as rdom]))


(defn multiply [a b]
  (* a b))

(println "Reloading in action....")





;;;;;;;;;;; Estado para controlar si el contenido es editable o no;;;;;;;;;;;;;;;;;;;;;;;;;
(def is-editable (atom false))

(defn edit-content-on []
  ;; Implementación para activar el modo editable
  (js/console.log "Activando modo editable")
  ;; Seleccionar todos los elementos <h5> dentro de .resizable-card
  (let [h5-elements (.querySelectorAll js/document ".resizable-card h5")
        label-elements (.querySelectorAll js/document  ".resizable-card label")
        button-elements (.querySelectorAll js/document  "tab-widget button")]

    ;; Establecer contentEditable en true para todos los <h5>
    (doseq [h5 (array-seq h5-elements)]
      (set! (.-contentEditable h5) true)
      (classlist/add h5 "editable"))
    ;; Establecer contentEditable en true para todos los <label>
    (doseq [label (array-seq label-elements)]
      (set! (.-contentEditable label) true)
      (classlist/add label "editable"))

    ;; Establecer contentEditable en true para todos los <button>
    (doseq [button (array-seq button-elements)]
      (set! (.-contentEditable button) true)
      (classlist/add button "editable"))))


(defn edit-content-off []
  ;; Implementación para desactivar el modo editable
  (js/console.log "Desactivando modo editable")
  (let [editable-elements (.querySelectorAll js/document "[contenteditable='true']")]
    (doseq [elm (array-seq editable-elements)]
      (js/console.log elm )
      (set! (.-contentEditable elm) false)
      (classlist/remove elm "editable"))))


(defn toggle-edit-content []
  (swap! is-editable not)
  (if @is-editable
    (edit-content-on)
    (edit-content-off)))
;; Exporta la función para que esté disponible en el ámbito global de JavaScript
(goog/exportSymbol "toggleEditContent" toggle-edit-content)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defn close-windows [window-number]
  (let [modal (gdom/getElement (str "modal-container" window-number))]
    (when modal
      (gdom/removeNode modal)))
    (let [win (gdom/getElement (str "w3-card" window-number))]
      (when win
        (gdom/removeNode win))))


(goog/exportSymbol "closeWindows" close-windows)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; --- Estado global para manejar la paginación ---
(defonce app-state (reagent/atom {:current-page 1
                                  :rows-per-page 5}))


;; Función para obtener las filas de la tabla HTML
(defn get-table-rows [id]
  (let [table (.getElementById js/document id)
        rows (.querySelectorAll table "tbody tr")]
    (vec (js/Array.from rows))))



;; Función para mostrar solo las filas de la página actual
(defn display-rows [rows id ]
  (let [rows-per-page (:rows-per-page @app-state)
        current-page (:current-page @app-state)
        start (* rows-per-page (dec current-page))
        end (+ start rows-per-page)]
    ;; Ocultar todas las filas
    (doseq [row rows] (set! (.-style.display row) "none"))
    ;; Mostrar solo las filas en el rango correspondiente a la página
    (doseq [row (subvec rows start end)]
      (set! (.-style.display row) "table-row" ))))


;; Función para crear y actualizar la paginación con estilo UIkit
(defn update-pagination [container-id]
  (let [rows (get-table-rows container-id)
        total-rows (count rows)
        rows-per-page (:rows-per-page @app-state)
        total-pages (Math/ceil (/ total-rows rows-per-page))
        pagination-div (.getElementById js/document "pagination-controls")]
    ;; Limpiar el div de paginación existente
    (when pagination-div
      (.removeChild (.getElementById js/document container-id) pagination-div))
    (let [new-pagination-div (.createElement js/document "div")]
      (set! (.-id new-pagination-div) "pagination-controls")
      (set! (.-className new-pagination-div) "uk-margin uk-flex-center uk-flex")
      ;; Añadir el div al contenedor fuera de la tabla
      (.appendChild (.getElementById js/document "pagination-container") new-pagination-div)
      ;; Calcular el rango de páginas a mostrar
      (let [max-buttons 5
            half-range (quot max-buttons 2)
            start-page (max 1 (- (:current-page @app-state) half-range))
            end-page (min total-pages (+ (:current-page @app-state) half-range))]
        ;; Crear botones de paginación dinámicamente
        (doseq [page (range start-page (inc end-page))]
          (let [btn (.createElement js/document "button")]
            (set! (.-innerText btn) page)
            (set! (.-className btn) "uk-button uk-button-default uk-margin-small-right")
            ;; Añadir el evento de clic para cambiar de página
            (.addEventListener btn "click"
              (fn []
                (reset! app-state (assoc @app-state :current-page page))
                (display-rows rows container-id)))
            ;; Añadir el botón al div de paginación
            (.appendChild new-pagination-div btn)))))))
  
;; Función principal que inicializa la tabla y genera paginación
(defn init-table [id]
  (display-rows (get-table-rows id) id)
  (update-pagination id))



(init-table "#table-data1825")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






(defn mount [el]
  (js/console.log "Mountin app"))

(defn mount-app-element []
  (when-let [el nil]
    (mount el)))

;; conditionally start your application based on the presence of an "app" element
;; this is particularly helpful for testing this ns without launching the app
(mount-app-element)

;; specify reload hook with ^:after-load metadata
(defn ^:after-load on-reload []
  (mount-app-element)
  ;; optionally touch your app-state to force rerendering depending on
  ;; your application
  ;; (swap! app-state update-in [:__figwheel_counter] inc)
)
