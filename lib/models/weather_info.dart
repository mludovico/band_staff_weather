class WeatherInfo {
  Main main;
  Weather weather;
  String dateText;

  WeatherInfo({this.main, this.weather, this.dateText});

  factory WeatherInfo.fromMap(Map<String, dynamic> map) => WeatherInfo(
    main: Main.fromMap(map['main']) ?? Main.fromMap({}),
    weather: Weather.fromMap(map['weather'][0]) ?? Weather.fromMap({}),
    dateText: map['dt_txt'] ?? ''
  );

  Map<String, dynamic> toMap() => {
    'main': main.toMap(),
    'weather': weather.toMap(),
    'dt_txt': dateText ?? ''
  };

  @override
  String toString() {
    return this.toMap().toString();
  }
}

class Main {
  double temp;
  double feel;
  double min;
  double max;
  int humidity;

  Main({this.temp, this.feel, this.min, this.max, this.humidity});

  factory Main.fromMap(Map<String, dynamic> map) => Main(
    temp: (map['temp'] ?? 0.0).toDouble(),
    feel: (map['feels_like'] ?? 0.0).toDouble(),
    min: (map['temp_min'] ?? 0.0).toDouble(),
    max: (map['temp_max'] ?? 0.0).toDouble(),
    humidity: map['humidity'] ?? 0,
  );

  Map<String, dynamic> toMap() => {
    'temp': temp ?? 0,
    'feels_like': feel ?? 0,
    'temp_min': min ?? 0,
    'temp_max': max ?? 0,
    'humidity': humidity ?? 0,
  };
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromMap(Map<String, dynamic> map) => Weather(
    id: map['id'] ?? 0,
    main: map['main'] ?? '',
    description: map['description'] ?? '',
    icon: map['icon'] ?? ''
  );

  Map<String, dynamic> toMap() => {
    'id': id ?? 0,
    'main': main ?? '',
    'description': description ?? '',
    'icon': icon ?? ''
  };
}