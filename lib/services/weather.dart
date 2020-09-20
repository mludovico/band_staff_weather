import 'dart:convert';

import 'package:clima/services/icons.dart';
import 'package:flutter/cupertino.dart';

import 'secrets.dart';
import 'package:http/http.dart' as Http;

class Weather{

  String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  String _key = apiKey;
  double latitude;
  double longitude;
  int temperature = 0;
  String conditionIcon;
  String message;
  String cityName;

  void getInfoByLatLong({@required latitude, @required longitude}) async {
    Http.Response response = await Http.get('$_baseUrl?lat=$latitude&lon=$longitude&units=metric&appid=$_key');
    _parseData(response);
  }

  void getInfoByCityName(String cityName) async {
    Http.Response response = await Http.get('$_baseUrl?q=$cityName&units=metric&appid=$_key');
    _parseData(response);
  }

  void _parseData(Http.Response response){
    final icons = WeatherModel();
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      final temp = data['main']['temp'];
      this.temperature = temp.toInt();
      final condition = data['weather'][0]['id'];
      this.conditionIcon = icons.getWeatherIcon(condition);
      this.message = icons.getMessage(temperature);
      this.cityName = data['name'];
      this.latitude = data['coord']['lat'];
      this.longitude = data['coord']['lon'];
    }else{
      print('Erro: ${response.statusCode} ${response.body}');
      this.temperature = 0;
      this.conditionIcon = 'Erro';
      this.message = 'Não foi possível obter dados';
      this.cityName = '';
      this.latitude = 0;
      this.longitude = 0;
    }

  }
}