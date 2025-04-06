# Setup
Set-Location edk2

# Activate virtual environment
. .venv\Scripts\Activate.ps1

# Setup and update workspace
stuart_setup -c .pytool/CISettings.py
stuart_update -c .pytool/CISettings.py -a X64 TOOL_CHAIN_TAG=VS2022

# Build
stuart_ci_build -c .pytool/CISettings.py -p MdeModulePkg -t RELEASE -a X64 TOOL_CHAIN_TAG=VS2022

# Copy resulting EFI binary
Copy-Item -Force "Build\MdeModule\RELEASE_VS2019\X64\PowerMonkey.efi" "..\EFI\Boot"

# Return to root directory
Set-Location ..
