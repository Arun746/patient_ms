import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_ms/AppointmentNew/model/department.model.dart';
import 'package:patient_ms/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DepartmentService {
  static String baseUrl = Config.baseUrl;

  static Future<List<DepartmentDt>> getData() async {
    String apiURL = "$baseUrl/api/AppointmentDepart?hospital_code=101";

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
        List<DepartmentDt> appointmentdates =
            (json.decode(response.body)['depart'] as List)
                .map((data) => DepartmentDt.fromJson(data))
                .toList();
        return appointmentdates;
      } else {
        // Throw an exception with the error message
        throw Exception('Failed to load departments : ${response.statusCode}');
      }
    } catch (error) {
      // Throw an exception with the error details
      throw Exception('Error fetching departments: $error');
    }
  }
}
