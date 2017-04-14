#####
# File name: Get-EXMBXServerVersion.ps1
# Description: Retrieve the Microsoft Exchange version names.
#              This script must be run from the Exchange management shell.
# Version: 1.8
# Date of last edit: 2017/06/02
#
# Authors: Thimo Braker
#
# (c) 2017 - Thimo - All rights reserved.
#####

$ServerList = Get-ExchangeServer;

ForEach ($Server in $ServerList) {
    $RawVersions          = $Server.AdminDisplayVersion;
    $FQDNList             = $Server.FQDN;
    [String]$formattedStr = [String]$RawVersions.Major + '.' + [String]$RawVersions.Minor + '.' + [String]$RawVersions.Build + '.' + [String]$RawVersions.Revision;
    Write-Host ("Server: `t " + $FQDNList) -Fore Green -Back Black;
    $swVar = "";
    $Current_ex2016 = "2016 CU5";
    $Current_ex2013 = "2013 CU16";
    $Current_ex2010 = "2010 SP3 Rollup 17";
    $Current_ex2007 = "2007 SP3 Rollup 23";

    switch ($formattedStr) {
        # Exchange 2016
        '15.1.845.34' {
            Write-Host "Version:`t Exchange Server 2016 CU5" -Fore Green -Back Black;
            $swVar = "2016";
        };
        '15.1.669.32' {
            Write-Host "Version:`t Exchange Server 2016 CU4" -Fore Green -Back Black;
            $swVar = "2016L";
        };
        '15.1.544.27' {
            Write-Host "Version:`t Exchange Server 2016 CU3" -Fore Green -Back Black;
            $swVar = "2016L";
        };
        '15.1.466.34' {
            Write-Host "Version:`t Exchange Server 2016 CU2" -Fore Green -Back Black;
            $swVar = "2016L";
        };
        '15.1.396.30' {
            Write-Host "Version:`t Exchange Server 2016 CU1" -Fore Green -Back Black;
            $swVar = "2016L";
        };
        '15.1.225.42' {
            Write-Host "Version:`t Exchange Server 2016 RTM" -Fore Green -Back Black;
            $swVar = "2016L";
        };
        '15.1.225.16' {
            Write-Host "Version:`t Exchange Server 2016 Preview" -Fore Green -Back Black;
            $swVar = "2016L";
        };
        # Exchange 2013
        '15.0.1293.2' {
            Write-Host "Version:`t Exchange Server 2013 (SP1) CU16" -Fore Green -Back Black;
            $swVar = "2013";
        };
        '15.0.1263.5' {
            Write-Host "Version:`t Exchange Server 2013 (SP1) CU15" -Fore Green -Back Black;
            $swVar = "2013L";
        };
        '15.0.1236.3' {
            Write-Host "Version:`t Exchange Server 2013 (SP1) CU14" -Fore Green -Back Black;
            $swVar = "2013L";
        };
        '15.0.1210.3' {
            Write-Host "Version:`t Exchange Server 2013 (SP1) CU13" -Fore Green -Back Black;
            $swVar = "2013L";
        };
        '15.0.1178.4' {
            Write-Host "Version:`t Exchange Server 2013 (SP1) CU12" -Fore Green -Back Black;
            $swVar = "2013L";
        };
        '15.0.1156.6' {
            Write-Host "Version:`t Exchange Server 2013 (SP1) CU11" -Fore Green -Back Black;
            $swVar = "2013L";
        };
        '15.0.1130.7' {
            Write-Host "Version:`t Exchange Server 2013 (SP1) CU10" -Fore Green -Back Black;
            $swVar = "2013L";
        };
        '15.0.1104.5' {
            Write-Host "Version:`t Exchange Server 2013 (SP1) CU9" -Fore Green -Back Black;
            $swVar = "2013L";
        };
        '15.0.1076.9' {
            Write-Host "Version:`t Exchange Server 2013 (SP1) CU8" -Fore Green -Back Black;
            $swVar = "2013L";
        };
        '15.0.1044.25' {
            Write-Host "Version:`t Exchange Server 2013 (SP1) CU7" -Fore Green -Back Black;
            $swVar = "2013L";
        };
        '15.0.995.29' {
            Write-Host "Version:`t Exchange Server 2013 (SP1) CU6" -Fore Green -Back Black;
            $swVar = "2013L";
        };
        '15.0.913.22' {
            Write-Host "Version:`t Exchange Server 2013 (SP1) CU5" -Fore Green -Back Black;
            $swVar = "2013L";
        };
        '15.0.847.32' {
            Write-Host "Version:`t Exchange Server 2013 SP1" -Fore Green -Back Black;
            $swVar = "2013L";
        };
        '15.0.775.38' {
            Write-Host "Version:`t Exchange Server 2013 CU3" -Fore Green -Back Black;
            $swVar = "2013L";
        };
        '15.0.712.24' {
            Write-Host "Version:`t Exchange Server 2013 CU2" -Fore Green -Back Black;
            $swVar = "2013L";
        };
        '15.0.620.29' {
            Write-Host "Version:`t Exchange Server 2013 CU1" -Fore Green -Back Black;
            $swVar = "2013L";
        };
        '15.0.516.32' {
            Write-Host "Version:`t Exchange Server 2013 RTM" -Fore Green -Back Black;
            $swVar = "2013L";
        };
        # Exchange 2010 SP3
        '14.3.352.0' {
            Write-Host "Version:`t Rollup 17 for Exchange Server 2010 SP3" -Fore Green -Back Black;
            $swVar = "2010";
        };
        '14.3.336.0' {
            Write-Host "Version:`t Rollup 16 for Exchange Server 2010 SP3" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.3.319.2' {
            Write-Host "Version:`t Rollup 15 for Exchange Server 2010 SP3" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.3.301.0' {
            Write-Host "Version:`t Rollup 14 for Exchange Server 2010 SP3" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.3.294.0' {
            Write-Host "Version:`t Rollup 13 for Exchange Server 2010 SP3" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.3.279.2' {
            Write-Host "Version:`t Rollup 12 for Exchange Server 2010 SP3" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.3.266.1' {
            Write-Host "Version:`t Rollup 11 for Exchange Server 2010 SP3" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.3.248.2' {
            Write-Host "Version:`t Rollup 10 for Exchange Server 2010 SP3" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '​14.3.235.1' {
            Write-Host "Version:`t Rollup 9 for Exchange Server 2010 SP3" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '​14.3.224.2' {
            Write-Host "Version:`t Rollup 8-v2 for Exchange Server 2010 SP3" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.3.210.2' {
            Write-Host "Version:`t Rollup 7 for Exchange Server 2010 SP3" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.3.195.1' {
            Write-Host "Version:`t Rollup 6 for Exchange Server 2010 SP3" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.3.181.6' {
            Write-Host "Version:`t Rollup 5 for Exchange Server 2010 SP3" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.3.174.1' {
            Write-Host "Version:`t Rollup 4 for Exchange Server 2010 SP3" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.3.169.1' {
            Write-Host "Version:`t Rollup 3 for Exchange Server 2010 SP3" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.3.158.1' {
            Write-Host "Version:`t Rollup 2 for Exchange Server 2010 SP3" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.3.146.0' {
            Write-Host "Version:`t Rollup 1 for Exchange Server 2010 SP3" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.3.123.4' {
            Write-Host "Version:`t Microsoft Exchange Server 2010 SP3" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        # Exchange 2010 SP2
        '14.2.390.3' {
            Write-Host "Version:`t Rollup 8 for Exchange Server 2010 SP2" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.2.375.0' {
            Write-Host "Version:`t Rollup 7 for Exchange Server 2010 SP2" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.2.342.3' {
            Write-Host "Version:`t Rollup 6 for Exchange Server 2010 SP2" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.2.328.10' {
            Write-Host "Version:`t Rollup 5-v2 for Exchange Server 2010 SP2" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.2.328.5' {
            Write-Host "Version:`t Rollup 5 for Exchange Server 2010 SP2" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.2.318.4' {
            Write-Host "Version:`t Rollup 4-v2 for Exchange Server 2010 SP2" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.2.318.2' {
            Write-Host "Version:`t Rollup 4 for Exchange Server 2010 SP2" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.2.309.2' {
            Write-Host "Version:`t Rollup 3 for Exchange Server 2010 SP2" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.2.298.4' {
            Write-Host "Version:`t Rollup 2 for Exchange Server 2010 SP2" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.2.283.3' {
            Write-Host "Version:`t Rollup 1 for Exchange Server 2010 SP2" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.2.247.5' {
            Write-Host "Version:`t Microsoft Exchange Server 2010 SP2" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        # Exchange 2010 SP1
        '14.1.438.0' {
            Write-Host "Version:`t Rollup 8 for Exchange Server 2010 SP1" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.1.421.3' {
            Write-Host "Version:`t Rollup 7-v3 for Exchange Server 2010 SP1" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.1.421.2' {
            Write-Host "Version:`t Rollup 7-v2 for Exchange Server 2010 SP1" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.1.421.0' {
            Write-Host "Version:`t Rollup 7 for Exchange Server 2010 SP1" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.1.355.2' {
            Write-Host "Version:`t Rollup 6 for Exchange Server 2010 SP1" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.1.339.1' {
            Write-Host "Version:`t Rollup 5 for Exchange Server 2010 SP1" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.1.323.6' {
            Write-Host "Version:`t Rollup 4-v2 for Exchange Server 2010 SP1" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.1.323.1' {
            Write-Host "Version:`t Rollup 4 for Exchange Server 2010 SP1" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.1.289.7' {
            Write-Host "Version:`t Rollup 3-v2 for Exchange Server 2010 SP1" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.1.289.3' {
            Write-Host "Version:`t Rollup 3 for Exchange Server 2010 SP1" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.1.270.1' {
            Write-Host "Version:`t Rollup 2 for Exchange Server 2010 SP1" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.1.255.2' {
            Write-Host "Version:`t Rollup 1 for Exchange Server 2010 SP1" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.1.218.15' {
            Write-Host "Version:`t Microsoft Exchange Server 2010 SP1" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        # Exchange 2010
        '14.0.726.0' {
            Write-Host "Version:`t Rollup 5 for Exchange Server 2010" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.0.702.1' {
            Write-Host "Version:`t Rollup 4 for Exchange Server 2010" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.0.694.0' {
            Write-Host "Version:`t Rollup 3 for Exchange Server 2010" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.0.689.0' {
            Write-Host "Version:`t Rollup 2 for Exchange Server 2010" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.0.682.1' {
            Write-Host "Version:`t Rollup 1 for Exchange Server 2010" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        '14.0.639.21' {
            Write-Host "Version:`t Microsoft Exchange Server 2010 RTM" -Fore Green -Back Black;
            $swVar = "2010L";
        };
        # Exchange 2007 SP3
        '8.3.517.0' {
            Write-Host "Version:`t Rollup 23 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007";
        };
        '8.3.502.0' {
            Write-Host "Version:`t Rollup 22 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.485.1' {
            Write-Host "Version:`t Rollup 21 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.468.0' {
            Write-Host "Version:`t Rollup 20 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.459.0' {
            Write-Host "Version:`t Rollup 19 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.445.0' {
            Write-Host "Version:`t Rollup 18 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.417.1' {
            Write-Host "Version:`t Rollup 17 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.406.0' {
            Write-Host "Version:`t Rollup 16 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.389.2' {
            Write-Host "Version:`t Rollup 15 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.379.2' {
            Write-Host "Version:`t Rollup 14 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.348.1' {
            Write-Host "Version:`t Rollup 13 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '​8.3.342.4' {
            Write-Host "Version:`t Rollup 12 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.327.1' {
            Write-Host "Version:`t Rollup 11 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.298.3' {
            Write-Host "Version:`t Rollup 10 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.297.2' {
            Write-Host "Version:`t Rollup 9 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.279.6' {
            Write-Host "Version:`t Rollup 8-v3 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.279.5' {
            Write-Host "Version:`t Rollup 8-v2 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.279.3' {
            Write-Host "Version:`t Rollup 8 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.264.0' {
            Write-Host "Version:`t Rollup 7 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.245.2' {
            Write-Host "Version:`t Rollup 6 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.213.1' {
            Write-Host "Version:`t Rollup 5 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.192.1' {
            Write-Host "Version:`t Rollup 4 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.159.2' {
            Write-Host "Version:`t Rollup 3-v2 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.159.0' {
            Write-Host "Version:`t Rollup 3 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.137.3' {
            Write-Host "Version:`t Rollup 2 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.106.2' {
            Write-Host "Version:`t Rollup 1 for Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.3.083.6' {
            Write-Host "Version:`t Microsoft Exchange Server 2007 SP3" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        # Exchange 2007 SP2
        '8.2.305.3' {
            Write-Host "Version:`t Rollup 5 for Exchange Server 2007 SP2" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.2.254.0' {
            Write-Host "Version:`t Rollup 4 for Exchange Server 2007 SP2" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.2.247.2' {
            Write-Host "Version:`t Rollup 3 for Exchange Server 2007 SP2" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.2.234.1' {
            Write-Host "Version:`t Rollup 2 for Exchange Server 2007 SP2" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.2.217.3' {
            Write-Host "Version:`t Rollup 1 for Exchange Server 2007 SP2" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.2.176.2 ' {
            Write-Host "Version:`t Microsoft Exchange Server 2007 SP2" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        # Exchange 2007 SP1
        '8.1.436.0' {
            Write-Host "Version:`t Rollup 10 for Exchange Server 2007 SP1" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.1.393.1' {
            Write-Host "Version:`t Rollup 9 for Exchange Server 2007 SP1" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.1.375.2' {
            Write-Host "Version:`t Rollup 8 for Exchange Server 2007 SP1" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.1.359.2' {
            Write-Host "Version:`t Rollup 7 for Exchange Server 2007 SP1" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.1.340.1' {
            Write-Host "Version:`t Rollup 6 for Exchange Server 2007 SP1" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.1.336.1' {
            Write-Host "Version:`t Rollup 5 for Exchange Server 2007 SP1" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.1.311.3' {
            Write-Host "Version:`t Rollup 4 for Exchange Server 2007 SP1" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.1.291.2' {
            Write-Host "Version:`t Rollup 3 for Exchange Server 2007 SP1" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.1.278.2' {
            Write-Host "Version:`t Rollup 2 for Exchange Server 2007 SP1" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.1.263.1' {
            Write-Host "Version:`t Rollup 1 for Exchange Server 2007 SP1" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.1.240.6' {
            Write-Host "Version:`t Microsoft Exchange Server 2007 SP1" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        # Exchange 2007
        '8.0.813.0' {
            Write-Host "Version:`t Rollup 7 for Exchange Server 2007" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.0.783.2' {
            Write-Host "Version:`t Rollup 6 for Exchange Server 2007" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.0.754.0' {
            Write-Host "Version:`t Rollup 5 for Exchange Server 2007" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.0.744.0' {
            Write-Host "Version:`t Rollup 4 for Exchange Server 2007" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.0.730.1' {
            Write-Host "Version:`t Rollup 3 for Exchange Server 2007" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.0.711.2' {
            Write-Host "Version:`t Rollup 2 for Exchange Server 2007" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.0.708.3' {
            Write-Host "Version:`t Rollup 1 for Exchange Server 2007" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        '8.0.685.25' {
            Write-Host "Version:`t Microsoft Exchange Server 2007 RTM" -Fore Green -Back Black;
            $swVar = "2007L";
        };
        # Misc
        default {
            Write-Host "Version:`t Unknown Exchange Server version." -Fore Red -Back Black;
        };
    };
    
    switch ($swVar) {
        "2016" {
            Write-Host "This server seems to be up-to-date.`r`n" -Fore Green -Back Black;
        };
        "2016L" {
            Write-Host "You should update to '$($Current_ex2016)'`r`n" -Fore Yellow -Back Black;
        };
        "2013" {
            Write-Host "This server seems to be up-to-date.`r`n" -Fore Green -Back Black;
        };
        "2013L" {
            Write-Host "You should update to '$($Current_ex2013)'`r`n" -Fore Yellow -Back Black;
        };
        "2010" {
            Write-Host "This server seems to be up-to-date.`r`n" -Fore Green -Back Black;
        };
        "2010L" {
            Write-Host "You should update to '$($Current_ex2010)'`r`n" -Fore Yellow -Back Black;
        };
        "2007" {
            Write-Host "This server seems to be up-to-date.`r`n" -Fore Green -Back Black;
        };
        "2007L" {
            Write-Host "You should update to '$($Current_ex2007)'`r`n" -Fore Yellow -Back Black;
        };
        default {
            Write-Host "Something went wrong`r`n" -Fore Red -Back Black;
        }
    }
};
