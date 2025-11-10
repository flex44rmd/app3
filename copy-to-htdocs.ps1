# Script to copy Flutter Web files to htdocs folder for InfinityFree deployment
# Run this script: .\copy-to-htdocs.ps1

Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "نسخ ملفات Flutter Web إلى مجلد htdocs" -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""

# Check if htdocs folder exists, create if not
if (-not (Test-Path "htdocs")) {
    Write-Host "إنشاء مجلد htdocs..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path "htdocs" | Out-Null
    Write-Host "✅ تم إنشاء مجلد htdocs" -ForegroundColor Green
}

# Files and folders to copy
$itemsToCopy = @(
    "main.dart.js",
    "flutter.js",
    "flutter_bootstrap.js",
    "flutter_service_worker.js",
    "favicon.png",
    "manifest.json",
    "version.json",
    "assets",
    "canvaskit",
    "icons"
)

# Note: index.html and .htaccess are already in htdocs folder

Write-Host "بدء نسخ الملفات..." -ForegroundColor Yellow
Write-Host ""

$copiedCount = 0
$skippedCount = 0

foreach ($item in $itemsToCopy) {
    if (Test-Path $item) {
        $destination = Join-Path "htdocs" $item
        
        # Remove existing item if it exists
        if (Test-Path $destination) {
            Remove-Item -Path $destination -Recurse -Force
        }
        
        # Copy item
        Copy-Item -Path $item -Destination $destination -Recurse -Force
        Write-Host "✅ تم نسخ: $item" -ForegroundColor Green
        $copiedCount++
    } else {
        Write-Host "⚠️  غير موجود: $item" -ForegroundColor Yellow
        $skippedCount++
    }
}

Write-Host ""
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "النتيجة:" -ForegroundColor Cyan
Write-Host "  ✅ تم نسخ: $copiedCount عنصر" -ForegroundColor Green
if ($skippedCount -gt 0) {
    Write-Host "  ⚠️  تم تخطي: $skippedCount عنصر" -ForegroundColor Yellow
}
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""

# Check if index.html and .htaccess exist
if (Test-Path "htdocs/index.html") {
    Write-Host "✅ ملف index.html موجود" -ForegroundColor Green
} else {
    Write-Host "⚠️  ملف index.html غير موجود - تم إنشاؤه مسبقاً" -ForegroundColor Yellow
}

if (Test-Path "htdocs/.htaccess") {
    Write-Host "✅ ملف .htaccess موجود" -ForegroundColor Green
} else {
    Write-Host "⚠️  ملف .htaccess غير موجود - تم إنشاؤه مسبقاً" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "⚠️  تعليمات مهمة جداً:" -ForegroundColor Yellow
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "1. افتح لوحة تحكم InfinityFree" -ForegroundColor White
Write-Host "2. اذهب إلى 'Domains' أو 'Subdomains'" -ForegroundColor White
Write-Host "3. ابحث عن النطاق: al3adrar.great-site.net" -ForegroundColor White
Write-Host "4. انظر إلى 'Document Root' أو 'Directory'" -ForegroundColor White
Write-Host "5. هذا هو المجلد الذي يجب رفع الملفات إليه!" -ForegroundColor White
Write-Host ""
Write-Host "6. اذهب إلى File Manager" -ForegroundColor White
Write-Host "7. افتح المجلد المحدد في الخطوة 4" -ForegroundColor White
Write-Host "8. ارفع جميع محتويات مجلد htdocs إلى هذا المجلد" -ForegroundColor White
Write-Host ""
Write-Host "⚠️  تأكد من رفع index.html في المجلد الصحيح!" -ForegroundColor Yellow
Write-Host "===========================================" -ForegroundColor Cyan

