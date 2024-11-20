import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_ms/config/config.dart';
import 'package:patient_ms/model/speciality.model.dart';

class SpecialityService {
  static String baseUrl = Config.baseUrl;

  static Future<List<SpecialityDt>> getData() async {
    String apiURL = "$baseUrl/api/RefererSetup/SpecialitySearch";

    try {
      final uri = Uri.parse(apiURL);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List<SpecialityDt> speciality = (json.decode(response.body) as List)
            .map((data) => SpecialityDt.fromJson(data))
            .toList();
        return speciality;
      } else {
        throw Exception('Failed to load specialities:');
      }
    } catch (error) {
      throw Exception('Error fetching specialities: $error');
    }
  }
}
