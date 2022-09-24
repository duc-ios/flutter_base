abstract class APIPath {
  final String method;
  final String path;

  const APIPath(this.method, this.path);
}

class APIMethod {
  static const get = 'GET';
  static const post = 'POST';
  static const put = 'PUT';
  static const patch = 'PATCH';
  static const delete = 'DELETE';
}
