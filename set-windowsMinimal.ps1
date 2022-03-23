#load services and desired status
$services= Get-Content services.cfg
foreach ($service in $services) {
    if ($service.trim()[0] -eq "#" -or ($null -eq $service.trim()[0]))  {
        continue
    }
    $serviceName,$serviceStatus = $service.split("=")
    get-service "$($serviceName)*" | Set-Service  -StartupType $serviceStatus
    # Exit
    # $set = Set-Service  $servicename -StartupType $serviceStatus
    if ($(Get-Service $serviceName | Select-Object -ExpandProperty "starttype") -eq  $serviceStatus) {
        Write-Host "- Service $servicename $serviceStatus" -f cyan
    } else {
        Write-Host "Failed to set $servicename to $servicestatus "

    }
}