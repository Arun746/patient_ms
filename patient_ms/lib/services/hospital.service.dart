import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_ms/config/config.dart';
import 'package:patient_ms/model/hospital.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HospitalService {
  static String baseUrl = Config.baseUrl2;
  static Future<List<HospitalDt>> getData() async {
    String apiURL = "$baseUrl/api/hospitallist";

    try {
      final uri = Uri.parse(apiURL);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        List<HospitalDt> hospital =
            (json.decode(response.body)['hospitalist'] as List)
                .map((data) => HospitalDt.fromJson(data))
                .toList();
        return hospital;
      } else {
        throw Exception('Failed to load hospital ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching hospital: $e');
    }
  }
}
