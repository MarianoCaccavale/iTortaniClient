import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
}

class NetworkCallUtils {
  static Future isInternetConnected() async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        }
      } else {
        return false;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }

  static Future getCall({url}) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception(
          "Response status code: " + response.statusCode.toString());
    }
  }

  static Future postCall({url, payload}) async {
    final response = await http.post(Uri.parse(url),
        headers: {"Content-type": "application/json"}, body: payload);
    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception(
          "Response status code: " + response.statusCode.toString());
    }
  }

  static Future putCall({url, payload}) async {
    final response = await http.put(url,
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: payload);
    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception(
          "Response status code: " + response.statusCode.toString());
    }
  }

  static Future patchCall({url, payload}) async {
    final response = await http.patch(url,
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: payload);
    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception(
          "Response status code: " + response.statusCode.toString());
    }
  }

  static Future deleteCall({url}) async {
    final response = await http.delete(
      url,
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception(
          "Response status code: " + response.statusCode.toString());
    }
  }
}
