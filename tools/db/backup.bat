@echo off
:: use powershell to change Date Time to yyyyMMddHHmmss format
for /f %%I in ('powershell -Command "Get-Date -Format 'yyyyMMddHHmmss'"') do set TIMESTAMP=%%I

SET CONTAINER_NAME=typeorm_postgres
SET DB_USER=postgres
SET DB_NAME=postgres

:: set the backup directory relative to where this script is located
SET BACKUP_DIR=%~dp0archives

:: create archive folder if not exist
IF NOT EXIST "%BACKUP_DIR%" (
  mkdir "%BACKUP_DIR%"
)

echo Backing up database

:: create backup with pg_dump and timestamp
docker exec %CONTAINER_NAME% pg_dump -U %DB_USER% -d %DB_NAME% --clean > "%BACKUP_DIR%\backup_%TIMESTAMP%.sql"

echo Backed up database successfully. check "%BACKUP_DIR%" folder for backup_%TIMESTAMP%.sql
pause