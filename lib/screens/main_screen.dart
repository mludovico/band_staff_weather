import 'package:clima/screens/forecast_screen.dart';
import 'package:clima/screens/widgets/tab_content.dart';
import 'package:clima/screens/widgets/tab_header.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {

  final List<String> cities;
  MainScreen({this.cities});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  bool _loadingState = false;
  List<String> _cities;
  List<Map<String, dynamic>> data;
  PageController _pageController;
  TextEditingController _textEditingController;
  int _currentPage;
  String _lastUpdate;
  WeatherService _service;

  @override
  void initState(){
    super.initState();
    if(widget.cities == null)
      _cities = ['Silverstone,UK', 'Sao Paulo,BR', 'Melbourne,AU', 'Monte Carlo,MC'];
    else
      _cities = widget.cities;
    _currentPage = 0;
    _pageController = PageController(
      initialPage: _currentPage,
    );
    _textEditingController = TextEditingController();
    _service = WeatherService();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      _loadingState = true;
    });
    final prefs = await SharedPreferences.getInstance();
    _lastUpdate = prefs.getString(kPrefLastUpdateKey);
    final updatedData = <Map<String, dynamic>>[];
    try {
      for(String cityName in _cities){
        updatedData.add(await _service.getInfoByCityName(cityName));
      }
      setState((){
        data = updatedData;
        _loadingState = false;
        _lastUpdate = DateTime.now().toString().split('.')[0];
      });
      prefs.setString(kPrefLastUpdateKey, _lastUpdate);
      data.forEach((element) {print(element);});
    } on Exception catch (error, stackTrace) {
      setState(() {
        _loadingState = false;
        print(error);
        print(stackTrace);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load weather data'),
            duration: Duration(seconds: 2),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'City name',
                  labelText: 'Search',
                  suffix: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () async {
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ForecastScreen(_textEditingController.text)),
                      );
                      _textEditingController.clear();
                    },
                  )
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _cities.map<Widget>((city){
                          int index = _cities.indexOf(city);
                          return TabHeader(
                            label: city.split(',')[0],
                            index: index,
                            current: _currentPage,
                            onTap: () => _pageController.animateToPage(
                              index,
                              duration: Duration(milliseconds: 700),
                              curve: Curves.ease,
                            )
                          );
                        }).toList(),
                      ),
                      Expanded(
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (page) => setState((){
                            _currentPage = page;
                          }),
                          scrollDirection: Axis.vertical,
                          children: data == null
                              ?
                          []
                              :
                          data.map<Widget>((Map<String, dynamic> cityData) => TabContent(
                            cityData: cityData,
                          )
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: _loadingState,
                    child: Container(
                      color: Color(0x90000000),
                      child: Center(
                        child: SpinKitCircle(
                          size: 100,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ),
                ]
              ),
            ),
            Container(
              height: 56,
              padding: EdgeInsets.only(bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Last update: ${_lastUpdate??''}',
                    textAlign: TextAlign.center,
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: loadData,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
