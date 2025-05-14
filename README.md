# Bicep Course Outline

## 1. Step-by-Step Exercises
- step1.bicep: Basic resource deployment
- step2.bicep: Parameterization and variables
- step3.bicep: Using modules
- step4.bicep: Outputs and resource dependencies
- step5.bicep: Advanced features and best practices
- Each step can be deployed using the corresponding script in `scripts/` (e.g., `deploy_step1.sh`)

## 2. Deploying a Module to Azure Container Registry (ACR)
- Use the `acr_module/` folder for examples
- Build and publish Bicep modules to ACR for reuse
- Scripts provided: `deploy_bicep.sh`, `deploy_module.sh`
- Example Bicep files: `main.bicep`, `webapp_module.bicep`

## 3. Working with Azure Verified Modules (AVM)
- Use the `avm/` folder for AVM examples
- Learn how to deploy and consume Azure Verified Modules
- Script provided: `deploy_avm.sh`
- Example Bicep file: `main.bicep`

