####
#
# Author: Thimo Braker
# Version: 1.2
# Date: 2017/01/05
#
####

Param (
    [String] $dagName = ""
);

while ($dagName -eq "") {
    $dagName = Read-Host "DAG name (Type 'Exit' to quit)";

    if ($dagName.ToLower() -eq "exit") { 
        Write-Host "Exit command entered!`r`nClosing down script.`r`n" -Fore Red -Back Black;
        Exit; 
    };
};

"NewLog" > ".\$($dagName)UsersUsage.txt"

get-mailbox -database $dagName | ForEach {
    get-mailboxstatistics $_ | fl DisplayName,CurrentSchemaVersion,AssociatedItemCount,ItemCount,TotalItemSize,DeletedItemCount,TotalDeletedItemSize,NamedPropertiesCountQuota,MessageTableAvailableSize,MessageTableTotalSize,AttachmentTableAvailableSize,AttachmentTableTotalSize,OtherTablesAvailableSize,OtherTablesTotalSize,DatabaseIssueWarningQuota,DatabaseProhibitSendQuota,DatabaseProhibitSendReceiveQuota >> ".\$($dagName)UsersUsage.txt"
};
