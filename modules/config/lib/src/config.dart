class Config {
  static const String baseUrl = String.fromEnvironment('BASE_URL');
  static const bool isProd = String.fromEnvironment('ENV') == 'PROD';
}
