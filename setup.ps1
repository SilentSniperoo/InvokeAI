# Set environment variable for the root directory
Set-Variable -Name INVOKEAI_ROOT -Value $PSScriptRoot
Write-Output (Get-Variable -Name INVOKEAI_ROOT)

# Create and activate the Python virtual environment
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
python -m venv .venv --prompt InvokeAI
.venv/Scripts/activate

# Update pip with Python
python -m pip install --upgrade pip

# Install the InvokeAI Package for CUDA (NVidia)
#pip install -e .[xformers] --use-pep517 --extra-index-url https://download.pytorch.org/whl/cu118
pip install -e .[xformers] --use-pep517 --extra-index-url https://download.pytorch.org/whl/cu121

# Install core models
invokeai-configure --root . --yes --skip-sd-weights

# Install base models
invokeai-configure --root .

# Confirm node is installed
Write-Output ""
Write-Output "Node is required for the dev setup."
Write-Output "If the following line does not display Node's version number, press 'Ctrl + C' to exit the script."
node --version
Pause

# Install and/or confirm pnpm is installed
npm install --global pnpm
Write-Output ""
Write-Output "Pnpm is required for the dev setup."
Write-Output "If the following line does not display Pnpm's version number, press 'Ctrl + C' to exit the script."
pnpm --version
Pause

# Setup and run the server in dev mode
Push-Location invokeai/frontend/web
pnpm install
pnpm dev

# Start the InvokeAI Nodes backend (from the repo root)
Pop-Location
python scripts/invokeai-web.py
