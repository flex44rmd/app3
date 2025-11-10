# دليل رفع الموقع على InfinityFree

## المشكلة الحالية
المجلد المطلوب `al3adrar.great-site.net/htdocs` غير موجود على الخادم.

## الحل: خطوات رفع الملفات

### الخطوة 1: إنشاء المجلد في لوحة التحكم

1. سجل الدخول إلى لوحة تحكم InfinityFree
2. اذهب إلى قسم **"File Manager"** أو **"FTP Accounts"**
3. أنشئ مجلد باسم `htdocs` في المجلد الرئيسي
   - أو استخدم اسم المجلد المطلوب حسب إعدادات النطاق

### الخطوة 2: رفع ملفات Flutter Web

#### الملفات المطلوب رفعها:

```
htdocs/
├── index.html (سيتم إنشاؤه)
├── main.dart.js
├── flutter.js
├── flutter_bootstrap.js
├── flutter_service_worker.js
├── favicon.png
├── manifest.json
├── version.json
├── assets/
│   ├── AssetManifest.json
│   ├── AssetManifest.bin.json
│   ├── FontManifest.json
│   ├── fonts/
│   └── packages/
├── canvaskit/
├── icons/
└── .htaccess (سيتم إنشاؤه)
```

### الخطوة 3: إنشاء ملف index.html

أنشئ ملف `index.html` في مجلد `htdocs`:

```html
<!DOCTYPE html>
<html>
<head>
  <base href="$FLUTTER_BASE_HREF">
  <meta charset="UTF-8">
  <meta content="IE=Edge" http-equiv="X-UA-Compatible">
  <meta name="description" content="Church Kingdoms App">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="Church Kingdoms">
  <link rel="apple-touch-icon" href="icons/Icon-192.png">
  <link rel="icon" type="image/png" href="favicon.png"/>
  <link rel="manifest" href="manifest.json">
  <script>
    var serviceWorkerVersion = null;
    var scriptLoaded = false;
    function loadMainDartJs() {
      if (scriptLoaded) {
        return;
      }
      scriptLoaded = true;
      var scriptTag = document.createElement('script');
      scriptTag.src = 'main.dart.js';
      scriptTag.type = 'application/javascript';
      document.body.append(scriptTag);
    }

    if ('serviceWorker' in navigator) {
      window.addEventListener('load', function () {
        fetch('flutter_service_worker.js?v=' + serviceWorkerVersion)
          .then((response) => {
            return response.text();
          })
          .then((text) => {
            eval(text);
          });
      });
    } else {
      loadMainDartJs();
    }
  </script>
</head>
<body>
  <script>
    window.addEventListener('load', function(ev) {
      _flutter.loader.loadEntrypoint({
        serviceWorker: {
          serviceWorkerVersion: serviceWorkerVersion,
        },
        onEntrypointLoaded: function(engineInitializer) {
          engineInitializer.initializeEngine().then(function(appRunner) {
            appRunner.runApp();
          });
        }
      });
    });
  </script>
  <script src="flutter.js" async></script>
</body>
</html>
```

### الخطوة 4: إنشاء ملف .htaccess

أنشئ ملف `.htaccess` في مجلد `htdocs` لإعدادات Apache:

```apache
# Enable Rewrite Engine
RewriteEngine On

# Handle Flutter Web Routes
RewriteBase /
RewriteRule ^index\.html$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.html [L]

# Enable CORS (if needed for API calls)
<IfModule mod_headers.c>
    Header set Access-Control-Allow-Origin "*"
    Header set Access-Control-Allow-Methods "GET, POST, PUT, DELETE, OPTIONS"
    Header set Access-Control-Allow-Headers "Content-Type, Authorization"
</IfModule>

# Cache Control
<IfModule mod_expires.c>
    ExpiresActive On
    ExpiresByType text/css "access plus 1 year"
    ExpiresByType application/javascript "access plus 1 year"
    ExpiresByType image/png "access plus 1 year"
    ExpiresByType image/jpg "access plus 1 year"
    ExpiresByType image/jpeg "access plus 1 year"
    ExpiresByType image/gif "access plus 1 year"
    ExpiresByType image/svg+xml "access plus 1 year"
</IfModule>

# Gzip Compression
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css text/javascript application/javascript application/json
</IfModule>
```

### الخطوة 5: رفع الملفات

#### الطريقة الأولى: استخدام File Manager في InfinityFree

1. سجل الدخول إلى لوحة تحكم InfinityFree
2. اذهب إلى **"File Manager"**
3. افتح مجلد `htdocs` (أو أنشئه إذا لم يكن موجوداً)
4. ارفع جميع الملفات والمجلدات المطلوبة

#### الطريقة الثانية: استخدام FTP

1. احصل على معلومات FTP من لوحة تحكم InfinityFree:
   - FTP Host: `ftpupload.net` أو `files.000webhost.com`
   - FTP Username: (من لوحة التحكم)
   - FTP Password: (من لوحة التحكم)
   - FTP Port: 21

2. استخدم عميل FTP مثل FileZilla:
   - Host: `ftpupload.net`
   - Username: (من لوحة التحكم)
   - Password: (من لوحة التحكم)
   - Port: 21

3. ارفع جميع الملفات إلى مجلد `htdocs`

### الخطوة 6: إعداد قاعدة البيانات

1. سجل الدخول إلى لوحة تحكم InfinityFree
2. اذهب إلى **"Databases"** → **"phpMyAdmin"**
3. اختر قاعدة البيانات الخاصة بك
4. افتح تبويب **"SQL"**
5. انسخ محتوى ملف `sql/schema.sql` والصقه
6. اضغط **"Go"** لتنفيذ الاستعلامات

### الخطوة 7: إعداد API Backend

⚠️ **مهم:** InfinityFree لا يدعم Node.js مباشرة. لديك خياران:

#### الخيار 1: استخدام PHP كبديل (موصى به لـ InfinityFree)

سيتم إنشاء ملفات PHP لاستبدال Node.js server.

#### الخيار 2: استخدام خدمة خارجية لـ Node.js

- استخدم خدمة مثل **Render**, **Railway**, أو **Heroku** لتشغيل Node.js server
- غيّر عنوان API في تطبيق Flutter إلى عنوان الخادم الخارجي

## ملاحظات مهمة

1. **اسم المجلد:** تأكد من أن اسم المجلد يطابق الإعدادات في لوحة تحكم InfinityFree
2. **الصلاحيات:** تأكد من أن ملفات `.htaccess` و `index.html` لديهم صلاحيات القراءة
3. **قاعدة البيانات:** تأكد من أن قاعدة البيانات نشطة في لوحة التحكم
4. **API:** إذا كنت تستخدم Node.js، ستحتاج إلى خدمة خارجية لأن InfinityFree لا يدعم Node.js

## التحقق من النجاح

بعد رفع الملفات:
1. افتح المتصفح واذهب إلى: `https://al3adrar.great-site.net`
2. يجب أن يظهر تطبيق Flutter Web
3. تحقق من أن جميع الملفات تم تحميلها بشكل صحيح

## استكشاف الأخطاء

### خطأ: "Directory is missing"
- تأكد من إنشاء مجلد `htdocs` في المكان الصحيح
- تحقق من إعدادات النطاق في لوحة التحكم

### خطأ: "404 Not Found"
- تأكد من وجود ملف `index.html` في المجلد الصحيح
- تحقق من ملف `.htaccess`

### خطأ: "Files not loading"
- تحقق من مسارات الملفات في `index.html`
- تأكد من رفع جميع المجلدات (assets, canvaskit, icons)

