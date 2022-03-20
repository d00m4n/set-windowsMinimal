#load services and desired status
$services= Get-Content services.cfg
foreach ($service in $services) {
    if ($service.trim()[0] -eq "#") {
        continue
    }
    $serviceName,$serviceStatus = $service.split("=")
    $set = Set-Service  $servicename -StartupType $serviceStatus
    if ($(Get-Service $serviceName | Select-Object -ExpandProperty "starttype") -eq  $serviceStatus) {
        Write-Host "- Service $servicename $serviceStatus" -f cyan
    } else {
        Write-Host "Failed to set $servicename to $servicestatus "

    }
}