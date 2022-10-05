# 0 - Project Initialization

## Prerequisites

* Decent specs to run multiple VMs.

### Installing VMware Workstation (Linux)
1. Download bundle package from VMware's site: https://www.vmware.com/products/workstation-pro/workstation-pro-evaluation.html
2. Run the bundler to install VMware Workstation
```bash
# Set the bundler to be an executable
chmod +x VMware-Workstation-Full-16.2.4-20089737.x86_64.bundle
# Run as sudo
sudo ./VMware-Workstation-Full-16.2.4-20089737.x86_64.bundle
```
3. Start VMware Workstation
```bash
# Ensure we have requirements to compile VMware
sudo apt install gcc build-essential linux-headers-generic linux-headers-$(uname -r)
# Install the stuff
sudo vmware-modconfig --console --install-all
# Run VMware
vmware
```
4. If there is a compiler error installing the modules run these commands
```bash
# Make sure to switch the URL to point to your version of VMware
# https://crucialkali.blogspot.com/2020/11/unable-to-install-all-modules-in-vmware.html
 wget https://github.com/mkubecek/vmware-host-modules/archive/workstation-16.2.4.tar.gz
 tar -xzf workstation-16.2.4.tar.gz
 cd vmware-host-modules-workstation-16.2.4
 tar -cf vmmon.tar vmmon-only
 tar -cf vmnet.tar vmnet-only
 sudo su
 cp -v vmmon.tar vmnet.tar /usr/lib/vmware/modules/source/
 vmware-modconfig --console --install-all
 exit
 # Run
 vmware
```


### Installing ISOs for Windows 11 and Windows Server 2022
Download both of the ISOs.
* Windows 11 Enterprise: https://www.microsoft.com/en-us/evalcenter/download-windows-11-enterprise
* Windows Server 2022: https://www.microsoft.com/en-us/evalcenter/download-windows-server-2022

#### Setting up Windows 11 Enterprise (Non Domain)
Don't install VMware tools until the OS is fully installed.
1. Create a new virtual machine in VMware and just say it is Windows 10 and later. Also disable the internet for setup (remove network adaptor), so we can make truly local accounts.
2. Change the hardware settings as we need a minimum of 4GB of ram allocated.
3. Start the installation of Windows 11. This will most likely fail because of TPM reasons, unless that becomes virtualized soon.
4. If it fails, disable the TPM check and possibly the secure boot check. After that try again. (SHIFT + F10 to get to a shell)
```dos
REG ADD HKLM\SYSTEM\Setup\LabConfig /v BypassTPMCheck /t REG_DWORD /d 1
REG ADD HKLM\SYSTEM\Setup\LabConfig /v BypassSecureBootCheck /t REG_DWORD /d 1
```
5. Select custom installation, partition the drive, and install the OS onto it.
6. Finish configuring the installation and take a snapshot!
7. Install all the tools needed to play around as admin with. (PS 7.2, VSCode, etc.)

#### Setting up Windows Server 2022


#### Setting up Windows 11 Enterprise (Domain)