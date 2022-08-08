#! /usr/bin/pwsh
param (
    [switch]$Quiet,
    [switch]$Version,
    [switch]$AddSafe,
    [switch]$Help
)

$scriptVersion = "1.1.0"
$env:GIT_TERMINAL_PROMPT=0

function Print-Version {
    "GitSync v$scriptVersion"
}

function Print-Help {
    Print-Version
    "Uso:"
    " $($MyInvocation.MyCommand.Name) [-Quiet] [-AddSafe]"
    " $($MyInvocation.MyCommand.Name) -Version"
    " $($MyInvocation.MyCommand.Name) -Help"
    "Opciones:"
    " -AddSafe: Agrega los repositorios a la lista de confianza de Git."
    " -Quiet:   Ejecutar de manera silenciosa."
    " -Version: Mostrar información de la versión del script"
    " -Help:    Mostrar información sobre el uso de este script"
}

if ($Help) {
    Print-Help
    Return
}
if ($Version) {
    Print-Version
    Return
}

foreach ($j in Get-ChildItem -Attributes Directory)
{
    cd $j
    if ([System.IO.Directory]::Exists("$($j.FullName)\.git"))
    {
        if ($AddSafe)
        {
            git config --global --add safe.directory "%(prefix)/$($j.FullName)".Replace("\","/")
        }
        if ($Quiet) { 
            git fetch -p > nul
            git pull > nul
        }
        else
        {
            "Repositorio en $($j.Name) (Rama: $(git branch --show-current)):"
            git fetch --all -p
            git pull
            Write-Output ""        
        }
    }
    cd ..    
}
