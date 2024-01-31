# itkibo

# generate missed data files based on existing files
# save created files in result directory

[CmdletBinding()]
param(
    $source_path = @(".\???-*.csv"),  # path or paths with filter to process
    $sec = 3600,  # value of one step (hour) in seconds 
    $hour_basic = 0,  # basic hour for generating files (should be equal source files hour)
    $hours = @(0..23),  # hours needed to generate
    $sub_dir = "time_fixed"  # result sub directory
)


function Ajust_time {
    param (
        $content,  # basic rows to ajust
        $sec_ajust  # time ajustment
    )

    # modified result
    $gen_rows = [System.Text.StringBuilder]::new()

    $gen_cnt = 0
    foreach ($line in $content) {

        # match time field in row like: 1706212800;        0,000000;3
        $result = [regex]::match($line, "(\d{10});.*")

        if ($result.Success -eq $true) {

            $gen_cnt++
            # basic seconds field value
            $sec_basic = [int]$result.groups[1].Value
            # ajust time value
            $line_fixed = $line -replace $sec_basic, $([int]$sec_basic + [int]$sec_ajust)
            # add row with modified time
            [void]$gen_rows.Append("$line_fixed`n")

        } else {
            # add row as is
            [void]$gen_rows.Append("$line`n")
        }

    }  # foreach line

    return @($gen_rows, $gen_cnt)

}  # function


<#
    GO
#>

$file_cnt = 0  # source files counter
$result_cnt = 0  # result files counter

foreach ($file in ($files = Get-ChildItem $source_path -File)) {

    $file_cnt++
    $file_path = $file.FullName
    $source_dir = $file.Directory.FullName

    $result_dir = "{0}\{1}" -f $source_dir, $sub_dir

    if (-not(Test-Path -Path $result_dir -Type Container)) {
        New-Item -Path $result_dir -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
    }

    @(
        "source: $source_path",
        "file: $($file.Name)",
        "result_path; gen_cnt; hour_basic; ratio; sec_ajust"
    ) | Write-Host

    # get file content
    if (-not($content = [System.IO.File]::ReadAllLines($file_path, [text.encoding]::GetEncoding(1251)))) {
        "can not read file $($file.name)" | Write-Warning
        continue
    }
    
    # iterate over needed hours
    foreach ($hour_needed in $hours) {
        
        # ratio example: 10 = 10 - 0, -1 = 9 - 10
        $ratio = $hour_needed - $hour_basic
        $sec_ajust = $sec*$ratio

        # generate new rows
        $gen_rows = Ajust_time -content $content -sec_ajust $sec_ajust

        # result file full path
        $result_path = "{0}\{1}" -f $result_dir, $file.name.Replace("_$($hour_basic).csv","_$($hour_needed).csv")
        $result_cnt++

        try {
            # overwrite
            [System.IO.File]::WriteAllText($result_path, $gen_rows[0].ToString(), [text.encoding]::GetEncoding(1251))
        } catch {
            "can not write file $result_path" | Write-Warning
            $result_cnt--
        }    

        # show info per file
        @(
            $result_path,
            $gen_rows[1],
            $hour_basic,
            "$ratio x $sec = $sec_ajust"
        ) -join "; " | Write-Host

    }  # foreach ratio

}  # foreach file

@(
    "source files: $file_cnt/$($files.count)",
    "result files: $result_cnt"
) | Write-Host
