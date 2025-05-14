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

## 4. Intermediate Scenarios (`intermediate/` folder)
- `deploy.sh` and `main.bicep`: Use together for more complex deployments that go beyond the basics
- Uses Azure Virtual Modules with networking and private endpoints
- Use it to illustrate using listkeys to retrieve storage account key for storage in key vault + explicit dependency on storage account before secret is set


## 5. Advanced Scenarios (`advanced/` folder)
- `deploy_stack.sh` and `stack.bicep`: Use together to deploy a Bicep template as a deployment stack and optionally delete it after deployment
- `deploy_udf.sh` and `udf.bicep`: Use together to deploy and demonstrate user-defined functions in Bicep

## 6. PSRule

```bash
pwsh

Assert-PSRule -InputPath './step2.bicep' -Module 'PSRule.Rules.Azure' -OutputFormat Json -OutputPath ./psrule-results.json
```