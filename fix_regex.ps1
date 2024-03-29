# itkibo

# find and replace incorrect values by regex patterns in config
# save fixed files in result directory

[CmdletBinding()]
param(
    $source_path = @(".\???-*.csv"),  # path or paths with filter to process
    $sub_dir = "regex_fixed",  # result sub directory in current catalog
    $patt_path = '.\fix_regex_pattern.txt'  # replace rules config
)


if (-not(Test-Path -Path $patt_path -PathType Leaf)) {
    "No regex pattern file" | Write-Host
}

$regex_config = Import-Csv -Path $patt_path -Delimiter '@' -Encoding UTF8 -Header pat, val

# info
@(
    "source: $source_path",    
    "file_path; err_cnt"
 ) | Write-Host

$file_cnt = 0  # broken files counter
foreach ($file in ($files = Get-ChildItem $source_path -File)) {

    $file_path = $file.FullName
    $root_dir = $file.DirectoryName
    $result_path = "$root_dir\$sub_dir\$($file.name)"

    # replace property for counting matches
    $regex_config | Add-Member -MemberType NoteProperty -Name 'hits' -Value 0 -Force
    
    $content = [System.IO.File]::ReadAllLines($file_path, [text.encoding]::GetEncoding(1251))  # file content as is
    $fixed_rows = [System.Text.StringBuilder]::new()  # fixed result
    
    $err_cnt = 0  #  broken rows counter
    foreach ($row in $content) {

        $row_fixed = $row
        # test all patterns from config on the current row
        for ($i=0; $i -lt $regex_config.length; $i++) {
            
            # broken row example 1696003200;        0, ;3
            # correct row should be 1696003200;        0,000000;3
            if ($row_fixed -match $regex_config[$i].pat) {
                $err_cnt++
                # replace broken value
                $row_fixed = $row_fixed -replace $regex_config[$i].pat, $regex_config[$i].val
                $regex_config[$i].hits +=1
            }  # if
    
        }  # for
        
        if ($row -ne $row_fixed) {
            # append modified row
            [void]$fixed_rows.Append("$row_fixed`n")
        }  else {
            # append original row if nothing changed
            [void]$fixed_rows.Append("$row`n")
        }  # if

    }  # foreach line

    # build new correct file if any fixes
    if ($err_cnt -ne 0) {

        $file_cnt++

        # create result file + sub directory
        New-Item -Path $result_path -ItemType File -Force | Out-Null
        [System.IO.File]::AppendAllText($result_path, $fixed_rows.ToString(), [text.encoding]::GetEncoding(1251))

        # show info per file
        @(
            $file_path,
            $err_cnt
        ) -join "; " | Write-Host

        # show hits
        $regex_config | ft

    }  # if

}  # foreach file

# total info
@(
    "files fixed: $file_cnt/$($files.count)",
    "result: $root_dir\$sub_dir"
) | Write-Host
