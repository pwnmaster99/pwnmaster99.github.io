@echo off

for %%f in (*.html) do (
    set "name=%%~nf"
    call mkdir "%%~nf"
    call move "%%f" "%%~nf\index.html"
)

echo Done.
pause