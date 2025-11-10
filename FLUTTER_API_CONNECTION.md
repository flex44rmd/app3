# 📱 كود الاتصال/الدخول من Flutter

## 🔌 معلومات الاتصال

### Base URL للـ API:
```dart
static const String baseUrl = 'http://localhost:3000/api';
```

أو إذا كان الخادم على الإنترنت:
```dart
static const String baseUrl = 'https://your-server-url.com/api';
```

## 📝 مثال كود كامل للاتصال

### 1. ملف خدمة API (api_service.dart)

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  // ⚠️ غيّر هذا إلى عنوان الخادم الصحيح
  static const String baseUrl = 'http://localhost:3000/api';
  
  // Headers للطلبات
  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // ==================== CODE ENDPOINTS ====================
  
  /// الحصول على بيانات الكود
  static Future<Map<String, dynamic>?> getCode(String code) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/codes/$code'),
        headers: headers,
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        return null; // الكود غير موجود
      } else {
        throw Exception('Failed to load code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting code: $e');
      return null;
    }
  }

  // ==================== USER ENDPOINTS ====================
  
  /// الحصول على مستخدم بالكود
  static Future<Map<String, dynamic>?> getUserByCode(String code) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/code/$code'),
        headers: headers,
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception('Failed to load user: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }
  
  /// الحصول على مستخدم بالكود والاسم
  static Future<Map<String, dynamic>?> getUserByCodeAndName(
    String code, 
    String name
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/code/$code/name/$name'),
        headers: headers,
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception('Failed to load user: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }
  
  /// حفظ/تحديث مستخدم
  static Future<bool> saveUser(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users'),
        headers: headers,
        body: json.encode(userData),
      );
      
      return response.statusCode == 200;
    } catch (e) {
      print('Error saving user: $e');
      return false;
    }
  }
  
  /// الحصول على جميع المستخدمين
  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users'),
        headers: headers,
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting users: $e');
      return [];
    }
  }
  
  /// الحصول على مستخدمين حسب المملكة
  static Future<List<Map<String, dynamic>>> getUsersByKingdom(
    String kingdom
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/kingdom/$kingdom'),
        headers: headers,
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting users by kingdom: $e');
      return [];
    }
  }
  
  /// تحديث نقاط المستخدم
  static Future<bool> updateUserPoints(String userId, int points) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/users/$userId/points'),
        headers: headers,
        body: json.encode({'points': points}),
      );
      
      return response.statusCode == 200;
    } catch (e) {
      print('Error updating user points: $e');
      return false;
    }
  }

  // ==================== KINGDOM ENDPOINTS ====================
  
  /// الحصول على جميع الممالك
  static Future<List<Map<String, dynamic>>> getAllKingdoms() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/kingdoms'),
        headers: headers,
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load kingdoms: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting kingdoms: $e');
      return [];
    }
  }
  
  /// الحصول على مملكة بالاسم
  static Future<Map<String, dynamic>?> getKingdomByName(String name) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/kingdoms/name/$name'),
        headers: headers,
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception('Failed to load kingdom: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting kingdom: $e');
      return null;
    }
  }
  
  /// تحديث نقاط المملكة
  static Future<bool> updateKingdomPoints(String name, int points) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/kingdoms/$name/points'),
        headers: headers,
        body: json.encode({'points': points}),
      );
      
      return response.statusCode == 200;
    } catch (e) {
      print('Error updating kingdom points: $e');
      return false;
    }
  }

  // ==================== CHAT ENDPOINTS ====================
  
  /// إرسال رسالة
  static Future<bool> sendMessage(Map<String, dynamic> messageData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/chat/messages'),
        headers: headers,
        body: json.encode(messageData),
      );
      
      return response.statusCode == 200;
    } catch (e) {
      print('Error sending message: $e');
      return false;
    }
  }
  
  /// الحصول على رسائل المملكة
  static Future<List<Map<String, dynamic>>> getMessagesByKingdom(
    String kingdom
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/chat/messages/kingdom/$kingdom'),
        headers: headers,
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load messages: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting messages: $e');
      return [];
    }
  }
  
  // ==================== HEALTH CHECK ====================
  
  /// فحص حالة الخادم
  static Future<bool> checkHealth() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/health'),
        headers: headers,
      );
      
      return response.statusCode == 200;
    } catch (e) {
      print('Error checking health: $e');
      return false;
    }
  }
}
```

### 2. مثال الاستخدام

```dart
import 'api_service.dart';

// التحقق من حالة الخادم
bool isServerRunning = await ApiService.checkHealth();

// الحصول على بيانات الكود
Map<String, dynamic>? codeData = await ApiService.getCode('ATL001');
if (codeData != null) {
  print('Kingdom: ${codeData['kingdom']}');
  print('Role: ${codeData['role']}');
}

// حفظ مستخدم جديد
bool saved = await ApiService.saveUser({
  'id': 'user123',
  'code': 'ATL001',
  'name': 'Ahmed',
  'kingdom': 'Atlantis',
  'role': 'leader',
  'points': 0,
});

// الحصول على جميع الممالك
List<Map<String, dynamic>> kingdoms = await ApiService.getAllKingdoms();
```

## 📦 إضافة المكتبة المطلوبة

في ملف `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
```

ثم شغّل:
```bash
flutter pub get
```

## ⚠️ ملاحظات مهمة

1. **تغيير Base URL:** غيّر `baseUrl` إلى عنوان الخادم الصحيح
2. **CORS:** تأكد من تفعيل CORS في الخادم (تم تفعيله بالفعل)
3. **معالجة الأخطاء:** الكود يتعامل مع الأخطاء ويعيد `null` أو `false` عند الفشل
4. **Async/Await:** جميع الدوال async وتستخدم await

## 🔗 الملفات ذات الصلة

- كود الخادم: `server/server.js`
- اتصال قاعدة البيانات: `server/db.js`
- معلومات الاتصال: `DATABASE_CONNECTION_INFO.md`

