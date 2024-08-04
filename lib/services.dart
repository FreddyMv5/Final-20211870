import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:final_app/weather_model.dart';


class WeatherServices {
  Future<WeatherData> fetchWeather() async {
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=18.47186&lon=-69.89232&appid=eb29511bb8fd08b7b4574ae3d0cf57d1'), // Coloca aquí la URL de tu API
      headers: {
        'Authorization': 'AjJXgLtAfaoiecJKJ3bdGaLq0QNf7CyB',
      },
    );

    if (response.statusCode == 200) {
      return WeatherData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
