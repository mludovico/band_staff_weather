import 'package:clima/services/weather.dart';
import 'package:test/test.dart';

void main() {
  group('api', () {
    test('API Call', () async {
      WeatherService service = WeatherService();
      Map cityInfo = await service.getInfoByCityName('campinas');
      print(cityInfo);
      expect(1, 1);
    });
  });
}