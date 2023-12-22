@echo off
setlocal enabledelayedexpansion

echo "Let's Get the backend logs"

set /p LIMIT=Enter the number of log streams to retrieve: 

set /p START_DATE=Enter the start date (in YYYY-MM-DD format): 
set /p START_TIME=Enter the start time (in HH:MM:SS format): 
set /p END_DATE=Enter the end date (in YYYY-MM-DD format): 
set /p END_TIME=Enter the end time (in HH:MM:SS format): 

@REM Subtract two hours from the start time
@for /f "tokens=1-3 delims=-" %%a in ("%START_DATE%") do (
    set /a "YEAR=%%a", "MONTH=1%%b-100", "DAY=1%%c-100"
)

@for /f "tokens=1-3 delims=:" %%a in ("%START_TIME%") do (
    set /a "HOUR=1%%a-100", "MINUTE=1%%b-100", "SECOND=1%%c-100"
)

set /a "HOUR-=2"
if !HOUR! lss 0 (
    set /a "HOUR+=24"
    set /a "DAY-=1"
    if !DAY! lss 1 (
        set /a "MONTH-=1"
        if !MONTH! lss 1 (
            set /a "MONTH=12"
            set /a "YEAR-=1"
        )
        set /a "DAY=31"
    )
)

@REM Ensure leading zeros in date and time components
set "MONTH=0%MONTH%" & set "DAY=0%DAY%" & set "HOUR=0%HOUR%" & set "MINUTE=0%MINUTE%" & set "SECOND=0%SECOND%"

@REM Combine components into the adjusted start date and time
set "ADJUSTED_START_DATETIME=%YEAR%-%MONTH:~-2%-%DAY:~-2% %HOUR:~-2%:%MINUTE:~-2%:%SECOND:~-2%"

@REM Convert adjusted start date and time to Unix timestamp in milliseconds
@for /f "delims=" %%a in ('powershell -command "[datetime]::ParseExact('%ADJUSTED_START_DATETIME%', 'yyyy-MM-dd HH:mm:ss', [System.Globalization.CultureInfo]::InvariantCulture).ToUniversalTime().Subtract((Get-Date '1970-01-01').ToUniversalTime()).TotalMilliseconds.ToString('F0')"') do set START_TIMESTAMP=%%a

@REM Subtract two hours from the end time
@for /f "tokens=1-3 delims=-" %%a in ("%END_DATE%") do (
    set /a "YEAR=%%a", "MONTH=1%%b-100", "DAY=1%%c-100"
)

@for /f "tokens=1-3 delims=:" %%a in ("%END_TIME%") do (
    set /a "HOUR=1%%a-100", "MINUTE=1%%b-100", "SECOND=1%%c-100"
)

set /a "HOUR-=2"
if !HOUR! lss 0 (
    set /a "HOUR+=24"
    set /a "DAY-=1"
    if !DAY! lss 1 (
        set /a "MONTH-=1"
        if !MONTH! lss 1 (
            set /a "MONTH=12"
            set /a "YEAR-=1"
        )
        set /a "DAY=31"
    )
)

@REM Ensure leading zeros in date and time components
set "MONTH=0%MONTH%" & set "DAY=0%DAY%" & set "HOUR=0%HOUR%" & set "MINUTE=0%MINUTE%" & set "SECOND=0%SECOND%"

@REM Combine components into the adjusted end date and time
set "ADJUSTED_END_DATETIME=%YEAR%-%MONTH:~-2%-%DAY:~-2% %HOUR:~-2%:%MINUTE:~-2%:%SECOND:~-2%"

@REM Convert adjusted end date and time to Unix timestamp in milliseconds
@for /f "delims=" %%a in ('powershell -command "[datetime]::ParseExact('%ADJUSTED_END_DATETIME%', 'yyyy-MM-dd HH:mm:ss', [System.Globalization.CultureInfo]::InvariantCulture).ToUniversalTime().Subtract((Get-Date '1970-01-01').ToUniversalTime()).TotalMilliseconds.ToString('F0')"') do set END_TIMESTAMP=%%a

@REM AWS CloudWatch Logs log group name
@set LOG_GROUP_NAME=backend_logs

@REM Retrieve the latest log stream name
@for /f "delims=" %%a in ('aws logs describe-log-streams --log-group-name %LOG_GROUP_NAME% --limit 1 --query "logStreams[0].logStreamName" --output text') do set LATEST_LOG_STREAM=%%a

@REM Ensure START_TIMESTAMP is not empty
if "%START_TIMESTAMP%"=="" (
    echo Error: Failed to parse start time. Please check your inputs.
    pause
    exit /b 1
)

@REM Ensure END_TIMESTAMP is not empty
if "%END_TIMESTAMP%"=="" (
    echo Error: Failed to parse end time. Please check your inputs.
    pause
    exit /b 1
)

aws logs get-log-events --log-group-name %LOG_GROUP_NAME% --log-stream-name %LATEST_LOG_STREAM% --limit %LIMIT% --start-time "%START_TIMESTAMP%" --end-time "%END_TIMESTAMP%" || (
    echo Error: Failed to retrieve logs, please check your inputs are correct.
    pause
)

pause
