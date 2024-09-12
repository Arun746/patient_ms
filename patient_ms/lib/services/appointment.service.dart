import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class AppointmentService {
  static String baseUrl =
      'https://medipro.com.np/Mediprowebapi/api/OnlineAppointmentNew';

  static Future<bool> postAppointment(
    String date,
    String time,
  ) async {
    final uri = Uri.parse(baseUrl);

    final headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      "hospital_code": 101,
      "appointment_date": date,
      "appointment_time": time,
      "pname": "test",
      "address": "medipro",
      "mobile": 9876543210,
      "age": 25,
      "sex": "male",
      "refid": 107,
      "dp_id": 106,
      "remarks ": "test",
      "email": "testmail@gmail.com",
      "rate": 500.0,
      "trace_id": "1",
      "old": true,
      "hospid": 0
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    var postResponse = await http.post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = postResponse.statusCode;
    if (statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
