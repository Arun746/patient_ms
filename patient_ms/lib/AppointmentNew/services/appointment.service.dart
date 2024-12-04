import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_ms/config/config.dart';

import '../model/appointment.model.dart';

abstract class NewAppointmentService {
  static String url = Config.localUrl;

  static Future<List<AppPostModel>> postAppointment(
    String appointmentdate,
    String appointmenttime,
    int dpid,
    String remarks,
    bool new_,
    bool insurance,
    bool ssf,
    int patientid,
    int schemeid,
    int schemeproductid,
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
      "remarks": remarks,
      "scheme_id": schemeid,
      "scheme_product_id": schemeproductid,
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
      List<AppPostModel> data = (json.decode(postResponse.body) as List)
          .map((data) => AppPostModel.fromJson(data))
          .toList();
      return data;
    } else {
      // print('Error Response Body: ${postResponse.body}');
      throw Exception('Failed to post ${postResponse.statusCode}');
    }
  }
}
