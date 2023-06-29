import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bored.dart';

class BoredApiRepository {
  final _baseUrl = "http://www.boredapi.com/api/activity/";

  Future<Bored> fetchActivity() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return Bored.fromJson(jsonBody);
    } else {
      throw Exception('Failed to fetch bored api');
    }
  }
}
