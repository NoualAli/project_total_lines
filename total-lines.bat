@echo off
@echo Calculating the total number of lines for PHP, JS, VueJs, Sass, CSS...
@echo The calculation doesn't factor in the vendor, node_modules, public, and storage folders.
@echo --------------------------------------------------------------------------------------------
set phpLineCount=0
set JsLineCount=0
set StyleLineCount=0

for /f %%A in ('powershell -Command "& {(Get-ChildItem -Include *.php -Recurse | Where-Object {$_.FullName -notlike '*\Vendor\*' -and $_.FullName -notlike '*\node_modules\*' -and $_.FullName -notlike '*\public\*' -and $_.FullName -notlike '*\storage\*'} | Get-Content | Measure-Object -Line).Lines}"') do set /a phpLineCount+=%%A
for /f %%A in ('powershell -Command "& {(Get-ChildItem -Include *.js, *.vue -Recurse | Where-Object {$_.FullName -notlike '*\Vendor\*' -and $_.FullName -notlike '*\node_modules\*' -and $_.FullName -notlike '*\public\*' -and $_.FullName -notlike '*\storage\*'} | Get-Content | Measure-Object -Line).Lines}"') do set /a JsLineCount+=%%A
for /f %%A in ('powershell -Command "& {(Get-ChildItem -Include *.sass, *.css -Recurse | Where-Object {$_.FullName -notlike '*\Vendor\*' -and $_.FullName -notlike '*\node_modules\*' -and $_.FullName -notlike '*\public\*' -and $_.FullName -notlike '*\storage\*'} | Get-Content | Measure-Object -Line).Lines}"') do set /a StyleLineCount+=%%A

set /a TotalLines = phpLineCount + JsLineCount + StyleLineCount

@echo The total number of lines for PHP is: %phpLineCount%
@echo --------------------------------------------------
@echo The total number of lines for JS and VueJs is: %JsLineCount%
@echo --------------------------------------------------
@echo The total number of lines for CSS and Sass is: %StyleLineCount%
@echo --------------------------------------------------
@echo The overall total number of lines is: %TotalLines%
