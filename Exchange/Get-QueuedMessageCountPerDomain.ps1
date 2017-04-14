#####
# File name: Get-QueuedMessageCountPerDomain.ps1
# Description: Microsoft Exchange script for retrieving count of messages in queue per sender domainname.
#              This script must be run from the Exchange management shell.
# Version: 1.00
# Date of last edit: 2017/04/14
#
# Authors: Thimo Braker
#
# (c) 2017 - Thimo - All rights reserved.
#####

Param (
    [String] $HUBServer = "",
    [String] $QueueName = ""
);

# Constants
$EOL = "`r`n";

While ($HUBServer -eq "") {
    $HUBServer = Read-Host "Exchange HUB server name (Type 'Exit' to quit)";

    If ($HUBServer.ToLower() -eq "exit") { 
        Write-Host "Exit command entered!" $EOL "Closing down script." $EOL `
                   -Fore Red -Back Black;
        Exit; 
    } else {
        If ($HUBServer -ne "") {
            Write-Host "Queue names:";
            Get-Queue -Server $HUBServer | ft;
        };
    };
};

While ($QueueName -eq "") {
    $QueueName = Read-Host "Exchange mail queue name (Type 'Exit' to quit)";

    If ($QueueName.ToLower() -eq "exit") { 
        Write-Host "Exit command entered!" $EOL "Closing down script." $EOL `
                   -Fore Red -Back Black;
        Exit; 
    };
};

$DomainNames = New-Object System.Collections.ArrayList;
$QMessages   = Get-Queue -Identity $QueueName | Get-Message;

Foreach ($Message in $QMessages) {
    If ($Message.FromAddress -eq "<>" -Or $Message.FromAddress -eq $Null) {
        $DomainName = $Message.FromAddress;
    } else {
        $DomainName = $Message.FromAddress.Split('@')[1];
    };

    If ($DomainNames.Contains($DomainName) -eq $False) {
        $DomainNames.Add($DomainName) > $Null;
    };
};

Foreach ($DName in $DomainNames) {
    If ($DName -eq "<>" -Or $DName -eq $Null) {
        $MessageCount = ($QMessages | Where {$_.FromAddress -eq "$($DName)"}).Count;
    } else {
        $MessageCount = ($QMessages | Where {$_.FromAddress -like "*@$($DName)"}).Count;
    };

    If ($MessageCount -eq $Null) { # Fix PS bug that finds it difficult to count an array with only one item
        $MessageCount = 1;
    };

    Write-Host " Domain name:           $($DName)$($EOL)"`
               "Queued message count:  $($MessageCount)$($EOL)";
};
