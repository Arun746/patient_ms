import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_ms/config/config.dart';
import 'package:patient_ms/model/doctor.model.dart';

class DoctorService {
  static String baseUrl = Config.baseUrl;

  static Future<List<DoctorDt>> getData() async {
    String apiURL = "$baseUrl/api/referer";

    try {
      final uri = Uri.parse(apiURL);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List<DoctorDt> doctors = (json.decode(response.body) as List)
            .map((data) => DoctorDt.fromJson(data))
            .toList();
        return doctors;
      } else {
        throw Exception('Failed to load specialities');
      }
    } catch (error) {
      throw Exception('Error fetching specialities: $error');
    }
  }
}
