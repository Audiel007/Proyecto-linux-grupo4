# Proyecto Linux - Grupo 4

## Descripción
Proyecto final para la asignatura Introducción al Software Libre (UES, Ciclo II - 2026).
Servidor Linux automatizado implementado sobre tecnología de contenedores Docker.

## Estructura del Proyecto
- `/proyecto/datos/`: Directorio de configuraciones y datos (Grupo: `soporte`, SGID activo).
- `/proyecto/web/`: Directorio para los archivos del sitio web (Grupo: `web`, SGID activo).
- `/proyecto/scripts/`: Scripts de automatización y monitoreo.
- `/proyecto/capturas/`: Evidencias y capturas del proyecto.

## Configuración del Entorno Post-Clonado
Debido a que Git no conserva la información de usuarios, grupos del sistema ni permisos SGID, ejecute el script de ajuste inmediatamente después de clonar el repositorio

```bash
sudo /proyecto/scripts/fix_permisos.sh
```

## Desarrollo del proyecto
---

## 1. Preparación del Entorno Servidor


### 1.1 Administración Básica del Sistema

Se configuró el nombre del host del sistema y se crearon los usuarios y grupos con sus respectivos privilegios:

* **Nombre del Host:** `servidor-grupo4`

* **Usuarios creados:** `adminsys` (con privilegios sudo), `tecnico`, `visitante`.

* **Grupos creados:** `soporte` (asociado al usuario `tecnico`), `web` (asociado al usuario `visitante`).


### 1.2 Estructura de Directorios y Permisos

Se creó la estructura de directorios base en la ruta `/proyecto/` asignando los permisos de grupo y la propiedad SGID para la herencia automática de archivos:

* `/proyecto/datos/` -> Perteneciente al grupo `soporte` (Con SGID habilitado).

* `/proyecto/web/` -> Perteneciente al grupo `web` (Con SGID habilitado).

* `/proyecto/scripts/` -> Destinado para scripts de automatización.

* `/proyecto/capturas/` -> Almacenamiento de evidencias del proyecto.

 
---

 
## 2. Automatización y Monitoreo

 
### 2.1 Script de Monitoreo del Sistema

Se desarrolló el script en Bash llamado `reporte_sistema.sh` dentro de `/proyecto/scripts/` con permisos de ejecución. El script recopila de forma automática:

* Fecha y hora actual.

* Nombre del host del sistema.

* Número de usuarios conectados.

* Espacio libre en el disco principal.

* Memoria RAM disponible.

* Número de contenedores Docker activos.

 
### 2.2 Automatización con Cron

Se programó una tarea cron para ejecutar el script de monitoreo cada 30 minutos, redirigiendo y acumulando la salida en la siguiente ruta de registro:

```bash

/var/log/proyecto/reporte_sistema.log

```

---

## 3. Control de Versiones

El proyecto cuenta con un repositorio Git local inicializado en `/proyecto/`. Los cambios y entregas de código de los integrantes del grupo se gestionan de manera remota a través de GitHub bajo el repositorio `proyecto-linux-grupo4` utilizando un flujo de ramas de desarrollo.

 
---

 
## 4. Docker

 
### 4.1 Instalación y Configuración

Se instaló, habilitó e inició el servicio de Docker en el servidor. Los usuarios `adminsys` y `tecnico` fueron agregados al grupo `docker` para ejecutar comandos sin privilegios `sudo`.

 
### 4.2 Verificación Inicial

Se ejecutó el contenedor de prueba oficial para validar que el motor de Docker descarga imágenes y despliega entornos de forma correcta:

```bash

docker run hello-world

```

---

## 5. Servidor Web Containerizado

 
### 5.1 Contenedor Nginx Básico

Se creó un archivo `index.html` personalizado dentro de `/proyecto/web/`. Se desplegó un contenedor de Nginx en segundo plano mapeando el puerto 8080 del host y montando el volumen local:

```bash

docker run -d -p 8080:80 -v /proyecto/web:/usr/share/nginx/html --name web-basico nginx:latest

```

### 5.2 Verificación del Servicio Web

El servicio es accesible localmente mediante herramientas de diagnóstico y navegadores web en la dirección:

```bash

curl http://localhost:8080

```

---

## 6. Docker Avanzado

 
### 6.1 Dockerfile Personalizado

Se configuró un archivo `Dockerfile` en la raíz de `/proyecto/` con la imagen base `nginx:latest`, copiando el directorio `web/`, exponiendo el puerto 80 e inicializando el servicio. La imagen personalizada se construyó bajo el nombre:

```bash

docker build -t servidor-grupo4 /proyecto/

```

### 6.2 Contenedor con Imagen Personalizada

Se realizó el despliegue de un contenedor utilizando la imagen local recién estructurada, mapeando el puerto 8081 del host:

```bash

docker run -d -p 8081:80 --name web-avanzado servidor-grupo4

```

---

## 7. Redes y Volúmenes Docker

 
### 7.1 Red Personalizada en Docker

Se creó una red aislada en Docker llamada `red-proyecto` y se asoció un contenedor Nginx mapeando el puerto 8082 del host:

```bash

docker network create red-proyecto

docker run -d -p 8082:80 --network red-proyecto --name web-red-proyecto nginx:alpine

```

### 7.2 Volúmenes Persistentes

Se creó un volumen de datos persistente llamado `volumen-web` para independizar el almacenamiento web del ciclo de vida del contenedor, mapeando el puerto 8083 del host:

```bash

docker volume create volumen-web

docker run -d -p 8083:80 -v volumen-web:/usr/share/nginx/html --name web-volumen nginx:latest

```

---

## 8. Pruebas y Verificación Final


### 8.1 Pruebas de Conectividad

Se desplegó un contenedor temporal de Alpine Linux dentro de la red del proyecto para validar la conectividad interna mediante el uso de ping hacia el contenedor del puerto 8082:

```bash

docker run --rm --network red-proyecto alpine ping -c 4 web-red-proyecto

```

### 8.2 Verificación Integral

Se comprobó que todos los contenedores web (`web-basico`, `web-avanzado`, `web-red-proyecto` y `web-volumen`) se encuentran en ejecución simultánea ("Up") respondiendo de manera correcta a las peticiones en sus respectivos puertos (8080, 8081, 8082, 8083).



