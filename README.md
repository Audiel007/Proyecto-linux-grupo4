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
Debido a que Git no conserva la información de usuarios, grupos del sistema ni permisos SGID, ejecute el script de ajuste inmediatamente después de clonar el repositorio:

```bash
sudo /proyecto/scripts/fix_permisos.sh
