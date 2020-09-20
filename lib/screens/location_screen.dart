import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {

  LocationScreen({this.weather});
  final weather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  Weather weather;

  @override
  void initState() {
    super.initState();
    weather = widget.weather;
    print(weather.cityName);
  }

  void updateUi() async {
    print('updating UI');
    var location = Location();
    await location.getCurrentLocation();
    print(location);
    weather = Weather();
    await weather.getInfoByLatLong(
      longitude: location.longitude,
      latitude: location.latitude,
    );
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8),
              BlendMode.dstATop,
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    onPressed: updateUi,
                    child: Icon(
                      Icons.near_me,
                      size: 50,
                    ),
                  ),
                  FlatButton(
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_){
                            return CityScreen();
                          }
                        ),
                      ).then((value) async {
                        if(value != null){
                          await weather.getInfoByCityName(value);
                          setState(() {

                          });
                        }
                      });
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text(
                      '${weather.temperature}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weather.conditionIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '${weather.message} em ${weather.cityName}',
                  style: kMessageTextStyle,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
