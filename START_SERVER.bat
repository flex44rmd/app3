@echo off
chcp 65001 >nul
echo ===========================================
echo تشغيل الخادم
echo ===========================================
echo.

cd server

echo جاري التحقق من ملف .env...
if not exist .env (
    echo.
    echo ⚠️  ملف .env غير موجود!
    echo.
    echo جاري إنشاء ملف .env...
    call create-env.ps1
    echo.
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

