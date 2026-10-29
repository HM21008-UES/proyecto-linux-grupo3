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
1. * **Creación del Dockerfile:** Se redactó un archivo de configuración `Dockerfile` dentro del directorio `/proyecto`.
2. * **Construcción de la imagen personalizada:** Con el archivo de configuración listo, se ejecutó el proceso de compilación mediante `docker build` para generar una nueva imagen local denominada `servidor-grupo3`.
3. * **Despliegue del contenedor personalizado:** Se puso en marcha el contenedor `contenedor-grupo3` a partir de la imagen recién construida, vinculando el puerto 8081 del sistema anfitrión con el puerto 8080 del contenedor. 
4. * **Validación y comparación de servicios:** Se inició en paralelo el contenedor oficial de Nginx (`servidor-oficial`) en el puerto 8080. Esto permitió comparar de forma directa el funcionamiento del servidor con la configuración por defecto frente al servidor personalizado con el contenido propio del grupo.
