# Proyecto Final - Servidor Linux con Docker (Grupo 3)

Introducción al Software Libre - Universidad de El Salvador, Ciclo II 2026.

## Descripción
Servidor Linux automatizado con contenedores Docker: administración de
usuarios y grupos, script de monitoreo con cron, control de versiones con
Git, y servidores web Nginx en contenedores.

## Estructura
- `datos/`: archivos de configuración
- `web/`: archivos del sitio web
- `scripts/`: scripts de automatización
- `capturas/`: evidencias del proyecto

## Pasos realizados

### Secciones 3, 4 y 5 (Git, Docker y Nginx)
1. Se clonó el repositorio en `/proyecto` y se agregaron `web/index.html` y `datos/`.
2. Se instaló Docker, se habilitó el servicio y se agregaron `adminsys` y `tecnico` al grupo `docker`.
3. Se verificó Docker con `docker run hello-world` y `docker ps -a`.
4. Se ejecutó un contenedor Nginx en segundo plano:
   `docker run -d --name nginx-basico -p 8080:80 -v /proyecto/web:/usr/share/nginx/html nginx`
5. Se verificó en `http://localhost:8080` y con `docker logs nginx-basico`.

### Sección 6: Creación de Imagen Personalizada y Despliegue de Contenedor
1. Creación del Dockerfile: Se redactó un archivo de configuración `Dockerfile` dentro del directorio `/proyecto`.
2. Construcción de la imagen personalizada: Con el archivo de configuración listo, se ejecutó el proceso de compilación mediante `docker build` para generar una nueva imagen local denominada `servidor-grupo3`.
3. Despliegue del contenedor personalizado: Se puso en marcha el contenedor `contenedor-grupo3` a partir de la imagen recién construida, vinculando el puerto 8081 del sistema anfitrión con el puerto 8080 del contenedor. 
4. Validación y comparación de servicios: Se inició en paralelo el contenedor oficial de Nginx (`servidor-oficial`) en el puerto 8080. 

### Secciones 7 y 8: Redes y Volúmenes en Docker; Pruebas y Verificación Final.
1. Red Personalizada: Se creó la red personalizada red-proyecto mediante el driver bridge para aislar el tráfico de los contenedores. Se desplegó el servicio nginx-red conectado a esta red y mapeado al puerto 8082 del host. Mediante el comando docker network inspect se verificó la asignación correcta de la red y la dirección IP interna del contenedor .
2. Volúmenes Persistentes: Se configuró la persistencia de datos mediante el volumen administrado volumen-web, montado en el directorio /usr/share/nginx/html del contenedor nginx-volumen expuesto en el puerto 8083. La vinculación del volumen se confirmó a través de la inspección del contenedor .
3. Pruebas de Conectividad: Se ejecutó un contenedor auxiliar basado en la imagen alpine dentro de la red red-proyecto para evaluar la conectividad y resolución DNS interna. Se realizó una prueba ICMP (ping -c 4 nginx-red), comprobando una tasa de respuesta exitosa del 100%.
4. Verificación Integral y Control de Versiones: Se validó el funcionamiento continuo de los servicios ejecutando docker ps y realizando peticiones HTTP a los puertos correspondientes. Finalmente, Verificar los scripts (cada 30 min) .

