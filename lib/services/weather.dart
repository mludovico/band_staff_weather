import 'dart:async';
import 'dart:convert';
import 'package:clima/models/weather_info.dart';
import 'package:clima/services/icons.dart';
import 'package:clima/services/secrets.dart';
import 'package:clima/utilities/constants.dart';
import 'package:http/http.dart' as Http;
import 'package:shared_preferences/shared_preferences.dart';

class WeatherService{

  String scheme = 'https';
  String host = 'api.openweathermap.org';
  List<String> path = ['data', '2.5'];
  String _key = apiKey;

  Future<Map<String, dynamic>> getInfoByCityName(String cityName) async {
    Uri baseUri = Uri(
      scheme: scheme,
      host: host,
      pathSegments: path,
      queryParameters: {
        'q': cityName,
        'units': 'metric',
        'appid': _key,
      }
    );
    print(baseUri.toString());
    Uri weatherUri = baseUri.replace(pathSegments: [...baseUri.pathSegments, 'weather']);
    Uri forecastUri = baseUri.replace(pathSegments: [...baseUri.pathSegments, 'forecast']);
    print(weatherUri.toString());
    print(forecastUri.toString());
    Http.Response currentResponse = await Http
      .get(weatherUri.toString())
      .timeout(
        Duration(seconds: 10),
        onTimeout: (){
          throw TimeoutException('The api did not respond timely');
        },
      );
    Http.Response forecastResponse = await Http
      .get(forecastUri.toString())
      .timeout(
        Duration(seconds: 10),
        onTimeout: (){
          throw TimeoutException('The api did not respond timely');
        }
      );

    WeatherInfo current = await _parseData(currentResponse);
    List<WeatherInfo> forecast = await _parseData(forecastResponse);
    if(current != null && forecast != null)
      forecast = forecast.where((element) => element.dateText.contains('12:')).toList();
    Map<String, dynamic> values = {
      'current': current,
      'forecast': forecast,
    };
    print(values);
    return values;
  }

  dynamic _parseData(Http.Response response) async {
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      if(data.keys.contains('weather') && data.keys.contains('main')) {
        await prefs.setString(kPrefLastWeatherKey, response.body);
        print(data);
        WeatherInfo info = WeatherInfo.fromMap(data);
        return info;
      }
      else {
        await prefs.setString(kPrefLastForecastKey, response.body);
        List<WeatherInfo> info = [];
        for(var item in data['list']){
          info.add(WeatherInfo.fromMap(item));
        }
        return info;
      }
    } else {
      print('Erro: ${response.statusCode} ${response.body}');
      return null;
    }
  }
}