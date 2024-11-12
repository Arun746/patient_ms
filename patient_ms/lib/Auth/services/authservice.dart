// ignore_for_file: constant_identifier_names, unused_catch_clause

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:patient_ms/Auth/model/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String Url = 'http://192.168.15.126/medipro.api.Medipro';

//REGISTRATION

  //signup
  static Future<int> signUp(SignUpModel user) async {
    String apiURL = "$Url/api/userregister";
    final uri = Uri.parse(apiURL);
    String jsonBody = json.encode(user.toMap());

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await http.post(
      uri,
      headers: headers,
      body: jsonBody,
    );
    return response.statusCode;
  }

  //userstatus
  static Future<bool> getUserStatus(String phone) async {
    if (phone.length < 10) {
      return true;
    }
    String apiURL = "$Url/api/userexists/$phone";
    final uri = Uri.parse(apiURL);

    final headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.get(uri, headers: headers);
    bool users = (json.decode(response.body));
    return users;
  }

//LOGIN
  Future<Map<String, dynamic>> login(String username, String password) async {
    final encodedUsername = Uri.encodeComponent(username);
    final encodedPassword = Uri.encodeComponent(password);
    var url = Uri.parse('$Url/token');

    var bodyData = {
      'username': encodedUsername,
      'password': encodedPassword,
      'grant_type': 'password'
    };

    try {
      final response = await http.post(
        url,
        body: bodyData,
      );

      if (response.statusCode == 200) {
        // Decode the JSON response body
        return json.decode(response.body);
      } else {
        throw response.statusCode == 400
            ? 'Invalid user credentials'
            : 'Failed to authenticate';
      }
    } on SocketException catch (e) {
      throw 'Network connection lost. Please check your internet connection.';
    } on Exception catch (e) {
      rethrow;
    }
  }

  static Future<String?> parseToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    if (token != null) {
      Map<String, dynamic> payload = Jwt.parseJwt(token);

      String userId = payload['sub'];
      await prefs.setString('userid', userId.toString());

      return userId;
    }
    return null;
  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      return false;
    }

    bool isExpired = Jwt.isExpired(token);
    return !isExpired;
  }

  static Future<String?> getUserId() async {
    return await parseToken();
  }

  static Future<void> logout(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('userid');
    } catch (e) {}
  }
}
