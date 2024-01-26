# analyzer.ps1
It helps to determine errors in data files  
Fast determines missing files/parameters/hours and show result in matrix form  

```
# process files from data folder by mask + save result as csv
# csv file will contain only existing parameters
# matrix result shows all parameters existing + missing (gaps)

# get files by mask
.\analyzer.ps1 -source_path .\data\???-*.csv -csv_save
# get all files from directory + save result to csv
.\analyzer.ps1 -source_path .\data\ -csv_save

# result

source: .\data\???-*.csv
csv file created .\prm_list_15012024_170118.csv
files detected: 528/552
prm (cnt/tot) | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23
------------- | ------------------------------------------------------------------------
2235 (23/24)  | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 .. 22 23
2755 (23/24)  | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 .. 22 23
3040 (23/24)  | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 .. 22 23
3041 (23/24)  | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 .. 22 23
3042 (23/24)  | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 .. 22 23
3043 (23/24)  | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 .. 22 23
3184 (23/24)  | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 .. 22 23
3186 (23/24)  | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 .. 22 23
3187 (23/24)  | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 .. 22 23
3188 (23/24)  | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 .. 22 23
3198 (23/24)  | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 .. 22 23
3199 (23/24)  | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 .. 22 23
3200 (23/24)  | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 .. 22 23
3201 (23/24)  | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 .. 22 23
3202 (23/24)  | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 .. 22 23
3203 (23/24)  | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 .. 22 23
3204 (23/24)  | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 .. 22 23
3205 (23/24)  | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 .. 22 23
3283 (23/24)  | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 .. 22 23
3319 (23/24)  | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 .. 22 23
3374 (23/24)  | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 .. 22 23
3382 (22/24)  | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 .. .. 23
3446 (23/24)  | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 .. 22 23
```
# fix_dh.ps1
It finds doubled header in data files  
Shows incorrect files, error row and save fixed result in directory

```
.\fix_dh.ps1 -source_path .\data\
.\fix_dh.ps1 -source_path .\data\???-*.csv

# result

source: .\data\
file_path; err_rownum
.\data\dh_exmpl1\117-2235_2023-12-12_13.csv; 3
.\data\dh_exmpl1\117-2755_2023-12-12_13.csv; 3
.\data\dh_exmpl1\117-3040_2023-12-12_13.csv; 3
.\data\dh_exmpl1\117-3041_2023-12-12_13.csv; 3
.\data\dh_exmpl1\117-3042_2023-12-12_13.csv; 3
.\data\dh_exmpl1\117-3043_2023-12-12_13.csv; 3
.\data\dh_exmpl1\117-3184_2023-12-12_13.csv; 3
.\data\dh_exmpl1\117-3186_2023-12-12_13.csv; 3
.\data\dh_exmpl1\117-3187_2023-12-12_13.csv; 3
.\data\dh_exmpl1\117-3188_2023-12-12_13.csv; 6
.\data\dh_exmpl1\117-3198_2023-12-12_13.csv; 3
.\data\dh_exmpl1\117-3199_2023-12-12_13.csv; 3
.\data\dh_exmpl1\117-3200_2023-12-12_13.csv; 3
.\data\dh_exmpl1\117-3201_2023-12-12_13.csv; 3
.\data\dh_exmpl1\117-3202_2023-12-12_13.csv; 3
.\data\dh_exmpl1\117-3203_2023-12-12_13.csv; 3
.\data\dh_exmpl1\117-3204_2023-12-12_13.csv; 3
.\data\dh_exmpl1\117-3205_2023-12-12_13.csv; 2921
.\data\dh_exmpl1\117-3283_2023-12-12_13.csv; 3
.\data\dh_exmpl1\117-3319_2023-12-12_13.csv; 3
.\data\dh_exmpl1\117-3374_2023-12-12_13.csv; 3
.\data\dh_exmpl1\117-3446_2023-12-12_13.csv; 3
files fixed: 22/530
result: .\data\dh_exmpl1\dh_fixed
```
