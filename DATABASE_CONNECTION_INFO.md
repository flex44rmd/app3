# 🔌 معلومات الاتصال بقاعدة البيانات

## 📍 كود الاتصال بقاعدة البيانات

### 1. كود الاتصال في الخادم (Node.js)

**الملف:** `server/db.js`

```javascript
const mysql = require('mysql2/promise');
require('dotenv').config();

// Create MySQL connection pool
const pool = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  port: process.env.DB_PORT || 3306,
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'church_kingdoms',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  enableKeepAlive: true,
  keepAliveInitialDelay: 0
});
```

### 2. إعدادات قاعدة البيانات (InfinityFree)

**الملف:** `server/.env` (يجب إنشاؤه)

```env
DB_HOST=sql112.infinityfree.com
DB_PORT=3306
DB_USER=if0_40376337
DB_PASSWORD=eRdbAFO2dIuMLoz
DB_NAME=if0_40376337_test
PORT=3000
NODE_ENV=production
```

✅ **اسم قاعدة البيانات:** `if0_40376337_test`

### 3. معلومات الاتصال المباشر (✅ معلومات صحيحة 100%)

```
Hostname: sql112.infinityfree.com
Port: 3306
Username: if0_40376337
Password: eRdbAFO2dIuMLoz
Database Name: if0_40376337_test
```

## 🌐 API Endpoints (للاتصال من Flutter)

### Base URL:
```
http://localhost:3000/api
```

أو إذا كان الخادم على الإنترنت:
```
https://your-server-url.com/api
```

### Endpoints المتوفرة:

#### 1. Health Check
```
GET /api/health
```

#### 2. Codes (الأكواد)
```
GET /api/codes/:code
```
مثال: `GET /api/codes/ATL001`

#### 3. Users (المستخدمين)
```
GET /api/users
GET /api/users/code/:code
GET /api/users/code/:code/name/:name
GET /api/users/kingdom/:kingdom
POST /api/users
PATCH /api/users/:userId/points
```

#### 4. Kingdoms (الممالك)
```
GET /api/kingdoms
GET /api/kingdoms/name/:name
PATCH /api/kingdoms/:name/points
PUT /api/kingdoms/:name/points
```

#### 5. Chat (الدردشة)
```
POST /api/chat/messages
GET /api/chat/messages/kingdom/:kingdom
```

## 📱 مثال كود الاتصال من Flutter

إذا كان لديك كود Flutter، يجب أن يكون شيء مثل:

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://localhost:3000/api';
  
  // Get code data
  static Future<Map<String, dynamic>> getCode(String code) async {
    final response = await http.get(
      Uri.parse('$baseUrl/codes/$code'),
    );
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load code');
    }
  }
  
  // Get user by code
  static Future<Map<String, dynamic>> getUserByCode(String code) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/code/$code'),
    );
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user');
    }
  }
  
  // Save user
  static Future<void> saveUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userData),
    );
    
    if (response.statusCode != 200) {
      throw Exception('Failed to save user');
    }
  }
}
```

## 🔧 كيفية إنشاء ملف .env

شغّل هذا الأمر في PowerShell:

```powershell
cd server
.\create-env.ps1
```

أو أنشئ الملف يدوياً:

1. أنشئ ملف `.env` في مجلد `server/`
2. انسخ المحتوى من `server/INFINITYFREE_CONFIG.txt`
3. ✅ اسم قاعدة البيانات: `if0_40376337_test`

## ✅ التحقق من الاتصال

### 1. اختبار الاتصال بقاعدة البيانات:

```bash
cd server
npm install
npm start
```

يجب أن ترى:
```
✅ Connected to MySQL database successfully!
✅ Database schema initialized successfully!
🚀 Server is running on http://localhost:3000
```

### 2. اختبار API:

افتح المتصفح على:
```
http://localhost:3000/api/health
```

يجب أن ترى:
```json
{"status":"ok","message":"Server is running"}
```

## 📝 ملاحظات مهمة

1. **اسم قاعدة البيانات:** يجب أن يكون صحيحاً من لوحة تحكم InfinityFree
2. **الخادم:** InfinityFree لا يدعم Node.js مباشرة - ستحتاج إلى:
   - استخدام خدمة خارجية مثل Render/Railway/Heroku
   - أو استخدام PHP كبديل
3. **CORS:** تم تفعيل CORS في الخادم للسماح بالاتصال من Flutter Web

## 🔗 روابط مفيدة

- ملف الاتصال: `server/db.js`
- ملف الخادم: `server/server.js`
- إعدادات قاعدة البيانات: `server/.env`
- دليل الإعداد: `server/SETUP_INFINITYFREE.md`

