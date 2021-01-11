import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class ForecastScreen extends StatefulWidget {

  final String cityName;
  ForecastScreen(this.cityName);

  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {

  TextEditingController cityController;

  @override
  void initState() {
    cityController = TextEditingController(text: widget.cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
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
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: ()=>Navigator.of(context).pop(),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: cityController,
                  style: kTextFieldTextStyle,
                  decoration: kTextFieldInputDecoration,
                ),
              ),
              FlatButton(
                onPressed: (){
                  Navigator.of(context).pop(cityController.text);
                },
                child: Text(
                  'Buscar Previsão',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
