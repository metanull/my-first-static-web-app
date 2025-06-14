using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

# Interact with query parameters or the body of the request.
$format = $Request.Query.Format
if (-not $format) {
    $format = $Request.Body.Format
}

$body = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

if ($format) {
    $body = Get-Date -Format $format
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})
