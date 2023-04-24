import 'dart:io';

import 'app_environment.dart';

class AppNetwork {
  static setup() async {
    _setupHttpCertificate();
  }

  static void _setupHttpCertificate() {
    HttpOverrides.global = _MyHttpOverrides();
  }
}

/// This class overrides the default implementation of HttpOverrides to allow insecure HTTPS connections to a specific host.
/// When making HTTPS requests, Flutter verifies the server's SSL/TLS certificate to ensure a secure connection.
/// However, sometimes we may need to connect to a server with an invalid or self-signed certificate,
/// which will cause Flutter to throw a 'certificate verify failed' error.
///
/// In this case, we can use this class to override the default implementation of HttpOverrides and allow insecure connections to a specific host.
/// The `badCertificateCallback` method is called whenever an HTTPS request is made,
/// and it checks whether the certificate of the server matches the specified host.
/// If it does, the method returns true and allows the connection to proceed, even if the certificate is invalid.
/// To use this class, simply pass an instance of it to the `runApp` method in your main function, before creating any HTTP requests.
/// @Link https://stackoverflow.com/questions/54285172/how-to-solve-flutter-certificate-verify-failed-error-while-performing-a-post-req
///
class _MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return AppEnvironment.apiUrl.contains(host);
      };
  }
}
