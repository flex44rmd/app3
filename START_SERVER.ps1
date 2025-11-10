# تشغيل الخادم - PowerShell Script
# انقر نقراً مزدوجاً على هذا الملف لتشغيله

Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "تشغيل الخادم" -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""

# الانتقال إلى مجلد server
Set-Location -Path "server"

# التحقق من ملف .env
if (-not (Test-Path ".env")) {
    Write-Host "⚠️  ملف .env غير موجود!" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "جاري إنشاء ملف .env..." -ForegroundColor Cyan
    & ".\create-env.ps1"
    Write-Host ""
}

Write-Host "جاري تثبيت المكتبات..." -ForegroundColor Yellow
npm install

Write-Host ""
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "تشغيل الخادم..." -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "اضغط Ctrl+C لإيقاف الخادم" -ForegroundColor Yellow
Write-Host ""

npm start

