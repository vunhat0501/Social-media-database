@echo off
SET CONTAINER_NAME=typeorm_postgres
SET DB_USER=postgres
SET DB_NAME=postgres
SET BACKUP_DIR=%~dp0archives

echo Available backups:
dir /b "%BACKUP_DIR%\*.sql"
echo.

set /p BACKUP_FILE="enter the backup file name to restore: "

IF NOT EXIST "%BACKUP_DIR%\%BACKUP_FILE%" (
  echo.
  echo ERROR: "%BACKUP_FILE%" not found.
  pause
  exit /b
)

echo.
echo rolling back database to state from backup "%BACKUP_FILE%"
docker exec -i %CONTAINER_NAME% psql -U %DB_USER% -d %DB_NAME% < "%BACKUP_DIR%\%BACKUP_FILE%"

echo.
echo rollback complete
pause