import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// URL de l'API NestJS (local ou Render).
class ApiConfig {
  static const String productionBaseUrl = 'https://k-boost.onrender.com';

  static String get baseUrl {
    const fromEnv = String.fromEnvironment('API_BASE_URL');
    if (fromEnv.isNotEmpty) return fromEnv;

    const useProd = bool.fromEnvironment('USE_PROD_API');
    if (useProd) return productionBaseUrl;

    return _localBaseUrl();
  }

  static String _localBaseUrl() {
    if (kIsWeb) {
      return productionBaseUrl;
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:3000';
    }
    return 'http://127.0.0.1:3000';
  }
}
