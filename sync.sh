#! /bin/bash
set GIT_TERMINAL_PROMPT=0
for j in $(ls -d */) ; do
    cd $j
    if [ -d $j/.git ] ; then
        echo Repositorio en $j:
        git fetch --all
        git pull
        echo
    fi    
    cd ..
done
