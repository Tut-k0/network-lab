# Rename-Computer must be ran separately since it will restart. Will update that later.
# Rename-Computer -NewName "DC-02" -Restart
$interface = Get-NetIPAddress | Where-Object IPAddress -like 10.*
if (!$interface) {
    throw "No valid interface found! Tried to match on 10.*."
}

$gateway = Get-NetRoute -InterfaceIndex $interface.InterfaceIndex -DestinationPrefix "0.0.0.0/0"
New-NetIPAddress -InterfaceIndex $interface.InterfaceIndex -IPAddress 10.4.20.69 -PrefixLength 24 -DefaultGateway $gateway.NextHop
Remove-NetIPAddress $interface
Set-DnsClientServerAddress -InterfaceIndex $interface.InterfaceIndex -ServerAddresses ($gateway.NextHop)

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Import-Module ADDSDeployment
# Yes, the default password sucks. Change it.
$pw = "P@ssw0rd!" | ConvertTo-SecureString -AsPlainText -Force
Install-ADDSForest -DomainName somecorp.com -SafeModeAdministratorPassword $pw -Confirm -Force

Set-DnsClientServerAddress -InterfaceIndex $interface.InterfaceIndex -ServerAddresses ($gateway.NextHop)

Restart-Computer
