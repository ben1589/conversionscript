:: Bat file
:: V 6.0
@echo off
setlocal
:PROMPT
SET /P AREYOUSURE=Did you remember to add folder.jpg? (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END

:END
endlocal
SetLocal EnableExtensions EnableDelayedExpansion
echo off

CLS

set hbinput=%1
echo Input  = !hbinput!

::Extract Folder name and File name

for /f "tokens=*" %%G in ('dir /b /s !hbinput! ') do ( 
	set outputpath=%%~dpG
	set inputfilenamextn=%%~nxG
	set inputfilename=%%~nG

	echo Full path = !outputpath!
	echo File name = !inputfilenamextn!
	)


::Switch working directory
cd /d "!outputpath!"

::Do the MKV Tool commands here
echo C:\Program Files\MKVToolNix\mkvmerge.exe -o "mkvmerge-!inputfilename!.mkv" --split chapters:all "!inputfilenamextn!"
"C:\Program Files\MKVToolNix\mkvmerge.exe" -o "mkvmerge-!inputfilename!.mkv" --split chapters:all "!inputfilenamextn!"

::Remove Source file
timeout 1
del "!inputfilename!.mkv"

::Process ffmpeg for .mkv

for /f "tokens=*" %%K in ('dir /b *.mkv') do (
	set ffmpegfilenamextn=%%~nxK
	set ffmpegfilename=%%~nxK
	echo.
	echo C:\ffmpeg\bin\ffmpeg.exe -i "!ffmpegfilenamextn!" -loop 1 -i folder.jpg -map 1:v -map 0:a -c:a ac3 -b:a 640K -pix_fmt yuv420p -c:v libx264 -shortest -fflags +shortest -max_interleave_delta 100M "ffmpeg-!ffmpegfilename!.sa.m4v"
	C:\ffmpeg\bin\ffmpeg.exe -i "!ffmpegfilenamextn!" -loop 1 -i folder.jpg -map 1:v -map 0:a -c:a ac3 -b:a 640K -pix_fmt yuv420p -c:v libx264 -shortest -fflags +shortest -max_interleave_delta 100M "ffmpeg-!ffmpegfilename!.sa.m4v"
	)


::Process ffmpeg for .flac
for /f "tokens=*" %%K in ('dir /b *.flac') do (
	set ffmpegfilenamextn=%%~nxK
		set ffmpegfilename=%%~nK
	echo.
	echo C:\ffmpeg\bin\ffmpeg.exe -i "!ffmpegfilenamextn!" -loop 1 -i folder.jpg -map 1:v -map 0:a -c:a ac3 -b:a 640K -pix_fmt yuv420p -c:v libx264 -shortest -fflags +shortest -max_interleave_delta 100M "ffmpeg-!ffmpegfilename!.sa.m4v"
	C:\ffmpeg\bin\ffmpeg.exe -i "!ffmpegfilenamextn!" -loop 1 -i folder.jpg -map 1:v -map 0:a -c:a ac3 -b:a 640K -pix_fmt yuv420p -c:v libx264 -shortest -fflags +shortest -max_interleave_delta 100M "ffmpeg-!ffmpegfilename!.sa.m4v"
	)

pause
