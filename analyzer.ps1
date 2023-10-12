# itkibo

# analyze directory content
# to identify missing files

[CmdletBinding()]
param(
    [string]$source_path = ".\???-*.csv",
    [switch]$save_csv,  # save files list into csv
    [string]$flist_path = ".\flist_$(get-date -f 'ddMMyyyy_HHmmss').csv",
    $prm_const = @(2235, 2755, 3040, 3041, 3042, 3043, 3184, 3186, 3187, 3188, 3198, 3199, 3200, 3201, 3202, 3203, 3204, 3205, 3283, 3319, 3374, 3382, 3446),
    $hour_const = @(0..23),
    [string]$sep = ';'
)

if (-not(Test-Path -Path $source_path)) {
    Write-Host "no files or folder not exists $source_path"
    exit
}

# create new csv file if option enabled
if ($save_csv) { "sep=$sep" > $flist_path }

# collect data from directory into hashtable
$flist = @{}
foreach ($file in Get-Item -Path $source_path) {

    # file name example: 117-2235_2023-9-29_23
    $file_row = $file.name -replace '-', ';' -replace '_', ';' -replace '.csv', ''

    # add row to file if option enabled
    if ($save_csv) { $file_row >> $flist_path }

    $arr_name = $file_row.Split(';')
    $key_prm = [int]$arr_name[1]
    $val_hour = [int]$arr_name[5]
    if (-not $flist.ContainsKey($key_prm)) {
        $flist[$key_prm] = [System.Collections.Generic.List[int]]::new()
    }
    # append value
    $flist[$key_prm].Add($val_hour)

}  # foreach

# print hours matrix
foreach ($prm in $prm_const) {

    # sort list inplace
    $flist[$prm].Sort()
    
    $row = ''
    for ($i=0; $i -le $hour_const.count-1; $i++) {

        if ($hour_const[$i] -in $flist[$prm]) {
            # hour exists
            $row = $row + "{0:d2}" -f $hour_const[$i] + ' '
        } else {
            # gap
            $row = $row + '..' + ' '
        }
      
    }  # for

    # print header
    if ($prm -eq $prm_const[0]) {
        "{0} | {1}" -f ('prm (cnt\tot)'), (($hour_const | % { "{0:d2}" -f $_ }) -join ' ')
        "{0} | {1}" -f ('-'*13), ('---'*$hour_const.count)
    }

    # print ordinary row
    "{0} ({1:d2}\{2:d2})  | {3}" -f $prm, $flist[$prm].count, $hour_const.count, $row

}  # foreach
