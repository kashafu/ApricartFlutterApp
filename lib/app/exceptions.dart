class NetworkException implements Exception {
  String message;
  NetworkException(this.message);
}

class InternetConnectivityException implements Exception {
  String message;
  InternetConnectivityException([this.message = "Network Issue"]);
}
