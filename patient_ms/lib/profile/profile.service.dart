// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_ms/config/config.dart';
import 'package:patient_ms/profile/profile.model.dart';

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
}
