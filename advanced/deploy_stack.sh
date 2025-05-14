# Create the resource group
az group create \
  --name 'bicep-course-demo' \
  --location 'westeurope'

# Deploy the Bicep template as a deployment stack
az stack group create \
  --name 'demoStack' \
  --resource-group 'bicep-course-demo' \
  --template-file './stack.bicep' \
  --action-on-unmanage 'deleteAll' \
  --deny-settings-mode 'none'

# Ask user if they want to delete the stack
read "delete_stack?Do you want to delete the stack demoStack? (y/n) "
if [[ $delete_stack == "y" || $delete_stack == "Y" ]]; then
  az stack group delete \
    --name 'demoStack' \
    --resource-group 'bicep-course-demo' \
    --yes
  echo "Stack demoStack deleted."
else
  echo "Stack demoStack not deleted."
fi

