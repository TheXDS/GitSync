#! /bin/bash

# Información de script
version="1.2.0"
defaultName="./sync.sh"

# Opciones predeterminadas
quiet=0
addsafe=0

function printHelp {
    printVersion
    printf "Uso:\n $defaultName [-q|--quiet]\n $defaultName -v|--version\n $defaultName -h|--help\n"
    printf "Opciones:\n"
    printf " -s  --add-safe: Agrega los repositorios a la lista de confianza de Git.\n"
    printf " -q  --quiet:    Ejecutar de manera silenciosa.\n"
    printf " -v  --version:  Mostrar información de la versión del script\n"
    printf " -h  --help:     Mostrar información sobre el uso de este script\n"
}
function printVersion {
    printf "GitSync v$version\n"    
}

for i in "$@" ; do
    case $i in 
        -q|--quiet)
        quiet=1
        ;;

        -s|--add-safe)
        addsafe=1
        ;;

        -v|--version)
        printVersion
        exit
        ;;

        -h|--help)
        printHelp
        exit
        ;;

        *)
        printf "Opción desconocida: $i.\n"
        printHelp
        exit
    esac
done

set GIT_TERMINAL_PROMPT=0
for j in $(ls -d */) ; do
    cd $j
    if [ -d ./.git ] ; then
        if [ $quiet -eq 1 ]; then
            git config --global --add safe.directory "%(prefix)/$(pwd)"
        fi
        if [ $quiet -eq 1 ]; then            
            git fetch --all -p > /dev/null
            git pull > /dev/null
        else
            printf "Repositorio en $j (Rama: $(git branch --show-current)):\n"
            git fetch --all -p
            git pull
            printf "\n"
        fi
    fi    
    cd ..
done

