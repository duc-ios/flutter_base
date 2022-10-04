abstract class ApiPath {
  final String method;
  final String path;

  const ApiPath(this.method, this.path);
}

class ApiMethod {
  static const get = 'GET';
  static const post = 'POST';
  static const put = 'PUT';
  static const patch = 'PATCH';
  static const delete = 'DELETE';
}
