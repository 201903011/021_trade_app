/// HTTP method enumeration for type-safe API requests
enum HttpMethod {
  get('GET'),
  post('POST'),
  put('PUT'),
  delete('DELETE'),
  patch('PATCH'),
  head('HEAD'),
  options('OPTIONS');

  const HttpMethod(this.value);

  /// The string value of the HTTP method
  final String value;

  @override
  String toString() => value;
}
