import 'package:clima/models/weather_info.dart';
import 'package:clima/screens/forecast_screen.dart';
import 'package:clima/services/icons.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

class TabContent extends StatelessWidget {

  final Map<String, dynamic> cityData;

  TabContent({this.cityData});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${cityData['current'].main.temp}°',
            style: kTempTextStyle,
          ),
          Text(
            cityData['current'].weather.main,
            style: kConditionTextStyle,
          ),
          Text(
            WeatherUtil().getWeatherIcon(cityData['current'].weather.id),
            style: kTempTextStyle,
          ),
          Text(
            cityData['current'].weather.description,
            style: kConditionTextStyle,
          ),
          FlatButton(
            textColor: Colors.pinkAccent,
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ForecastScreen(cityData['forecast'])
                ),
              );
            },
            child: Text(
              'MORE',
              style: kButtonTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
