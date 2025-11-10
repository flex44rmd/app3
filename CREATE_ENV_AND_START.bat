@echo off
chcp 65001 >nul
echo ===========================================
echo إنشاء ملف .env وتشغيل الخادم
echo ===========================================
echo.

cd server

echo جاري إنشاء ملف .env...
if exist create-env.ps1 (
    powershell -ExecutionPolicy Bypass -File create-env.ps1
) else (
    echo إنشاء ملف .env يدوياً...
    (
        echo # MySQL Database Configuration for InfinityFree
        echo DB_HOST=sql112.infinityfree.com
        echo DB_PORT=3306
        echo DB_USER=if0_40376337
        echo DB_PASSWORD=eRdbAFO2dIuMLoz
        echo DB_NAME=if0_40376337_test
        echo PORT=3000
        echo NODE_ENV=production
    ) > .env
    echo ✅ تم إنشاء ملف .env
)

echo.
echo جاري تثبيت المكتبات...
call npm install

echo.
echo ===========================================
echo تشغيل الخادم...
echo ===========================================
echo.
echo اضغط Ctrl+C لإيقاف الخادم
echo.

call npm start

pause

