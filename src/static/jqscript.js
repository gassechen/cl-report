$(document).ready(function () {
  // Inicializar el comportamiento de arrastrar con jQuery UI
    //$(".drag-handle").draggable();
    $(".drag-handle").on("mouseenter", function () {
    // Inicializar el comportamiento de arrastrar
    $(this).parent().draggable();
  });

  // Función para ocultar/mostrar header y footer
  function toggleHeaderAndFooter() {
    $("header, footer").toggle();
  }

  // Función para eliminar etiquetas footer
  function eliminarEtiquetasFooter() {
    $("footer").remove();
  }

  // Función para eliminar etiquetas header
  function eliminarEtiquetasHeader() {
    $("header").remove();
  }

  // Llama a la función para ocultar/mostrar header y footer
  $("button.toggle").on("click", toggleHeaderAndFooter);

  // Llama a la función para eliminar etiquetas footer
  $("button.eliminar-footer").on("click", eliminarEtiquetasFooter);

  // Llama a la función para eliminar etiquetas header
  $("button.eliminar-header").on("click", eliminarEtiquetasHeader);
});
