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
