# Define parameters
$csvPath = "file.csv"
$outputPath = "file-out.csv"
$columnName = "user_id"
$uuidColumn = "column_id"

# Define list of query substrings
$queryList = @("place2-user07", "place2-user08")

# if -redacted place-, do not forget to give 2 uuid per user above
$uuidList = @("list of random uuids", "same number as users")

# Import CSV
$csv = Import-Csv $csvPath

$replacementIndex = 0

# Loop through each row
foreach ($row in $csv) {
    $text = $row.$columnName
	$updated = $false
    
    # Check if any query substring is in the text
    $matchedQuery = $queryList | Where-Object { $text -like "*$_*" } | Select-Object -First 1
    
    if ($matchedQuery) {
        if ($text -match "(.+)@(.+)") {
            $prefix = $matches[1]
            $suffix = $matches[2]
            
            if ($prefix -match "(.+)-(\d+)$") {
                # Version number exists, increment it
				$baseName = $matches[1]
                $version = [int]$matches[2]
                $newVersion = $version + 1
                $newPrefix = "{0}-{1:D3}" -f $baseName, $newVersion
            } else {
                # No version number, initialize to -001
                $newPrefix = "$prefix-001"
            }
            
            $row.$columnName = "$newPrefix@$suffix"
			$updated = $true
        }
    }
 # If the row was updated, also update the other column
 	if ($updated) {
		if ($replacementIndex -lt $uuidList.Count) {
			$row.$uuidColumn = $uuidList[$replacementIndex]
			$replacementIndex++
		} else {
			Write-Warning "Ran out of replacement data. Leaving $uuidColumn unchanged for row: $($row.$versionColumnName)"
		}
	}
}

# Export updated CSV
$csv | Export-Csv $outputPath -NoTypeInformation