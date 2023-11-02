function SearchAndRemove-HackingTool {
    param(
        [string]$toolName
    )

    $userChoice = Read-Host "A suspected hacking tool named $toolName has been detected. Do you want to search and remove it? (Y/N)"
    if ($userChoice -eq 'Y' -or $userChoice -eq 'y') {
        $locations = Get-ChildItem -Path C:\ -Recurse -ErrorAction SilentlyContinue -Filter $toolName | Where-Object { $_.Name -match $toolName }
        
        foreach ($location in $locations) {
            # Assuming the tool's executable will be in its installation directory
            $parentDir = $location.Directory.FullName
            $userChoiceRemove = Read-Host "Do you want to remove the entire directory $parentDir? (Y/N)"
            if ($userChoiceRemove -eq 'Y' -or $userChoiceRemove -eq 'y') {
                Remove-Item $parentDir -Recurse -Force -ErrorAction SilentlyContinue
                if (!$?) {
                    Write-Host "Failed to remove $parentDir. It might be in use or you lack sufficient permissions."
                } else {
                    Write-Host "Successfully removed hacking tool directory: $parentDir"
                }
            } else {
                Write-Host "Skipped removal of directory: $parentDir"
            }
        }

        if ($locations.Count -eq 0) {
            Write-Host "No instances of $toolName found on the system."
        }
    } else {
        Write-Host "Search and removal skipped for hacking tool named $toolName."
    }
}

# Predefined list of suspected hacking tools
$hackingTools += @(
    "metasploit.exe",       # Metasploit Framework
    "armitage.exe",         # Armitage
    "beef.exe",             # Browser Exploitation Framework (BeEF)
    "sqlmap.exe",           # SQLmap
    "sqlninja.exe",         # SQL Ninja
    "sqlsus.exe",           # SQLSUS
    "nosqlmap.exe",         # NoSQLMap
    "mimikatz.exe",         # Mimikatz
    "setoolkit.exe",        # Social Engineer Toolkit (SET)
    "hashcat.exe",          # Hashcat
    "ophcrack.exe",         # Ophcrack
    "john.exe",             # John the Ripper
    "cain.exe",             # Cain & Abel
    "hydra.exe",            # THC-Hydra
    "medusa.exe",           # Medusa
    "cowpatty.exe",         # coWPAtty
    "aircrack-ng.exe",      # Aircrack-ng
    "bully.exe",            # Bully
    "wifite.exe",           # Wifite
    "ferret.exe",           # Ferret for data sniffing
    "hamster.exe",          # Hamster for session hijacking
    "burpsuite.exe",        # Burp Suite
    "zap.exe",              # OWASP ZAP
    "w3af.exe",             # w3af
    "nikto.exe",            # Nikto
    "netsparker.exe",       # Netsparker
    "acunetix.exe",         # Acunetix
    "nmap.exe",             # Nmap
    "masscan.exe",          # Masscan
    "amap.exe",             # Amap
    "netcat.exe",           # Netcat
    "socat.exe",            # socat
    "hping.exe",            # hping
    "wireshark.exe",        # Wireshark (for packet analysis)
    "tcpdump.exe",          # Tcpdump (command-line packet analyzer)
    "ettercap.exe",         # Ettercap
    "dmitry.exe",           # Deepmagic Information Gathering Tool
    "theharvester.exe",     # theHarvester
    "maltego.exe",          # Maltego
    "recon-ng.exe",         # Recon-ng
    "gobuster.exe",         # Gobuster
    "dirbuster.exe",        # DirBuster
    "dirb.exe",             # DIRB
    "wpscan.exe",           # WPScan
    "joomscan.exe",         # Joomla! scanner
    "binwalk.exe",          # Binwalk for firmware analysis
    "radare2.exe",          # Radare2
    "ghidra.exe",           # Ghidra
    "ida.exe",              # IDA Pro
    "x64dbg.exe",           # x64dbg
    "ollydbg.exe",          # OllyDbg
    "gdb.exe",              # GNU Debugger (GDB)
    "edb.exe",              # edb-debugger
    "immunitydebugger.exe", # Immunity Debugger
    "knockpy.exe",          # Knockpy
    "sublist3r.exe",        # Sublist3r
    "dnsenum.exe",          # DNSenum
    "fierce.exe",           # Fierce Domain Scan
    "lbd.exe",              # Load Balancing Detector (lbd)
    "dnsrecon.exe",         # DNSRecon
    "dnswalk.exe",          # DNSWalk
    "nbtscan.exe",          # NBTScan
    "sniper.exe",           # Sniper
    "fscan.exe",            # fscan
    "xsser.exe",            # XSSer
    "bbqsql.exe",           # BBQSQL
    "commix.exe",           # Commix
    "payloadallthethings.exe", # Payload All The Things
    "ysoserial.exe",        # Ysoserial
    "routersploit.exe",     # RouterSploit
    "shellnoob.exe",        # ShellNoob
    "spike.exe",            # Generic network protocol fuzzer (SPIKE)
    "msfpc.exe",            # MSFvenom Payload Creator
    "veil.exe",             # Veil Framework
    "backdoor-factory.exe", # Backdoor Factory
    "netripper.exe",        # NetRipper
    "pixiewps.exe",         # PixieWPS
    "rsmangler.exe",        # RSMangler
    "responder.exe",        # Responder
    "empire.exe",           # PowerShell Empire
    "cobaltstrike.exe",     # Cobalt Strike
    "beacon.exe",           # Cobalt Strike's Beacon
    "lodowep.exe",          # LodoWeb - Automated SQL Injection Tool
    "padbuster.exe",        # PadBuster for Padding Oracle attacks
    "shellter.exe",         # Shellter
    "fatrat.exe",           # TheFatRat
    "websploit.exe",        # Websploit
    "ufonet.exe",           # UFONet - DDoS Botnet
    "goldeneye.exe",        # GoldenEye - DDoS attack tool
    "loic.exe",             # Low Orbit Ion Cannon (LOIC)
    "hoic.exe",             # High Orbit Ion Cannon (HOIC)
    "slowloris.exe",        # Slowloris
    "thc-ssl-dos.exe",      # THC-SSL-DOS
    "torshammer.exe",       # Tor's Hammer
    "xerxes.exe",           # Xerxes
    "owasp-vbscan.exe",     # OWASP VBScan
    "cadaver.exe",          # Cadaver (WebDAV client)
    "davtest.exe",          # DAVTest - tests WebDAV enabled servers
    "siegfried.exe",        # Siegfried - signature generator for file format identification
    "clusterd.exe",         # ClusterD - J2EE pen testing tool
    "jexboss.exe",          # JexBoss - Jboss verify and exploitation tool
    "ridenum.exe",          # RIDenum - RID cycling attack tool for Windows domains
    "bloodhound.exe",       # BloodHound
    "kerberoast.exe"        # Kerberoast
)


# Attempt to search and remove each hacking tool
foreach ($tool in $hackingTools) {
    SearchAndRemove-HackingTool -toolName $tool
}
