import 'dart:convert';

class JwtUtils {
  static String? getStoreId(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        return null;
      }

      final payload = parts[1];
      final normalized = base64.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final payloadMap = json.decode(decoded);

      if (payloadMap is! Map<String, dynamic>) return null;

      return payloadMap['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'];
    } catch (e) {
      print('Error decoding token: $e');
      return null;
    }
  }
}
