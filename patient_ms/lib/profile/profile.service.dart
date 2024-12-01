// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_ms/config/config.dart';
import 'package:patient_ms/profile/profile.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  static String Url = Config.localUrl;

  static Future<List<PatientInfoDt>> getData(userId) async {
    String apiURL = "$Url/api/PatientInfoSelect?userid=$userId";

    try {
      final uri = Uri.parse(apiURL);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List<PatientInfoDt> profile = (json.decode(response.body) as List)
            .map((data) => PatientInfoDt.fromJson(data))
            .toList();
        return profile;
      } else {
        throw Exception('Failed to load profiles');
      }
    } catch (error) {
      throw Exception('Error fetching profiles: $error');
    }
  }

  static Future<Map<String, dynamic>> postProfile(
    String bima,
    String name,
    String address,
    String email,
    String phoneno,
    String dob,
    String gender,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userid') ?? '';

    final uri = Uri.parse('$Url/api/PatientInfoInsert');
    DateTime now = DateTime.now();
    String formattedNow = now.toIso8601String().split('T').first;

    final headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      "userid": userId,
      "ddate": formattedNow,
      "policyid": bima.isEmpty ? null : bima,
      "pname": name,
      "address": address,
      "email": email,
      "telephone": phoneno,
      "dob": dob,
      "gender": gender,
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    var postResponse = await http.post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    print('Status Code: ${postResponse.statusCode}');
    print('Reason Phrase: ${postResponse.reasonPhrase}');
    print('Response Headers: ${postResponse.headers}');
    print('Response Body: ${postResponse.body}');

    if (postResponse.statusCode == 200) {
      return {'success': true, 'message': 'Profile updated successfully'};
    } else {
      print('Error Response Body: ${postResponse.body}');
      // Parse the error message from JSON response
      try {
        Map<String, dynamic> errorResponse = json.decode(postResponse.body);
        return {
          'success': false,
          'message': errorResponse['error_message'] ?? 'Unknown error occurred'
        };
      } catch (e) {
        return {'success': false, 'message': 'Failed to process error message'};
      }
    }
  }
}
