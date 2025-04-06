# Download Edk2
git clone https://github.com/tianocore/edk2.git
cd edk2
git submodule update --init
cd ..

# Download PowerMonkey
git clone https://github.com/psyq321/PowerMonkey.git
Copy-Item PowerMonkey\PowerMonkeyApp\CONFIGURATION.c .
Move-Item PowerMonkey\PowerMonkeyApp edk2\MdeModulePkg\Application
(Get-Content edk2/MdeModulePkg/MdeModulePkg.dsc) -replace '/HelloWorld.inf', "/HelloWorld.inf`r`n  MdeModulePkg/Application/PowerMonkeyApp/PowerMonkey.inf`r`n" | Set-Content edk2/MdeModulePkg/MdeModulePkg.dsc
"ACTIVE_PLATFORM       = MdeModulePkg/MdeModulePkg.dsc" | Set-Content edk2/Conf/target.txt

# Download shell.efi
New-Item -ItemType Directory -Force -Path EFI\Boot
Invoke-WebRequest -Uri https://github.com/tianocore/edk2/raw/UDK2018/ShellBinPkg/UefiShell/X64/Shell.efi -OutFile EFI\Boot\shellx64.efi
Copy-Item startup.nsh EFI\Boot\

# # Prepare Python
cd edk2
python -m venv .venv
. .venv\Scripts\Activate.ps1
pip install -r pip-requirements.txt --upgrade

# Build Base Tools
python BaseTools/Edk2ToolsBuild.py -a X64
