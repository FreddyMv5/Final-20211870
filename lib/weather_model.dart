class Temperature {
  double current;

  Temperature({required this.current});

  factory Temperature.fromJson(Map<String, dynamic> json) {
    return Temperature(
      current: (json['temp'] ?? 0.0).toDouble() - 273.15, // Conversión de Kelvin a Celsius
    );
  }
}

class Wind {
  double speed;

  Wind({required this.speed});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: (json['speed'] ?? 0.0).toDouble(), 
    );
  }
}

class WeatherData {
  String name;
  Temperature temperature;
  int humidity;
  Wind wind;
  double maxTemperature;
  double minTemperature;
  int pressure;
  int seaLevel;
  List<WeatherCondition> weather;

  WeatherData({
    required this.name,
    required this.temperature,
    required this.humidity,
    required this.wind,
    required this.maxTemperature,
    required this.minTemperature,
    required this.pressure,
    required this.seaLevel,
    required this.weather,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      name: json['name'] ?? '',
      temperature: Temperature.fromJson(json['main']),
      humidity: json['main']['humidity'] ?? 0,
      wind: Wind.fromJson(json['wind']),
      maxTemperature: (json['main']['temp_max'] ?? 0.0).toDouble(),
      minTemperature: (json['main']['temp_min'] ?? 0.0).toDouble(),
      pressure: json['main']['pressure'] ?? 0,
      seaLevel: json['main']['sea_level'] ?? 0,
      weather: (json['weather'] as List)
          .map((item) => WeatherCondition.fromJson(item))
          .toList(),
    );
  }
}

class WeatherCondition {
  String main;
  String description;
  String icon;

  WeatherCondition({
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    return WeatherCondition(
      main: json['main'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? '',
    );
  }
}
