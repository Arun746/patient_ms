import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_ms/config/config.dart';

abstract class NewAppointmentService {
  static String url = Config.localUrl;
  static Future<bool> postAppointment(
    String appointmentdate,
    String appointmenttime,
    int dpid,
    String remarks,
    bool new_,
    bool insurance,
    bool ssf,
    int patientid,
  ) async {
    final uri = Uri.parse('$url/api/OnlineAppointmentInsert');

    DateTime now = DateTime.now();
    String formattedNow = now.toIso8601String().split('T').first;

    final headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      "ddate": formattedNow,
      "appointment_date": appointmentdate,
      "appointment_time": appointmenttime,
      "dp_id": dpid,
      "hospital_code": 101,
      "new_": new_,
      "insurance": insurance,
      "ssf": ssf,
      "patient_id": patientid,
      "remarks": remarks
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    var postResponse = await http.post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    // print('Status Code: ${postResponse.statusCode}');
    // print('Reason Phrase: ${postResponse.reasonPhrase}');
    // print('Response Headers: ${postResponse.headers}');
    // print('Response Body: ${postResponse.body}');

    int statusCode = postResponse.statusCode;
    if (statusCode == 200) {
      return true;
    } else {
      // print('Error Response Body: ${postResponse.body}');
      return false;
    }
  }
}
