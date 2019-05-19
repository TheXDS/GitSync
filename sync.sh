#! /bin/bash

# Información de script
version="1.1.0"
defaultName="./sync.sh"

# Opciones predeterminadas
quiet=0

function printHelp {
    printVersion
    printf "Uso:\n $defaultName [-q|--quiet]\n $defaultName -v|--version\n $defaultName -h|--help\n"
    printf "Opciones:\n"
    printf " -q  --quiet:   Ejecutar de manera silenciosa.\n"
    printf " -v  --version: Mostrar información de la versión del script\n"
    printf " -h  --help:    Mostrar información sobre el uso de este script\n"
}
function printVersion {
    printf "GitSync v$version\n"    
}

for i in "$@" ; do
    case $i in 
        -q|--quiet)
        quiet=1
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
            git fetch --all > /dev/null
            git pull > /dev/null
        else
            printf "Repositorio en $j:\n"
            git fetch --all
            git pull
            printf "\n"
        fi
    fi    
    cd ..
done

