#!/bin/bash

echo "- - - - - - - - - - - - - - - - - - - - -"
echo "           REPORTE DEL SISTEMA"
echo "- - - - - - - - - - - - - - - - - - - - -"

echo ""
echo "Fecha y hora actual:"
date '+%d/%m/%Y %H:%M:%S'

echo ""
echo "Nombre del host:"
hostname

echo ""
echo "Número de usuarios conectados:"
who | wc -l

echo ""
echo "Espacio libre en el disco principal:"
df -h / | awk 'NR==1 || NR==2'

echo ""
echo "Memoria RAM disponible:"
free -h | awk '/Mem:/ {print $7 " disponible de " $2 " totales"}'

echo ""
echo "Número de contenedores Docker activos:"
if command -v docker >/dev/null 2>&1; then
    docker ps -q 2>/dev/null | wc -l
else
    echo "Docker no está instalado"
fi

echo ""
echo "--------------------------------------------"
echo "       FIN DEL REPORTE"
