#!/bin/bash

echo "BIENVENIDO A BASHLE!"
echo "Fecheando la palabra del día..."
echo "----------------------------"
echo "Este Script es de Izan Patiño Martínez"
echo "Nombre del GitHub -> izanpm4"
echo "---"
echo " "
# === URL OFICIAL DE LA PALABRA ===
URL_PALABRA="https://raw.githubusercontent.com/izanpm4/Wordle-SOM/refs/heads/main/srct?nocache=$(date +%s)"
wget --no-cache ...

# === UBICACIONES POSIBLES ===
locations=(
    "$HOME/.scrtsnt"
    "$XDG_CONFIG_HOME/.scrtsnt"
    "$XDG_CACHE_HOME/.scrtsnt"
    "$HOME/.local/share/.scrtsnt"
)

# Limpiar restos anteriores
for loc in "${locations[@]}"; do
    [ -f "$loc" ] && rm -f "$loc"
done

# Elegir destino aleatorio
dest=$((RANDOM % 4))
ub="${locations[$dest]}"

mkdir -p "$(dirname "$ub")"

# Descargar palabra
wget -q -O "$ub" "$URL_PALABRA"

# Leer palabra y limpiar espacios
oculta=$(cat "$ub" | tr -d '[:space:]')

# Validar palabra
if [ ${#oculta} -ne 5 ]; then
    echo "ERROR: la palabra descargada no tiene 5 letras."
    exit 1
fi

echo "Palabra cargada correctamente"
echo "---"

# === JUEGO ===
intentos=0
MAX_INTENTOS=6

while [ $intentos -lt $MAX_INTENTOS ]; do
    read -p "Dime una palabra -> " palabra

    if [ ${#palabra} -ne 5 ]; then
        echo "LA PALABRA TIENE QUE TENER 5 LETRAS"
        continue
    fi

    for ((i=0; i<5; i++)); do
        letra="${palabra:i:1}"
        letra_oculta="${oculta:i:1}"

        if [ "$letra" == "$letra_oculta" ]; then
            printf "🟩"
        elif [[ "$oculta" == *"$letra"* ]]; then
            printf "🟨"
        else
            printf "🟥"
        fi
    done
    printf "\n"

    ((intentos++))

    if [ "$palabra" == "$oculta" ]; then
        echo "---"
        echo "Has ganado"
        echo "La palabra oculta de hoy es -> $oculta"
        exit 0
    fi
done

echo "---"
echo "Se te han acabado los intentos"
echo "La palabra oculta de hoy es -> $oculta"
exit 0

