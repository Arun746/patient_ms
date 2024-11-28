import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:patient_ms/AppointmentNew/model/schemeproduct.model.dart';
import 'package:patient_ms/config/config.dart';

import '../model/scheme.model.dart';

class InsuranceService {
  static String Url = Config.baseUrl2;

  static Future<Map<String, dynamic>> getEligibility(
      String bimano, String userId) async {
    // Validate input parameters
    if (bimano.isEmpty || userId.isEmpty) {
      throw Exception('Bima number and User ID cannot be empty');
    }

    final url =
        Uri.parse('$Url/api/Eligibility?patientid=$bimano&userid=$userId');

    try {
      print('Checking eligibility - Bima: $bimano, UserId: $userId');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 500) {
        // Try to parse error message from response if available
        try {
          final errorBody = json.decode(response.body);
          throw Exception(
              'Server error: ${errorBody['message'] ?? 'Unknown server error'}');
        } catch (_) {
          throw Exception('Server error occurred. Please try again later.');
        }
      } else {
        throw Exception(
            'Request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching eligibility data: $e');
      rethrow; // Use rethrow instead of throwing a new exception to preserve stack trace
    }
  }

  Future<List<SchemeDt>> fetchInsuranceSchemes(bool insurance) async {
    try {
      final response = await http.get(
        Uri.parse('$Url/api/SsfInsuranceSchemeSelect?hib=$insurance'),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((data) => SchemeDt.fromJson(data)).toList();
      } else {
        throw Exception(
            'Failed to load insurance schemes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching insurance schemes: $e');
    }
  }

  Future<List<SchemeProductDt>> fetchInsuranceSchemeProduct(int schid) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$Url/api/SsfInsuranceSchemeProductSelect?hib=true&ipd=false&scheme_id=$schid'),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((data) => SchemeProductDt.fromJson(data)).toList();
      } else {
        throw Exception(
            'Failed to load insurance schemes Product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching insurance schemes Product: $e');
    }
  }
}
