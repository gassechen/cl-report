#!/bin/bash

# Rutas de las herramientas y archivos de resultado
ZAP_PATH="/opt/zaproxy/zap.sh "
ZAP_API_KEY="kn3kcjbqgqm7fsa0gik5cqima"
NMAP_PATH="/usr/bin/nmap"
OUTPUT_DIR="/home/mtk/informes"

# Función para escanear con OWASP ZAP
function scan_with_zap() {
    $ZAP_PATH -daemon -port 8090 -config api.key=$ZAP_API_KEY -quickurl $1
    sleep 5  # Tiempo para que ZAP inicie
    $ZAP_PATH -config api.key=$ZAP_API_KEY -quickscan 1 -scanners all -recursive $1
    $ZAP_PATH -config api.key=$ZAP_API_KEY -quickscan 2 -scanners all -recursive $1
    $ZAP_PATH -config api.key=$ZAP_API_KEY -quickscan 3 -scanners all -recursive $1
    # Generar el informe de ZAP en segundo plano
    $ZAP_PATH -config api.key=$ZAP_API_KEY -report -reportFileName $OUTPUT_DIR/zap_report.html -format html &
}

# Función para escanear con Nmap
function scan_with_nmap() {
    $NMAP_PATH -oX $OUTPUT_DIR/nmap_results.xml $1
}

# URL de tu aplicación a escanear
TARGET_URL="http://localhost:8899"


# Crear directorio para los resultados


# Ejecutar escaneos
scan_with_zap $TARGET_URL
scan_with_nmap $TARGET_URL

# Esperar unos segundos para que ZAP genere el informe


# Mostrar el contenido del informe de ZAP por la consola
echo "=== Informe de Vulnerabilidades OWASP ZAP ==="
cat $OUTPUT_DIR/zap_report.txt

# Mover el archivo Nmap XML al directorio de informes
mv $OUTPUT_DIR/nmap_results.xml $OUTPUT_DIR/

echo "Escaneo y generación de informe completados. Los informes se encuentran en: $OUTPUT_DIR/"
