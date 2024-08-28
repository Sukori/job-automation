# Define parameters
$csvPath = "other_file.csv"
$outputPath = "other_file-out.csv"
$columnName = "user_id"

# Define list of query substrings
$queryList = @("place2-user07", "place2-user08", "place2-user09", "place2-user10", "place2-user11", "place2-user12")

# Import CSV
$csv = Import-Csv $csvPath

# Loop through each row
foreach ($row in $csv) {
    $text = $row.$columnName
    
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
        }
    }
}

# Export updated CSV
$csv | Export-Csv $outputPath -NoTypeInformation