# 1 - Active Directory Setup
**In this section we will go over setting up Active Directory setup for one server (Domain Controller) and one workstation.**

## First Steps
1. Clone a server from our template, which is going to be our Domain Controller. (This can be a linked clone).
2. Clone a workstation from our template, this will be connected to our domain once that is setup.
3. Clone a workstation from our template, which will NOT be connected to our domain, but can act as our admin machine for setting this up. (Optional)
4. Create a virtual network configuration. (Optional)

## Server Setup
Once we have cloned and started up our Server (DC), we can now get started on configuring it.
SConfig will work fine with this for manual setup, but there will be a PowerShell script that just does all of these steps automagically.

### SConfig (Manual)
1. Change the Computer name (option 2). I.E `DC-01`
2. Change the network settings (option 8).
   - Set the network adapter address, I.E `S` for static followed by the IP, I.E `10.4.20.69`, set the subnet mask and preferred gateway.
   - Set DNS Servers, the preferred should be the static IP you set above, the backup is not required. Domain Controllers should be the DNS server.
3. Install Active Directory:
    ```powershell
    Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
    Import-Module ADDSDeployment
    Install-ADDSForest
    ```
4. Restore DNS Server Configuration. When running `Install-ADDSForest`, the preferred DNS server gets reset to `127.0.0.1`.

### Automated
1. Run the `install-ad-server.ps1` script.

## Workstation Setup
**TODO**
