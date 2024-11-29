#!/bin/bash

Colores
VERDE='\033[0;32m'
ROJO='\033[0;31m'
BLANCO='\033[1;37m'
FINCOLORES='\033[0m'

Función para verificar estado de V2Ray
verificar_estado() {
  if systemctl status v2ray | grep -q "active"; then
    echo -e "${VERDE}V2Ray está activo${FINCOLORES}"
  else
    echo -e "${ROJO}V2Ray está desactivado${FINCOLORES}"
  fi
}

Función para mostrar usuarios conectados
mostrar_usuarios() {
  echo "Lista de ID de usuarios V2Ray:"
  v2ray info --config=/etc/v2ray/config.json | grep -oP '(?<=id": ")[^"]*' | while read -r id; do
    usuarios_conectados=$(v2ray info --config=/etc/v2ray/config.json | grep -oP "(?<=$id\": )\d+" | head -1)
    echo "ID: $id ($usuarios_conectados online)"
  done
}

Función para buscar usuarios conectados por ID
buscar_usuarios() {
  read -p "Ingrese el ID de usuario: " id_usuario
  usuarios_conectados=$(v2ray info --config=/etc/v2ray/config.json | grep -oP "(?<=$id_usuario\": )\d+" | head -1)
  if [ -n "$usuarios_conectados" ]; then
    echo "ID: $id_usuario ($usuarios_conectados online)"
  else
    echo "ID no encontrado."
  fi
}

Menú principal
while true; do
  clear
  echo "*************************"
  echo "* CHECK ID USERS V2RAY *"
  echo "*************************"
  echo "[1] Estado V2Ray"
  echo "[2] Número de usuarios online por ID"
  echo "[3] Salir"
  read -p "Ingrese su opción: " opcion
  
  case $opcion in
    1)
      verificar_estado
      read -p "Presione Enter para continuar..."
      ;;
    2)
      buscar_usuarios
      read -p "Presione Enter para continuar..."
      ;;
    3)
      exit 0
      ;;
    *)
      echo "Opción inválida. Inténtelo nuevamente."
      read -p "Presione Enter para continuar..."
      ;;
  esac
done