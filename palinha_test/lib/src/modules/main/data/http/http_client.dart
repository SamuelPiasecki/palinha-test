import 'package:http/http.dart' as http;

abstract class IHttpClient {
  get({required String url});
  post({required String url, required String body});
  delete({required String url});
}

class HttpClient implements IHttpClient {
  final client = http.Client();

  @override
  Future get({required String url}) async {
    return await client.get(Uri.parse(url));
  }

  @override
  Future post({required String url, required String body}) async {
    return await client.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'}, body: body);
  }

  @override
  Future delete({required String url}) async {
    return await client.delete(Uri.parse(url));
  }
}
