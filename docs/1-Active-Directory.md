# 1 - Active Directory Setup
**In this section we will go over setting up Active Directory setup for one server (Domain Controller) and one workstation.**

## First Steps
1. Clone a server from our template, which is going to be our Domain Controller. (This can be a linked clone).
2. Clone a workstation from our template, which will NOT be connected to our domain, but can act as our admin machine for setting this up. (Optional)

#### SSH Connection Between Server and Workstation Machine.
**In the real world, most likely we would not interface directly with the server, but rather remote into it. We could use WinRM which is the default way, but I would rather use SSH and key based authentication.**

1. Go into SConfig on the server and disable remote management, as this is for WinRM and we will use SSH key based authentication.
2. Back in PowerShell, lets configure our SSH configuration on our server.
   ```powershell
   # Install OpenSSH Server if it is not installed.
   Add-WindowsCapability -Online -Name OpenSSH.Server
   # Start the service
   Start-Service -Name sshd
   # Always start the service.
   Set-Service -Name sshd -StartupType Automatic
   # Force SSH connections to use PowerShell
   New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force
   ```
3. SSH into the Server from the Workstation using password based authentication:
   ```powershell
   ssh Administrator@<Server-IP>
   ```
4. Generate a key pair (ON OUR WORKSTATION) to load onto the server:
   ```powershell
   # Do this on the workstation, not the server.
   ssh-keygen -t rsa -b 4096  # Create key pair.
   # Setup ssh-agent for storing our private key.
   Get-Service ssh-agent | Set-Service -StartupType Automatic
   Start-Service ssh-agent
   Get-Service ssh-agent
   ssh-add $env:USERPROFILE\.ssh\id_rsa
   # Save the public key for later.
   Get-Content .\.ssh\id_rsa.pub | Set-Clipboard
   ```
5. Add our pub key onto the server:
   ```powershell
   # In the Administrator's root directory.
   mkdir .ssh
   cd .\.ssh
   New-Item authorized_keys
   echo "SSH PUBLIC KEY HERE" > authorized_keys
   ```
6. Test our SSH connection via our key:
   ```powershell
   ssh -i .\.ssh\id_rsa Administrator@<server-IP>
   ```