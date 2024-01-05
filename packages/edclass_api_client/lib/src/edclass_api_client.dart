import 'dart:convert';
import 'dart:io';

import 'package:edclass_api_client/edclass_api_client.dart';
import 'package:edclass_api_client/src/model/error.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

/// Thrown if an exception occurs while making an `http` request.
class HttpException implements Exception {
  ///
  const HttpException(this.message);

  /// error message
  final String message;

  @override
  String toString() => message;
}

/// Thrown if an `http` request returns a non-200 status code.
class HttpRequestFailure implements Exception {
  /// {@macro http_request_failure}
  const HttpRequestFailure(this.statusCode, {this.body});

  /// The status code of the response.
  final int statusCode;

  /// Body message
  final String? body;

  @override
  String toString() {
    try {
      final err = json.decode(body!) as Map<String, dynamic>;
      final errJson = Err.fromJson(err);
      return 'Request Failure [${errJson.error.code}] ${errJson.error.message}';
    } catch (_) {
      return 'Request Failure [$statusCode]';
    }
  }
}

/// Thrown when an error occurs while decoding the response body.
class JsonDecodeException implements Exception {}

/// Thrown when an error occurs while deserializing the response body.
class JsonDeserializationException implements Exception {}

/// http api client
class EdclassApiClient {
  /// constructor
  EdclassApiClient({
    String? tokenClaim,
    http.Client? httpClient,
  })  : _httpClient = httpClient ?? http.Client(),
        tokenClaim = tokenClaim ?? '';

  /// The host URL used for all API requests.
  ///
  /// Only exposed for testing purposes. Do not use directly.
  @visibleForTesting
  static const baseUrl = 'http://localhost:8080';

  final http.Client _httpClient;

  /// jwt token claim
  String tokenClaim;

  /// Login with password and nrp
  /// `POST /auth`
  Future<AuthResponse> auth(String username, String password) async {
    final response = await _httpClient.get(
      getUri(Endpoints.auth),
      headers: {
        HttpHeaders.authorizationHeader: 'Basic ${base64.encode(
          utf8.encode("$username:$password"),
        )}',
      },
    );

    if (response.statusCode != 200) {
      throw HttpRequestFailure(response.statusCode, body: response.body);
    }

    final jwt = AuthResponse.fromJson(_decode(response));
    tokenClaim = jwt.token;

    return jwt;

    /*try {
      final jwt = AuthResponse.fromJson(response.body as Map<String, String>);
      print(jwt);
      inspect(jwt);
      tokenClaim = jwt.token;
      return jwt;
    } catch (e) {
      throw JsonDecodeException();
    }*/
  }

  /// parse header
  Map<String, String> _parseHeader(bool isPost, Map<String, String>? headers) {
    final h = headers ?? {HttpHeaders.acceptHeader: 'application/json'};

    if (isPost) {
      h[HttpHeaders.contentTypeHeader] = 'application/json; charset=utf-8';
    }

    if (tokenClaim.isNotEmpty) {
      h[HttpHeaders.authorizationHeader] = 'Bearer $tokenClaim';
    }

    return h;
  }

  ///
  Uri getUri(String endpoint) {
    return Uri.parse('$baseUrl/$endpoint');
  }

  Future<Map<String, dynamic>> _postPut(
    String endpoint, {
    bool isPut = false,
    Object? body,
    Map<String, String>? headers,
  }) async {
    http.Response response;
    final uri = getUri(endpoint);
    final client = isPut ? _httpClient.put : _httpClient.post;

    try {
      response = await client(
        uri,
        body: jsonEncode(body),
        headers: _parseHeader(true, headers),
      );
    } on SocketException catch (_) {
      throw const HttpException('connection error');
    } catch (e) {
      rethrow;
    }

    if (response.statusCode != 200) {
      throw HttpRequestFailure(response.statusCode, body: response.body);
    }

    return _decode(response);
  }

  Future<Map<String, dynamic>> _post(
    String endpoint, {
    Object? body,
    Map<String, String>? headers,
  }) async {
    return _postPut(
      endpoint,
      body: body,
      headers: headers,
    );
  }

  Future<Map<String, dynamic>> _put(
    String endpoint, {
    Object? body,
    Map<String, String>? headers,
  }) async {
    return _postPut(
      endpoint,
      isPut: true,
      body: body,
      headers: headers,
    );
  }

  /// -------------------------------------------------------------------
  /// -------------------------------------------------------------------
  /// helper methods
  /// -------------------------------------------------------------------
  /// -------------------------------------------------------------------
  ///
  /// return BoolResponse
  BoolResponse _boolDe(Map<String, dynamic> body) {
    try {
      return BoolResponse.fromJson(body);
    } catch (_) {
      throw JsonDeserializationException();
    }
  }

  /// decode json
  Map<String, dynamic> _decode(http.Response res) {
    try {
      return json.decode(res.body) as Map<String, dynamic>;
    } catch (_) {
      throw JsonDecodeException();
    }
  }

  Future<BoolResponse> _delete(
    String endpoint,
    dynamic id, {
    Map<String, String>? headers,
  }) async {
    http.Response response;
    final uri = Uri.parse('$baseUrl/$endpoint/$id');

    try {
      response =
          await _httpClient.delete(uri, headers: _parseHeader(false, headers));
    } on SocketException catch (_) {
      throw const HttpException('connection error');
    } catch (e) {
      rethrow;
    }

    if (response.statusCode != 200) {
      throw HttpRequestFailure(response.statusCode);
    }

    return _boolDe(_decode(response));
  }
}
