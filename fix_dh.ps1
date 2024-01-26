# itkibo

# find and remove doubled header in data files
# save fixed files in result directory

[CmdletBinding()]
param(
    $source_path = @(".\???-*.csv"),  # path or paths with filter to process
    $sub_dir = "dh_fixed"  # result sub directory in current catalog
)

# info
@(
    "source: $source_path",
    "file_path; err_rownum"
 ) | Write-Host

$file_cnt = 0
foreach ($file in ($files = Get-ChildItem $source_path -File)) {
    
    $file_path = $file.FullName
    $root_dir = $file.DirectoryName
    $result_path = "$root_dir\$sub_dir\$($file.name)"
    
    $content = [System.IO.File]::ReadAllLines($file, [text.encoding]::GetEncoding(1251))  # file content as is
    $fixed_rows = [System.Text.StringBuilder]::new()  # fixed result

    $err_rownum = 0  # doubled header row number
    $header = ''
    $d_header = $false

    foreach ($line in $content) {

        $err_rownum++
        
        # first line is always header
        if ($err_rownum -eq 1) {
            $header = $line
            # collect header
            [void]$fixed_rows.Append("$line`n")
            continue
        }

        # check line if header again
        if ($line -eq $header) {
            $d_header = $true
            $file_cnt++
            break
        }

        # collect ordinary data row
        [void]$fixed_rows.Append("$line`n")

    }  # foreach line

    # if doubled header detected in file
    if ($d_header -eq $true) {

        # create result file in sub directory
        New-Item -Path $result_path -ItemType File -Force | Out-Null
        [System.IO.File]::AppendAllText($result_path, $fixed_rows.ToString(), [text.encoding]::GetEncoding(1251))

        # show file info
        @(
            $file_path,
            $err_rownum
        ) -join "; " | Write-Host
        
    }  # if

}  # foreach file

# total info
@(
    "files fixed: $file_cnt/$($files.count)",
    "result: $root_dir\$sub_dir"
) | Write-Host
