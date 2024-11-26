import 'package:http/http.dart' as http;
import 'package:patient_ms/config/config.dart';

class InsuranceService {
  static String Url = Config.baseUrl2;

  static Future<http.Response> getEligibility(
      String bimano, String userId) async {
    final url = Uri.parse('$Url/api/Eligibility');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'patientid': bimano,
          'userid': userId,
        },
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        print(
            'Error getting eligibility data: Status code ${response.statusCode}');
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching eligibility data: $e');
      rethrow;
    }
  }
}
