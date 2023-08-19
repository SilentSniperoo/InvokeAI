# Set environment variable for the root directory
Set-Variable -Name INVOKEAI_ROOT -Value $PSScriptRoot
echo (Get-Variable -Name INVOKEAI_ROOT)

# Activate the Python virtual environment
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.venv/Scripts/activate

# Update pip with Python
python -m pip install --upgrade pip

# Install the InvokeAI Package for CUDA (NVidia)
pip install -e .[xformers] --use-pep517 --extra-index-url https://download.pytorch.org/whl/cu118

# Install core models
invokeai-configure --root . --yes --skip-sd-weights

# Install base models
invokeai-configure --root .
