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
.\data\117-2235_2023-12-12_13.csv; 3
.\data\117-2755_2023-12-12_13.csv; 3
.\data\117-3040_2023-12-12_13.csv; 3
.\data\117-3041_2023-12-12_13.csv; 3
.\data\117-3042_2023-12-12_13.csv; 3
.\data\117-3043_2023-12-12_13.csv; 3
.\data\117-3184_2023-12-12_13.csv; 3
.\data\117-3186_2023-12-12_13.csv; 3
.\data\117-3187_2023-12-12_13.csv; 3
.\data\117-3188_2023-12-12_13.csv; 6
.\data\117-3198_2023-12-12_13.csv; 3
.\data\117-3199_2023-12-12_13.csv; 3
.\data\117-3200_2023-12-12_13.csv; 3
.\data\117-3201_2023-12-12_13.csv; 3
.\data\117-3202_2023-12-12_13.csv; 3
.\data\117-3203_2023-12-12_13.csv; 3
.\data\117-3204_2023-12-12_13.csv; 3
.\data\117-3205_2023-12-12_13.csv; 2921
.\data\117-3283_2023-12-12_13.csv; 3
.\data\117-3319_2023-12-12_13.csv; 3
.\data\117-3374_2023-12-12_13.csv; 3
.\data\117-3446_2023-12-12_13.csv; 3
files fixed: 22/530
result: .\data\dh_fixed
```
# gen_time.ps1
It generates missed hours data files

```
# generate data files with hours in range 11..23 based on existing source 10-hour file
.\gen_time.ps1 -source_path .\data\*.csv -hour_basic 10 -hours @(11..23)

# result

source: .\data\*.csv
file: 117-2235_2024-1-26_10.csv
result_path; gen_cnt; hour_basic; ratio; sec_ajust
.\data\time_fixed\117-2235_2024-1-26_11.csv; 1; 10; 1 x 3600 = 3600
.\data\time_fixed\117-2235_2024-1-26_12.csv; 1; 10; 2 x 3600 = 7200
.\data\time_fixed\117-2235_2024-1-26_13.csv; 1; 10; 3 x 3600 = 10800
.\data\time_fixed\117-2235_2024-1-26_14.csv; 1; 10; 4 x 3600 = 14400
.\data\time_fixed\117-2235_2024-1-26_15.csv; 1; 10; 5 x 3600 = 18000
.\data\time_fixed\117-2235_2024-1-26_16.csv; 1; 10; 6 x 3600 = 21600
.\data\time_fixed\117-2235_2024-1-26_17.csv; 1; 10; 7 x 3600 = 25200
.\data\time_fixed\117-2235_2024-1-26_18.csv; 1; 10; 8 x 3600 = 28800
.\data\time_fixed\117-2235_2024-1-26_19.csv; 1; 10; 9 x 3600 = 32400
.\data\time_fixed\117-2235_2024-1-26_20.csv; 1; 10; 10 x 3600 = 36000
.\data\time_fixed\117-2235_2024-1-26_21.csv; 1; 10; 11 x 3600 = 39600
.\data\time_fixed\117-2235_2024-1-26_22.csv; 1; 10; 12 x 3600 = 43200
.\data\time_fixed\117-2235_2024-1-26_23.csv; 1; 10; 13 x 3600 = 46800

source: .\data\*.csv
file: 117-2755_2024-1-26_10.csv
result_path; gen_cnt; hour_basic; ratio; sec_ajust
.\data\time_fixed\117-2755_2024-1-26_11.csv; 1; 10; 1 x 3600 = 3600
.\data\time_fixed\117-2755_2024-1-26_12.csv; 1; 10; 2 x 3600 = 7200
.\data\time_fixed\117-2755_2024-1-26_13.csv; 1; 10; 3 x 3600 = 10800
.\data\time_fixed\117-2755_2024-1-26_14.csv; 1; 10; 4 x 3600 = 14400
.\data\time_fixed\117-2755_2024-1-26_15.csv; 1; 10; 5 x 3600 = 18000
.\data\time_fixed\117-2755_2024-1-26_16.csv; 1; 10; 6 x 3600 = 21600
.\data\time_fixed\117-2755_2024-1-26_17.csv; 1; 10; 7 x 3600 = 25200
.\data\time_fixed\117-2755_2024-1-26_18.csv; 1; 10; 8 x 3600 = 28800
.\data\time_fixed\117-2755_2024-1-26_19.csv; 1; 10; 9 x 3600 = 32400
.\data\time_fixed\117-2755_2024-1-26_20.csv; 1; 10; 10 x 3600 = 36000
.\data\time_fixed\117-2755_2024-1-26_21.csv; 1; 10; 11 x 3600 = 39600
.\data\time_fixed\117-2755_2024-1-26_22.csv; 1; 10; 12 x 3600 = 43200
.\data\time_fixed\117-2755_2024-1-26_23.csv; 1; 10; 13 x 3600 = 46800
...
```
# fix_regex.ps1
It replaces broken strings in data files by regex patterns from config file  
By default it reads replace rules from config file .\fix_regex_pattern.txt

```
.\fix_regex.ps1 -source_path .\data\*.csv

# result

source: .\data\*.csv
file_path; err_cnt
.\data\117-3040_2023-9-29_17.csv; 743

pat            val                hits
---            ---                ----
;\s+\d,[^\d]*; ;        0,000000;  371
0,0            0.0                 372

.\data\117-3040_2023-9-29_18.csv; 7200

pat            val                hits
---            ---                ----
;\s+\d,[^\d]*; ;        0,000000; 3600
0,0            0.0                3600

.\data\117-3040_2023-9-29_19.csv; 7200

pat            val                hits
---            ---                ----
;\s+\d,[^\d]*; ;        0,000000; 3600
0,0            0.0                3600

files fixed: 3/3
result: .\data\regex_fixed
```
