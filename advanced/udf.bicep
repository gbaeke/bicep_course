// Demonstrates user-defined type and function
// Note that the function body must be a single expression

// Define a user-defined type for environment
type environmentType = 'dev' | 'test' | 'prod'

// Function to generate a standardized resource name
@description('Generates a standardized resource name based on environment and resource type.')
func generateResourceName(env environmentType, resourceType string, baseName string) string => '${env}-${resourceType}-${baseName}'

// Function to determine SKU based on environment
@description('Determines the SKU based on the environment.')
func determineSku(env environmentType) string => env == 'prod' ? 'Premium' : 'Standard'

// Parameters
param environment environmentType = 'dev'
param baseName string = 'app'

// Outputs
output resourceName string = generateResourceName(environment, 'storage', baseName)
output sku string = determineSku(environment)
