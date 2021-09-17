# Cole Newby

# September 17, 2021

# This script gathers DNS names from associated IP addrs and outputs them to a csv

# Note: The path for the csv file needs to be changed for the specific local path,
#       and the values for the column headers need to be changed to match the values in this code


# initalizing variables
$ipList = @()
$dnsList = @()
$final = @()

# getting IPs
Import-Csv C:\Users\cnewby\Desktop\ipToDNS\file.csv | ForEach-Object {
    $ipList += $_.SourceAddress
    try {
        $dnsList += ([system.net.dns]::GetHostByAddress($_.SourceAddress)).hostname
    }
    catch {
        $dnsList += 'None Found'
    }
    $_.SourceAddress
}
$dnsList

for ($i = 0; $i -lt $ipList.Count; $i++) {
    $rowToAdd = New-Object psobject
    $currIP = $ipList[$i]
    $currDNS = $dnsList[$i]
    $rowToAdd | Add-Member -MemberType NoteProperty -Name 'IP Address' -Value $currIP
    $rowToAdd | Add-Member -MemberType NoteProperty -Name 'DNS Name' -Value $currDNS

    $final += $rowToAdd
}

$final | Export-Csv -Path 'C:\Users\cnewby\Desktop\ipToDNS\DNSfromIPList.csv' -NoTypeInformation
