

//////////////////////////////////////WINDOWS////////////////////////////////////

function dragResize() {
    $('.resizable-card').draggable({

	containment: "#windows-content",
        start: function(event, ui) {
            // Cuando comienza a arrastrar, establece el z-index más alto
	    
	    $(this).css('z-index', 9999);
        },
        stop: function(event, ui) {
            // Cuando se detiene el arrastre, restaura el z-index predeterminado
            $(this).css('z-index', '');
	    
        }
	
    }).resizable({
        start: function(event, ui) {
            // Cuando comienza a redimensionar, establece el z-index más alto
            $(this).css('z-index', 9999);
        },
        stop: function(event, ui) {
            // Cuando se detiene la redimensión, restaura el z-index predeterminado
            $(this).css('z-index', '');
        }
    });
}


function makeDroppable(){

    const elem = document.querySelectorAll('[id^="droppable"]');

    elem.forEach((element) => {
	// Extraer la parte numérica del ID actual, considerando el nuevo formato "droppableX-Y"
	const number = element.id.match(/\d+-\d+/)[0];
	const innerSelector = `#droppable-inner${number}`;

	// Verifica si el innerSelector existe en el DOM
	if (document.querySelector(innerSelector)) {
	    console.log(`Applying configureDroppable to: ${element.id} with innerSelector: ${innerSelector}`);
	    configureDroppable(`#${element.id}`, innerSelector);
	} else {
	    console.warn(`Element not found for innerSelector: ${innerSelector}`);
	}
    });

}


function configureDroppable(selector, innerSelector) {
    $(selector).droppable({
        greedy: true,
        tolerance: "pointer",
        classes: {
            "ui-droppable-active": "ui-state-active",
            "ui-droppable-hover": "ui-state-hover"
        },
        over: function(event, ui) {
	    $(".ui-droppable").addClass("expanded");
	    
        },
        out: function(event, ui) {
	    $(".ui-droppable").removeClass("expanded");
            
            
        },
        drop: function(event, ui) {
            $(ui.draggable).detach().css({top: 150, left: 150}).appendTo(innerSelector);
	    $(".ui-droppable").removeClass("expanded");
	    
        }
    });
}

// Función para minimizar una ventana
function minimizeWindow(windowNumber,windowName) {
    const minimizedWindows = document.getElementById('minimized-windows');
    const window = document.querySelector(`#w3-card${windowNumber}`);
    window.style.display = "none";

    // Crear un elemento de ventana minimizada
    const minimizedWindow = document.createElement('div');
    minimizedWindow.classList.add('minimized-window');
    minimizedWindow.innerText = `${windowName}`;
    minimizedWindow.onclick = function () {
        window.style.display = "block";
        minimizedWindows.removeChild(minimizedWindow);
    };

    minimizedWindows.appendChild(minimizedWindow);
}


function closeWindow(windowNumber)
{
    const modal = document.querySelector(`#modal-container${windowNumber}`);
    if ( modal !== null )
    {
	modal.remove();
	modal.style.display = "none";
    }
   
    const win = document.querySelector(`#w3-card${windowNumber}`);
    win.remove();
    win.style.display = "none";
    
}


function toggleDrag(button,windowNumber){
    
    let element = $(`#w3-card${windowNumber}`);
    let icon = button.querySelector('i'); 

    if (element.draggable("option", "disabled")) {
        element.draggable("enable");
        icon.style = "font-size:16px;color:green";
    } else {
        element.draggable("disable");
	icon.style = "font-size:16px;color:red";
        
    }
}


function toggleHeader(windowNumber) {
    const header = document.querySelector(`#w3-card${windowNumber} .uk-card-header`);
    const eyeIcon = document.querySelector(`#w3-card${windowNumber} .eye-icon`);
    const footer = document.querySelector(`#w3-card${windowNumber} .uk-card-footer`);
    if (header.hidden) {
        header.hidden = false;
	footer.hidden = false
	
        eyeIcon.style.display = 'none';
	eyeIcon.style.opacity = '0%';
    } else {
        header.hidden = true;
	footer.hidden = true;
        eyeIcon.style.display = 'block';
	eyeIcon.style.opacity = '100%';
    }
}



function MenuAccordion(id) {
  var x = document.getElementById(id);
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
    x.previousElementSibling.className = 
    x.previousElementSibling.className.replace("w3-black", "w3-grey");
  } else { 
    x.className = x.className.replace(" w3-show", "");
    x.previousElementSibling.className = 
    x.previousElementSibling.className.replace("w3-grey", "w3-black");
  }
}


function toggleHeaderAndFooter() {
    // Selecciona todas las etiquetas <header> y <footer> en la página
    var etiquetasHeader = document.getElementsByTagName("header");
    var etiquetasFooter = document.getElementsByTagName("footer");
    const h5Elements = document.querySelectorAll('h5,h3');
    const labelElements = document.querySelectorAll('label');
    var iconResize = document.querySelectorAll('.ui-icon.ui-icon-gripsmall-diagonal-se');

    // Recorre todas las etiquetas <header> y <footer> y cambia su estilo para ocultarlos o mostrarlos
    for (var i = 0; i < etiquetasHeader.length; i++) {
	var etiquetaHeader = etiquetasHeader[i];
	if (etiquetaHeader.style.display === "none" || etiquetaHeader.style.display === "") {
	    etiquetaHeader.style.display = "block"; // Mostrar
	    // Establece contentEditable en true para todos los <h5>
	    h5Elements.forEach(function (h5) {
		h5.contentEditable = false;
	    });

	    labelElements.forEach(function (label) {
		label.contentEditable = false;
	    });

	    iconResize.forEach(function(iconResize) {
		// Tu lógica aquí, por ejemplo, cambiar la visibilidad
		iconResize.style.visibility = "";
	    });

	    
	    
	} else {
	    etiquetaHeader.style.display = "none"; // Ocultar
	    
	    // Establece contentEditable en true para todos los <h5>
	    h5Elements.forEach(function (h5) {
		h5.contentEditable = true;
	    });

	    labelElements.forEach(function (label) {
		label.contentEditable = true;
	    });

	    iconResize.forEach(function(iconResize) {
		// Tu lógica aquí, por ejemplo, cambiar la visibilidad
		iconResize.style.visibility = "hidden";
	    });


	    

	}
    }

    for (var i = 0; i < etiquetasFooter.length; i++) {
	var etiquetaFooter = etiquetasFooter[i];
	if (etiquetaFooter.style.display === "none" || etiquetaFooter.style.display === "") {
	    etiquetaFooter.style.display = "block"; // Mostrar
	    

	} else {
	    etiquetaFooter.style.display = "none"; // Ocultar
	    
	}
    }

    
}



/////////////////////////////////////////////////////////////////////////////////////


///////////////////////////////SAVE-MAKE-PROJECT/////////////////////////////////////////////////


async function makeProject(){
    document.querySelector('.uk-modal').remove();
    await save();
    location.reload();
}



function removeDuplicates(){

    // Obtener todos los elementos con el id "hidden-forms"
    const elements = document.querySelectorAll('#hidden-forms');

    // Convertir la NodeList en un array para poder trabajar con ella
    const elementsArray = Array.from(elements);

    // Encontrar el elemento con el mayor número de hijos
    const elementWithMostChildren = elementsArray.reduce((maxElement, currentElement) => {
	return currentElement.childElementCount > maxElement.childElementCount ? currentElement : maxElement;
    }, elementsArray[0]);

    // Eliminar los elementos que no son el que tiene más hijos
    elementsArray.forEach(element => {
	if (element !== elementWithMostChildren) {
            element.remove(); // Eliminar del DOM
	}
    });

    // Mostrar el elemento que quedó
    console.log('Elemento con más hijos que se mantuvo:', elementWithMostChildren);

}




async function save() {
    const ukModals = document.querySelectorAll('.uk-modal');

    // Inicializar una cadena vacía para concatenar el contenido
    let concatenatedContent = '';
    let hiddenDivHTML = '';

    // Iterar sobre la NodeList y concatenar el contenido HTML de cada elemento
    ukModals.forEach(modal => {
        concatenatedContent += modal.outerHTML;
    });

    // Crear el contenido concatenado con los estilos en línea
    hiddenDivHTML = '<div id="hidden-forms" class="hidden" style="position:absolute;bottom:0;width:1px;height:1px;">' + concatenatedContent + '</div>';

    // Asignar la cadena concatenada al valor del elemento de entrada
    //document.getElementById("hiddenTextbox").value = document.getElementById("windows-content").outerHTML + hiddenDivHTML;

    let hiddenContent = document.getElementById("windows-content").innerHTML + hiddenDivHTML;

    await fetch('/save-test', {
        method: 'POST',
        headers: {
            'Content-Type': 'text/html'
        },
        body: hiddenContent
    })
        .then(response => response.text())
        .then(data => {
	    alert_fire("Saving")
            console.log('Success:', data);
        })
        .catch((error) => {
	    alert_fire("Error")
            console.error('Error:', error);
        });

}

function saveSelectedOptions() {
    const selectElements = document.querySelectorAll('.uk-select');

    selectElements.forEach(select => {
        select.addEventListener('change', function() {
            // Obtiene la opción actualmente seleccionada
            const selectedOption = this.value;

            // Recorre todas las opciones y elimina el atributo 'selected'
            this.querySelectorAll('option').forEach(option => {
                option.removeAttribute('selected');
            });

            // Establece el atributo 'selected' en la opción elegida
            const chosenOption = this.querySelector(`option[value="${selectedOption}"]`);
            if (chosenOption) {
                chosenOption.setAttribute('selected', 'selected');
            }

            // Puedes hacer lo que desees con la opción seleccionada
            console.log('Opción seleccionada:', selectedOption);
        });
    });
}

function saveCheckedOptions() {
    // Selecciona todos los checkboxes con la clase 'uk-checkbox'
    const checkboxElements = document.querySelectorAll('.uk-checkbox');

    checkboxElements.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            // Obtiene el estado actual del checkbox (checked o no)
            const isChecked = this.checked;

            // Imprime el atributo checked en el HTML
            if (isChecked) {
                this.setAttribute('checked', 'checked');
            } else {
                this.removeAttribute('checked');
            }

            // Puedes hacer lo que desees con el estado del checkbox
            console.log('Checkbox con valor:', this.value, 'está', isChecked ? 'seleccionado' : 'no seleccionado');
        });
    });
    
}





///////////////////////////////END-SAVE-MAKE-PROJECT/////////////////////////////////////////////////








//////////////////////////////EDITOR////////////////////////////////////////////////

// Función para inicializar el editor Ace en una ventana específica

//////ACE EDITOR ////////////////////////////////////
function initializeAceEditorInWindow() {
    var editor = ace.edit("editor");
    // Configura el tema del editor (puedes elegir un tema que te guste)
    editor.setTheme("ace/theme/sqlserver");
    // Configura el modo de resaltado de sintaxis para el lenguaje que desees
    // Por ejemplo, para JavaScript:
    editor.session.setMode("ace/mode/sql");
    editor.resize();

    // Otras opciones configurables (opcional):
    editor.setOptions({
        enableBasicAutocompletion: true,
        enableSnippets: true,
        enableLiveAutocompletion: true
    });
    
    document.getElementById('editor').style.fontSize='16px';

    // Escucha eventos de cambio en el editor

    editor.getSession().on('change', function() {
	// Obtén el contenido actual del editor
	var editorContent = editor.getValue();
	
	// Actualiza el valor del campo oculto con el contenido del editor
	document.getElementById("editorContent").value = editorContent;
    });
}

///////////////////MI EDITOR //////////////////////////////////

function editContentOn() {
    const h5Elements = document.querySelectorAll('.resizable-card h5');
    const labelElements = document.querySelectorAll('.resizable-card label');
    const buttonElements = document.querySelectorAll('.tab-widget button');

    h5Elements.forEach(makeEditable);
    labelElements.forEach(makeEditable);
    buttonElements.forEach(makeEditable);

    // Flag para indicar que los elementos son editables
    isEditable = true;


}


function editContentOff() {
    // Selecciona todos los elementos que tienen contentEditable=true
    const editableElements = document.querySelectorAll('[contenteditable="true"]');

    // Itera sobre los elementos seleccionados
    editableElements.forEach(function(element) {
        // Verifica si el elemento es un div con la clase 'editable'
        if (!(element.tagName.toLowerCase() === 'div' && element.classList.contains('my-editor')))
	{
            // Establece contentEditable en false y elimina la clase 'editable'
            element.contentEditable = false;
            element.classList.remove('editable');
        }
    });

    isEditable = false;
}


////////////// Editor commands ///////////////////////////

function applyBold() {
            const selection = window.getSelection();
            if (selection.rangeCount > 0) {
                const range = selection.getRangeAt(0);
                const boldElement = document.createElement('strong');
                range.surroundContents(boldElement);
            }
        }


function applyItalic() {
            const selection = window.getSelection();
            if (selection.rangeCount > 0) {
                const range = selection.getRangeAt(0);
                const italicElement = document.createElement('em');
                range.surroundContents(italicElement);
            }
        }


// Función para aplicar subrayado
        function applyUnderline() {
            const selection = window.getSelection();
            if (selection.rangeCount > 0) {
                const range = selection.getRangeAt(0);
                const underlineElement = document.createElement('span');
                underlineElement.style.textDecoration = 'underline';
                range.surroundContents(underlineElement);
            }
        }

// Cambiar el color de la fuente
        function changeColor(color) {
            const selection = window.getSelection();
            if (selection.rangeCount > 0) {
                const range = selection.getRangeAt(0);
                const colorElement = document.createElement('span');
                colorElement.style.color = color;
                range.surroundContents(colorElement);
            }
        }


// Cambiar el tamaño de la fuente
        function changeFontSize(size) {
            const selection = window.getSelection();
            if (selection.rangeCount > 0) {
                const range = selection.getRangeAt(0);
                const sizeElement = document.createElement('span');
                sizeElement.style.fontSize = size;
                range.surroundContents(sizeElement);
            }
        }


// Función para cambiar el tamaño de fuente
/*function changeFontSize(size) {
    // Aplica el tamaño de fuente al elemento que tenga el contenido editable
    const editableDiv = document.querySelector('.editable');
    if (editableDiv) {
        editableDiv.style.fontSize = size;
    } else {
        console.error('No se encontró el elemento editable.');
    }
}
*/





function copyContentToHidden(windowNumber) {
    console.log(windowNumber);
    
    // Seleccionar el elemento editable por ID
    let editableDiv = document.querySelector(`#editable-content${windowNumber}`);
    
    // Seleccionar el input oculto por ID
    let hiddenInput = document.querySelector(`#editor-content${windowNumber}`);
    
    // Verificar si ambos elementos existen
    if (editableDiv && hiddenInput) {
        // Copiar el contenido del div editable al input oculto
        hiddenInput.value = editableDiv.innerHTML;
    } else {
        console.error('Either the editable div or the hidden input is missing.');
    }
}


function toggleEditContent() {
    isEditable = !isEditable;
    if (isEditable) {
        editContentOn();
    } else {
        editContentOff();
    }
}
/*function editContentOn(){

    const h5Elements = document.querySelectorAll('.resizable-card  h5');

    // Establece contentEditable en true para todos los <h5>
    h5Elements.forEach(function (h5) {
	h5.contentEditable = true;
	h5.classList.add('editable');
	
    });

    const labelElements = document.querySelectorAll('.resizable-card label');
    labelElements.forEach(function (label) {
	label.contentEditable = true;
	label.classList.add('editable');
    });

    const buttonElements = document.querySelectorAll('.tab-widget button');
    buttonElements.forEach(function (button) {
	button.contentEditable = true;
	button.classList.add('editable');
	
    });

    isEditable = true;
}
*/



//////////////////////////////END-EDITOR////////////////////////////////////////////////



///////////////////////////////////////////////MAPS/////////////////////////////////////
window.initMap = initMap;


function initMap() {
    console.log("Maps JavaScript API loaded.");

    const advancedMarkers = document.querySelectorAll("gmp-advanced-marker");
    for (const advancedMarker of advancedMarkers) {
        customElements.whenDefined(advancedMarker.localName).then(() => {
            advancedMarker.addEventListener("gmp-click", () => {
                const infoWindowContent = advancedMarker.getAttribute("infowindow");
                const infoWindow = new google.maps.InfoWindow({
                    content: infoWindowContent,
                });
                infoWindow.open({
                    anchor: advancedMarker,
                });
            });
        });
    }

}

function filterMarkers(selectedLabel) {
    const advancedMarkers = document.querySelectorAll("gmp-advanced-marker");
    advancedMarkers.forEach((advancedMarker) => {
        const label = advancedMarker.getAttribute("aria-label") || advancedMarker.getAttribute("title");
        if (selectedLabel === "all" || selectedLabel === label) {
            advancedMarker.style.display = ""; // Muestra el marcador
        } else {
            advancedMarker.style.display = "none"; // Oculta el marcador
        }
    });
}






//////////////////////////DESCKTOP///////////////////////////////////////////////////////////////

// Función a ejecutar cuando se crea un nuevo elemento
function onNewElementCreated(mutationsList, observer) {
    mutationsList.forEach((mutation) => {
        if (mutation.addedNodes.length > 0) {
            // Se han agregado nuevos nodos al DOM
            mutation.addedNodes.forEach((node) => {
                // Verificar si el nuevo nodo es el tipo de elemento que deseas
                if (node instanceof Element) {
                    
                    // Aquí puedes realizar acciones con el nuevo elemento
                    if (node.classList.contains('resizable-card')) {
                        // Realiza lo que necesites con el elemento
                        dragResize();
                    }

		    if (node.classList.contains('tab-widget')) {

			const elem = document.querySelectorAll('[id^="droppable"]');

			elem.forEach((element) => {
			    // Extraer la parte numérica del ID actual, considerando el nuevo formato "droppableX-Y"
			    const number = element.id.match(/\d+-\d+/)[0];
			    const innerSelector = `#droppable-inner${number}`;

			    // Verifica si el innerSelector existe en el DOM
			    if (document.querySelector(innerSelector)) {
				console.log(`Applying configureDroppable to: ${element.id} with innerSelector: ${innerSelector}`);
				configureDroppable(`#${element.id}`, innerSelector);
			    } else {
				console.warn(`Element not found for innerSelector: ${innerSelector}`);
			    }
			});

                    }


                    // Busca el formulario dentro de los descendientes del nodo
                    const formElement = node.querySelector('form#sqlForm');
                    if (formElement) {
                        // Realiza lo que necesites con el formulario
                        initializeAceEditorInWindow();
                    }


		    const summernote = document.querySelectorAll('[id^="summernote"]');

		    if(summernote){
			summernote.forEach((element) => {
			    // Extraer la parte numérica del ID actual, considerando el nuevo formato "droppableX-Y"
			    console.log( element.id)
			
			    $(`#${element.id}`).summernote({
				
				height: 200,
				focus: true,
				dialogsInBody: true,
  				popover: {
				    image: [
					['custom', ['imageAttributes']],
					['imagesize', ['imageSize100', 'imageSize50', 'imageSize25']],
					['float', ['floatLeft', 'floatRight', 'floatNone']],
					['remove', ['removeMedia']]
				    ]
				},  
				toolbar: [
				    ['style', ['style']],
				    ['font', ['bold', 'italic', 'underline', 'clear']],
				    ['fontname', ['fontname']],
				    ['fontsize', ['fontsize']],
				    ['color', ['color']],
				    ['para', ['ul', 'ol', 'paragraph']],
				    ['insert', ['hr', 'picture', 'link', 'video']],
				    ['height', ['height']],
				]
			    });


			});

		    }

		    
		    const tableElement = node.querySelectorAll('[id^="table-data"]');
		    
                    if (tableElement) {
                        // Realiza lo que necesites con el formulario

			tableElement.forEach((element) => {
			    if (element.tagName === 'TABLE') { // Asegúrate de que sea una tabla
				new Tabulator(`#${element.id}`, {
				    layout: "fitColumns",
				    pagination: "local",
				    paginationSize: 6,
				    paginationSizeSelector: [3, 6, 8, 10],
				    movableColumns: true,
				    paginationCounter: "rows"
				});
			    }
			});

			
                    }

		    const mapElement = node.querySelector('gmp-map');
		   
		    if (mapElement) {
			// Asegúrate de que initMap esté definida antes de llamarla
			if (typeof window.initMap !== 'function') {
			    window.initMap = initMap;
			    
			}
			// Intenta iniciar el mapa
			
			initMap();
		    }
		 
	    
                }
            });
        }
    });
}


///////////////////EVENTS ////////////////////////////////////////////



document.addEventListener("DOMContentLoaded", function() {
    let isEditable = false;
    // Crear un observador de mutaciones
    const observer = new MutationObserver(onNewElementCreated);
    // Observar el nodo #windows-content y todos sus hijos
    const windowsContent = document.getElementById('windows-content');
    const config = { childList: true, subtree: true };
    // Iniciar la observación
    observer.observe(windowsContent, config);

    UIkit.util.on(document, 'shown', '.uk-modal', function () {
	console.log('A modal is shown');
	saveSelectedOptions();
	saveCheckedOptions();
	
	
    });
    removeDuplicates();
    editContentOff();
    dragResize();
    makeDroppable();
    initMap();
    
    

    document.body.addEventListener('htmx:beforeRequest', function(evt) {
	console.log('HTMX before event:', evt.detail);
	var element = evt.detail.elt;
	// Obtener el ID del elemento
	var elementId = element.id;
	console.log('ID del elemento:', elementId);
	if (elementId == "report-form-src" )
	{
	    UIkit.notification({message:'<div uk-spinner></div> Loading' ,pos: 'top-right',timeout: 2000});
	}

    });


    document.body.addEventListener('htmx:afterRequest', function(evt) {
	console.log('HTMX after event:', evt.detail);
	var element = evt.detail.elt;
	var elementId = element.id;
	if (elementId == "report-form-src" )
	{
	   
	    UIkit.notification({message: 'Success',pos: 'top-right',status:'success', timeout: 2000 })
	}
	
	
    });


    document.body.addEventListener('htmx:responseError', function(evt) {
	console.log('HTMX responseError event:', evt.detail);
	if (evt.detail.failed) {
            console.log('La solicitud HTMX falló:', evt.detail.elt);
	    UIkit.notification({message: 'Error',pos: 'top-right',status:'danger',timeout: 2000})
	    
	}
	
    });

    
    
});



///////////////////////////////////////////////////////////////////

function alert_fire(message){
    let timerInterval;
    Swal.fire({
	title: message,
	html: ".....", 
	timer: 1000,
	timerProgressBar: true,
	didOpen: () => {
	    Swal.showLoading();
	    const timer = Swal.getPopup().querySelector("b");
	    timerInterval = setInterval(() => {
		
	    }, 100);
	},
	willClose: () => {
	    clearInterval(timerInterval);
	}
    }).then((result) => {
	/* Read more about handling dismissals below */
	if (result.dismiss === Swal.DismissReason.timer) {
	    console.log("I was closed by the timer");
	}
    });

} 
