#!/bin/bash

# Variables
LOCAL_CONF="./kea-dhcp4.conf"
CONF_PATH="/etc/kea/kea-dhcp4.conf"

echo "Iniciando instalación y configuración del servidor Kea DHCP..."

# Actualizar paquetes e instalar Kea DHCP4
apt-get update -y
apt-get install -y kea-dhcp4-server

# Comprobar que el archivo local existe
if [ ! -f "$LOCAL_CONF" ]; then
    echo "Error: no se ha encontrado el archivo $LOCAL_CONF"
    exit 1
fi

# Eliminar configuración anterior
if [ -f "$CONF_PATH" ]; then
    echo "Eliminando configuración anterior..."
    rm -f "$CONF_PATH"
fi

# Copiar la nueva configuración local a /etc/kea/
echo "Copiando nueva configuración DHCP..."
cp "$LOCAL_CONF" "$CONF_PATH"

# Reiniciar servicio Kea DHCP
echo "Reiniciando el servicio Kea DHCP..."
systemctl restart kea-dhcp4-server

# Comprobar estado
echo "Estado del servicio:"
systemctl status kea-dhcp4-server --no-pager

echo "Configuración completada correctamente."
