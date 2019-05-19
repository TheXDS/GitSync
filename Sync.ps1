#! /usr/bin/pwsh
param (
    [switch]$Quiet,
    [switch]$Version,
    [switch]$Help
)

$scriptVersion = "1.1.0"
$env:GIT_TERMINAL_PROMPT=0

function Print-Version {
    "GitSync v$scriptVersion"
}

function Print-Help {
    printVersion
    "Uso:"
    " $($MyInvocation.MyCommand.Name) [-Quiet]"
    " $($MyInvocation.MyCommand.Name) -Version"
    " $($MyInvocation.MyCommand.Name) -Help"
    "Opciones:"
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
    if ([System.IO.Directory]::Exists("$j\.git"))
    {
        if ($Quiet) { 
            git fetch > nul
            git pull > nul
        }
        else
        {
            "Repositorio en $($j.Name):"
            git fetch --all
            git pull
            Write-Output ""        
        }
    }
    cd ..    
}
