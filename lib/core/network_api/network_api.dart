import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:oulun_energia_mobile/core/authentication/authentication.dart';

@protected
abstract class RestApiBase {
  final Authentication _authentication;
  final String baseUrl;
  final RestClient restClient;

  RestApiBase(this._authentication, this.baseUrl, [RestClient? restClient])
      : restClient = restClient ?? RestClient(_authentication);

  @protected
  Future<Map<String, String>> getAuthenticationHeaders(
      {String? username, String? passwd}) async {
    var token = await _authentication.getAuthenticationToken();
    var accessStr = username != null && passwd != null
        ? "$username:$passwd"
        : "$token:unused";
    var accessToken = utf8.fuse(base64).encode(accessStr);
    var map = {
      HttpHeaders.authorizationHeader: 'Basic $accessToken',
      HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
    };
    return map;
  }
}

class RestClient {
  final HttpClient _client = HttpClient();

  final Authentication _authentication;

  RestClient(this._authentication);

  Future<dynamic> getContent(String uri, Map<String, String> headers) async {
    RestApiResponse response =
        await _authenticatedCall(() => _doGet(Uri.parse(uri), headers, false));

    if (response.response?.statusCode == HttpStatus.ok) {
      var content = await response.bodyContent();
      return content;
    }

    return null;
  }

  Future<RestApiResponse> get(Uri uri,
      {required Map<String, String> headers, followRedirects = true}) async {
    return await _authenticatedCall(
        () => _doGet(uri, headers, followRedirects));
  }

  Future<RestApiResponse> delete(Uri uri,
      {required Map<String, String> headers}) async {
    return await _authenticatedCall(() => _doDelete(uri, headers));
  }

  Future<RestApiResponse> post(Uri uri,
      {required Map<String, String> headers, String? body}) async {
    return await _authenticatedCall(() => _doPost(uri, headers, body));
  }

  Future<RestApiResponse> put(Uri uri, String body,
      {required Map<String, String> headers}) async {
    return await _authenticatedCall(() => _doPut(uri, headers, body));
  }

  Future<RestApiResponse> _doGet(
      Uri uri, Map<String, String> headers, followRedirects) async {
    RestApiRequest request = await _client.getUrl(uri).toRestRequest();
    for (String key in headers.keys) {
      request.request?.headers.add(key, headers[key]!);
    }
    request.request?.followRedirects = followRedirects;
    return request.close();
  }

  Future<RestApiResponse> _doPost(
      Uri uri, Map<String, String> headers, String? body) async {
    RestApiRequest request = await _client.postUrl(uri).toRestRequest();
    for (String key in headers.keys) {
      request.request?.headers.add(key, headers[key]!);
    }
    if (body != null) {
      request.request?.write(body);
    }
    return request.close();
  }

  Future<RestApiResponse> _doDelete(
      Uri uri, Map<String, String> headers) async {
    RestApiRequest request = await _client.deleteUrl(uri).toRestRequest();
    for (String key in headers.keys) {
      request.request?.headers.add(key, headers[key]!);
    }
    return request.close();
  }

  Future<RestApiResponse> _doPut(
      Uri uri, Map<String, String> headers, String body) async {
    RestApiRequest request = await _client.putUrl(uri).toRestRequest();
    for (String key in headers.keys) {
      request.request?.headers.add(key, headers[key]!);
    }
    request.request?.write(body);
    return request.close();
  }

  Future<RestApiResponse> _authenticatedCall(
      Future<RestApiResponse> Function() apiCall) async {
    RestApiResponse response = await apiCall();
    if (response.response?.statusCode == HttpStatus.unauthorized) {
      return Future.error(AuthenticationError.unauthorized);
    }
    return response;
  }

  String createStateParam() {
    var random = Random.secure();
    var values = List<int>.generate(12, (i) => random.nextInt(255));
    return "state=${Uri.encodeComponent(base64UrlEncode(values))}";
  }
}

class RestApiResponse {
  final HttpClientResponse? response;
  final bool error;

  RestApiResponse(this.response, this.error);

  Future<String> bodyContent() {
    return response!.transform(utf8.decoder).join();
  }
}

class RestApiRequest {
  final HttpClientRequest? request;
  final bool error;

  RestApiRequest(this.request, this.error);

  Future<RestApiResponse> close() {
    if (error) {
      return Future.value(RestApiResponse(null, true));
    }
    return request!.close().toRestResponse();
  }
}

extension RestRequest on Future<HttpClientRequest> {
  Future<RestApiRequest> toRestRequest() {
    return then((value) => RestApiRequest(value, false))
        .catchError((_) => RestApiRequest(null, true));
  }
}

extension RestResponse on Future<HttpClientResponse> {
  Future<RestApiResponse> toRestResponse() {
    return then((value) => RestApiResponse(value, false))
        .catchError((_) => RestApiResponse(null, true));
  }
}
