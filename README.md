# Proyecto Final - Servidor Linux con Docker (Grupo 3)

Introducción al Software Libre - Universidad de El Salvador, Ciclo II 2026.

## Integrantes
- Roberto Rafael Ramos Alfaro (RA23035)
- Raquel Abigail Hernández Martínez (HM21008)
- Marco Josué Orellana Cortez (OC23006)

## Descripción
Servidor Linux (`servidor-grupo3`) con usuarios y grupos, un script de monitoreo
automatizado con cron, control de versiones con Git y GitHub, y servidores web
Nginx que se ejecutan en contenedores Docker.

## Estructura
- `datos/`: archivos de configuración
- `web/`: archivos del sitio web (`index.html`)
- `scripts/`: scripts de automatización (`reporte_sistema.sh`)
- `capturas/`: evidencias del proyecto
- `Dockerfile`: imagen personalizada `servidor-grupo3`

## Servicios finales
| Contenedor | Imagen | Puerto | Descripción |
|---|---|---|---|
| servidor-oficial | nginx | 8080 | Nginx oficial |
| contenedor-grupo3 | servidor-grupo3 | 8081 | Imagen propia con el sitio del grupo |
| nginx-red | nginx:latest | 8082 | Conectado a la red `red-proyecto` |
| nginx-volumen | nginx:latest | 8083 | Contenido en el volumen `volumen-web` |

## Pasos realizados

### 1. Entorno del servidor
```bash
sudo hostnamectl set-hostname servidor-grupo3
sudo adduser adminsys; sudo adduser tecnico; sudo adduser visitante
sudo groupadd soporte; sudo groupadd web
sudo usermod -aG sudo adminsys
sudo usermod -aG soporte tecnico
sudo usermod -aG web visitante
sudo mkdir -p /proyecto/datos /proyecto/web /proyecto/scripts /proyecto/capturas
sudo chown root:soporte /proyecto/datos
sudo chown root:web /proyecto/web
sudo chmod 2775 /proyecto/datos /proyecto/web
```
El permiso `2775` activa setgid: los archivos nuevos heredan el grupo del directorio.

### 2. Automatización
```bash
chmod +x /proyecto/scripts/reporte_sistema.sh
sudo mkdir -p /var/log/proyecto
crontab -e
# */30 * * * * /proyecto/scripts/reporte_sistema.sh >> /var/log/proyecto/reporte_sistema.log 2>&1
```

### 3. Git y GitHub
```bash
git clone https://github.com/HM21008-UES/proyecto-linux-grupo3.git /proyecto
git add . && git commit -m "mensaje" && git pull --rebase && git push
```

### 4. Docker
```bash
sudo apt install -y docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker adminsys
sudo usermod -aG docker tecnico
docker run hello-world
docker ps -a
```

### 5. Nginx en contenedor
```bash
docker run -d --name nginx-basico -p 8080:80 -v /proyecto/web:/usr/share/nginx/html nginx
curl http://localhost:8080
docker logs nginx-basico
```

### 6. Dockerfile e imagen personalizada
```bash
cd /proyecto
docker build -t servidor-grupo3 .
docker run -d -p 8081:80 --name contenedor-grupo3 servidor-grupo3
docker run -d -p 8080:80 --name servidor-oficial nginx   # comparación con el Nginx oficial
```
La imagen propia incluye el sitio copiado dentro; la oficial muestra la página predeterminada de Nginx.

### 7. Redes y volúmenes
```bash
docker network create red-proyecto
docker run -d --name nginx-red --network red-proyecto -p 8082:80 nginx:latest
docker network inspect red-proyecto
docker volume create volumen-web
docker run -d --name nginx-volumen -v volumen-web:/usr/share/nginx/html -p 8083:80 nginx:latest
docker inspect nginx-volumen | grep -A 10 "Mounts"
```

### 8. Pruebas y verificación final
```bash
docker run --rm --network red-proyecto alpine ping -c 4 nginx-red
docker ps
curl http://localhost:8082
curl http://localhost:8083
crontab -l
git status
```
