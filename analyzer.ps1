# itkibo

# analyze directory content
# to identify missing files
# print matrix result

[CmdletBinding()]
param(
    [string]$source_path = ".\???-*.csv",  # data files source + filter
    $prm_const = @(2235, 2755, 3040, 3041, 3042, 3043, 3184, 3186, 3187, 3188, 3198, 3199, 3200, 3201, 3202, 3203, 3204, 3205, 3283, 3319, 3374, 3382, 3446),
    $hour_const = @(0..23),
    [switch]$csv_save,  # save files list into csv
    [string]$csv_path= ".\prm_list_$(get-date -f 'ddMMyyyy_HHmmss').csv",  # csv file name
    [string]$sep = ';'  # csv fields delimiter
)

if (-not(Test-Path -Path $source_path)) {
    Write-Host "files or folder not exists $source_path"
    exit
}

# info
"source: $source_path" | Write-Host

# create new csv file if option enabled
# it will contain only existing file parameters
if ($csv_save) {
    "sep=$sep" > $csv_path
    "csv file created $csv_path" | Write-Host
}

# collect data from directory into hashtable
# key = parameter, value = array of hours
# $prm_list will contain only existing parameters
$prm_list = @{}
foreach ($file in ($files = Get-Item -Path $source_path)) {

    # file name example: 117-2235_2023-9-29_23
    # build row based on file name like: 117;2235;2023;9;29;23
    $file_row = $file.name -replace '-', ';' -replace '_', ';' -replace '.csv', ''

    # add row to csv file if option enabled
    if ($csv_save) {$file_row >> $csv_path}

    $arr_name = $file_row.Split(';')
    $key_prm = [int]$arr_name[1]
    $val_hour = [int]$arr_name[5]
    if (-not $prm_list.ContainsKey($key_prm)) {
        $prm_list[$key_prm] = [System.Collections.Generic.List[int]]::new()
    }
    # append value
    $prm_list[$key_prm].Add($val_hour)

}  # foreach

# show count files info
"files detected: {0}/{1}" -f $files.Count, $($prm_const.Count*$hour_const.Count) | Write-Host

# print matrix hours
# $prm_list will contain all needed parameters, append empty parameters if needed
foreach ($prm in $prm_const) {

    if ($prm_list.ContainsKey($prm)) {
        # sort list in place
        $prm_list[$prm].Sort()
    } else {
        # add empty key, no file detected
        $prm_list.Add($prm, @())
    }
    
    $row = ''
    for ($i=0; $i -le $hour_const.count-1; $i++) {

        if ($hour_const[$i] -in $prm_list[$prm]) {
            # hour exists
            $row = $row + "{0:d2}" -f $hour_const[$i] + ' '
        } else {
            # gap
            $row = $row + '..' + ' '
        }
      
    }  # for

    # print matrix header
    if ($prm -eq $prm_const[0]) {
        "{0} | {1}" -f ('prm (cnt/tot)'), (($hour_const | % { "{0:d2}" -f $_ }) -join ' ')
        "{0} | {1}" -f ('-'*13), ('---'*$hour_const.count)
    }

    # print matrix ordinary row
    "{0} ({1:d2}/{2:d2})  | {3}" -f $prm, $prm_list[$prm].count, $hour_const.count, $row

}  # foreach
