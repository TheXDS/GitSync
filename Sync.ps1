#! /usr/bin/pwsh
﻿$env:GIT_TERMINAL_PROMPT=0
foreach ($j in Get-ChildItem -Attributes Directory)
{
    cd $j
    if ([System.IO.Directory]::Exists("$j\.git"))
    {
        "Repositorio en $($j.Name):"
        git fetch --all
        git pull
        Write-Output ""
    }
    cd ..    
}
