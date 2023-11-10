# PowerShell Script for Local Group Policy Security Enhancements

# Ensure the script is run as administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Output "This script must be run as Administrator."
    Exit
}

# Applying Security Configurations using LGPO utility
& .\LGPO.exe /set /m:('
[Security Options]
    Accounts: Administrator account status = Disabled
    Accounts: Guest account status = Disabled
    Network security: LAN Manager authentication level = Send NTLMv2 response only. Refuse LM & NTLM
    User Account Control: Admin Approval Mode for the Built-in Administrator account = Enabled
    User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode = Prompt for consent on the secure desktop
    User Account Control: Detect application installations and prompt for elevation = Enabled
    User Account Control: Only elevate UIAccess applications that are installed in secure locations = Enabled
    User Account Control: Run all administrators in Admin Approval Mode = Enabled

[System Objects]
    Require case insensitivity for non-Windows subsystems = Enabled
    Strengthen default permissions of internal system objects (e.g. Symbolic Links) = Enabled

[Network Access]
    Do not allow anonymous enumeration of SAM accounts = Enabled
    Do not allow anonymous enumeration of SAM accounts and shares = Enabled

[Interactive Logon]
    Do not display last user name = Enabled
    Do not require CTRL+ALT+DEL = Disabled

[Microsoft network client]
    Digitally sign communications (always) = Enabled

[Microsoft network server]
    Digitally sign communications (always) = Enabled
')

# Display a message
Write-Output "Local group policy security configurations have been applied successfully."
