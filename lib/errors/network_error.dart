class NetworkError extends Error {
  NetworkError();
  String toString() => "Network connection lost error";
}