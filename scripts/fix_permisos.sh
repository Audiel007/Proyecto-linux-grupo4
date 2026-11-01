#!/bin/bash

# Script de ajuste automático de permisos y grupos

echo "Aplicando propietarios de grupo y permisos SGID..."

# Asignación de grupos correspondientes
sudo chgrp soporte /proyecto/datos
sudo chgrp web /proyecto/web

# Asignación del bit SGID (permisos hereditarios)
sudo chmod g+s /proyecto/datos
sudo chmod g+s /proyecto/web

echo "Permisos y grupos aplicados correctamente en /proyecto"
