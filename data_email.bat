del c:\Ferrari_batch_files\data.csv
bcp tallypro..View_Ferrari_Daily out c:\Ferrari_batch_files\ferrari_data.txt -c -t, -T -S WIN-1MUIBAFHT8P\SQLEXPRESS
copy c:\Ferrari_batch_files\*.txt c:\Ferrari_batch_files\data.csv
"E:\SwithMailv2240\SwithMail.exe" /s /x "C:\Ferrari_batch_files\SwithMailSettings.xml"
