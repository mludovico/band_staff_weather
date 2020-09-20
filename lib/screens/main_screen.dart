import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MainScreen extends StatefulWidget {

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final location = Location();

  @override
  void initState(){
    super.initState();
    getLocation();
  }

  void getLocation() async {
    await location.getCurrentLocation();
    print(location);
    getWeather();
  }

  void getWeather() async {
    final weather = Weather();
    print(weather);
    await weather.getInfoByLatLong(
      latitude: location.latitude,
      longitude: location.longitude,
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_)=>LocationScreen(weather: weather),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SpinKitCircle(
          size: 100,
          color: Colors.teal,
        ),
      ),
    );
  }

}
