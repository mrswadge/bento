#MIT License
#
#Copyright (c) 2017 Rui Lopes
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.

Set-StrictMode -Version Latest
$ProgressPreference = 'SilentlyContinue'
$ErrorActionPreference = 'Stop'
trap {
    #Write-Host
    #Write-Host 'whoami from autounattend:'
    #Get-Content C:\whoami-autounattend.txt | ForEach-Object { Write-Host "whoami from autounattend: $_" }
    #Write-Host 'whoami from current WinRM session:'
    #whoami /all >C:\whoami-winrm.txt
    #Get-Content C:\whoami-winrm.txt | ForEach-Object { Write-Host "whoami from winrm: $_" }
    Write-Host
    Write-Host "ERROR: $_"
    ($_.ScriptStackTrace -split '\r?\n') -replace '^(.*)$','ERROR: $1' | Write-Host
    ($_.Exception.ToString() -split '\r?\n') -replace '^(.*)$','ERROR EXCEPTION: $1' | Write-Host
    Write-Host
    Write-Host 'Sleeping for 60m to give you time to look around the virtual machine before self-destruction...'
    Start-Sleep -Seconds (60*60)
    Exit 1
}

function Install-MSU([PSCustomObject]$Package) {
    $DownloadURL = $Package.URL
    $Description = $Package.Description
    $PackageFile = "$(-join ((65..90) + (97..122) | Get-Random -Count 32 | % {[char]$_})).msu"
    $PackageFullPath = "$env:TEMP\$PackageFile"

    # Enable TLS 1.2
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    
    # Download the MSU package
    Invoke-WebRequest -Uri $DownloadURL -UseBasicParsing -OutFile $PackageFullPath
    Write-Host "Installing $Description from $PackageFile ..."
    Start-Process -Wait -FilePath wusa.exe -ArgumentList $PackageFullPath,'/quiet','/norestart'
}

$osVersion = [System.Environment]::OSVersion
Write-Host "Windows Version: $($osVersion.Version.Major).$($osVersion.Version.Minor).$($osVersion.Version.Build)"

# Give the windows updates a head start so that WinSXS does not get bloated.
$PackageList = @()

if ($osVersion.Version.Major -eq 6 -and $osVersion.Version.Minor -eq 3 -and $osVersion.Version.Build -eq 9600) {
    # Windows Server 2012 R2
    # Already installed in ISO: KB2949621, KB2939471, KB2938772, KB2937220, KB2919355, KB2919442
    
    # Windows Management Framework 5.1
    $PackageList += [PSCustomObject]@{
        URL         = 'https://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win8.1AndW2K12R2-KB3191564-x64.msu'
        Description = 'Windows Management Framework 5.1'
    }
    
    # Complete KB2919355 installation.
    $PackageList += [PSCustomObject]@{
        URL         = 'https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/crup/2014/02/windows8.1-kb2932046-x64_6aee5fda6e2a6729d1fbae6eac08693acd70d985.msu'
        Description = '2014-04 Windows Server 2012 R2 update 1 of 5 (KB2932046)'
    }
    $PackageList += [PSCustomObject]@{
        URL         = 'https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2014/04/windows8.1-kb2959977-x64_574ba2d60baa13645b764f55069b74b2de866975.msu'
        Description = '2014-04 Windows Server 2012 R2 update 2 of 5 (KB2959977)'
    }
    $PackageList += [PSCustomObject]@{
        URL         = 'https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/crup/2014/02/windows8.1-kb2937592-x64_4abc0a39c9e500c0fbe9c41282169c92315cafc2.msu'
        Description = '2014-04 Windows Server 2012 R2 update 3 of 5 (KB2937592)'
    }
    $PackageList += [PSCustomObject]@{
        URL         = 'https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/crup/2014/03/windows8.1-kb2938439-x64_3ed1574369e36b11f37af41aa3a875a115a3eac1.msu'
        Description = '2014-04 Windows Server 2012 R2 update 4 of 5 (KB2938439)'
    }
    $PackageList += [PSCustomObject]@{
        URL         = 'https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2014/04/windows8.1-kb2934018-x64_234a5fc4955f81541f5bfc0d447e4fc4934efc38.msu'
        Description = '2014-04 Windows Server 2012 R2 update 5 of 5 (KB2934018)'
    }

    # Install KB3000850 to fix Windows Update.
    $PackageList += [PSCustomObject]@{
        URL         = 'https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2014/11/windows8.1-kb3000850-x64_94a08e535c004b860e9434fbd1e2d293583620a2.msu'
        Description = '2014-11 Update for Windows Server 2012 R2 1 of 3 (KB3000850)'
    }
    $PackageList += [PSCustomObject]@{
        URL         = 'https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2014/11/windows8.1-kb3003057-x64_d28a8ef73c4064431057de9e40491f0237a53851.msu'
        Description = '2014-11 Update for Windows Server 2012 R2 2 of 3 (KB3003057)'
    }
    $PackageList += [PSCustomObject]@{
        URL         = 'https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2014/11/windows8.1-kb3014442-x64_7144f7a9e3431816253aded98773797143d2e150.msu'
        Description = '2014-11 Update for Windows Server 2012 R2 3 of 3 (KB3014442)'
    }

    # Latest updates.
    $PackageList += [PSCustomObject]@{
        URL         = 'https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2023/09/windows8.1-kb5030329-x64_06b32aeffa6994cfda89dc13c5695d518f0289d3.msu'
        Description = '2023-09 Servicing Stack Update for Windows Server 2012 R2 for x64-based Systems (KB5030329)'
    }
    # $PackageList += [PSCustomObject]@{
    #     URL         = 'https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2023/10/windows8.1-kb5031419-x64_45970410f6f14e2a1f17142b37536a81aff8ba01.msu'
    #     Description = '2023-10 Security Monthly Quality Rollup for Windows Server 2012 R2 for x64-based Systems (KB5031419)'
    # }
} elseif ($osVersion.Version.Major -eq 10 -and $osVersion.Version.Minor -eq 0 -and $osVersion.Version.Build -eq 14393) {
    # Windows Server 2016
} elseif ($osVersion.Version.Major -eq 10 -and $osVersion.Version.Minor -eq 0 -and $osVersion.Version.Build -eq 17763) {
    # Windows Server 2019
} elseif ($osVersion.Version.Major -eq 10 -and $osVersion.Version.Minor -eq 0 -and $osVersion.Version.Build -eq 20348) {
    # Windows Server 2022
} else {
    Write-Host "Unsupported Windows version: $($osVersion.Version.Major).$($osVersion.Version.Minor).$($osVersion.Version.Build)"
    Exit 1
}

foreach ($Package in $PackageList) {
    Install-MSU -Package $Package
}