function Get-OctopusItems 
{
	# Define parameters
    param(
    	$OctopusUri,
        $ApiKey,
        $SkipCount = 0
    )
    
    # Define working variables
    $items = @()
    $skipQueryString = ""
    $headers = @{"X-Octopus-ApiKey"="$ApiKey"}

    # Check to see if there there is already a querystring
    if ($octopusUri.Contains("?"))
    {
        $skipQueryString = "&skip="
    }
    else
    {
        $skipQueryString = "?skip="
    }

    $skipQueryString += $SkipCount
    
    # Get intial set
    $resultSet = Invoke-RestMethod -Uri "$($OctopusUri)$skipQueryString" -Method GET -Headers $headers

    # Check to see if it returned an item collection
    if ($null -ne $resultSet.Items)
    {
        # Store call results
        $items += $resultSet.Items
    
        # Check to see if resultset is bigger than page amount
        if (($resultSet.Items.Count -gt 0) -and ($resultSet.Items.Count -eq $resultSet.ItemsPerPage))
        {
            # Increment skip count
            $SkipCount += $resultSet.ItemsPerPage

            # Check to see if maximum number to take has been specified
            if ($OctopusUri.Contains("take=") -eq $false)
            {
                # Recurse
                $items += Get-OctopusItems -OctopusUri $OctopusUri -ApiKey $ApiKey -SkipCount $SkipCount
            }
        }
    }
    else
    {
        return $resultSet
    }
    

    # Return results
    return $items
}

$octopusURL = "https://shawnsesna.octopusdemos.app"
$octopusAPIKey = ""
$header = @{ "X-Octopus-ApiKey" = $octopusAPIKey }
$spaceName = "default"
$tasksToRetrieve = 10

# Get spaces
$spaces = Get-OctopusItems -OctopusUri "$octopusURL/api/spaces" -ApiKey $octopusAPIKey

# Get specific space
$space = $spaces | Where-Object {$_.Name -eq $spaceName}

# Get ActionTemplates
$actionTemplates = Get-OctopusItems -OctopusUri "$octopusURL/api/$($space.Id)/actiontemplates" -ApiKey $octopusAPIKey

$serverDetails = Get-OctopusItems -OctopusUri "$octopusURL/api" -ApiKey $octopusAPIKey

# Loop through templates
foreach ($actionTemplate in $actionTemplates)
{
    # null out ID
    $actionTemplate.Id = $null


    Invoke-RestMethod -Method Post -Uri "http://terraformtest/api/Spaces-1/actiontemplates" -Headers @{ "X-Octopus-ApiKey" = "API-ZJMXICDEGNYCRFRIGJSMQJU3STAOC7SN" } -Body ($actionTemplate | ConvertTo-Json -Depth 10)
    break
}