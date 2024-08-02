import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService('2e191fb357792167b37d64fee5428116');
  Weather? _weather;
  // fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();
    print(cityName);
    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        //
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  // weather animations
  String getWeatherAnimation(String? mainCondition) {
    //
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      //
      case 'cloudy':
        return 'assets/cloudy.json';
      case 'rainy':
        return 'assets/rainy.json';
      case 'sunny':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  // init state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(
              _weather?.cityName ?? 'Loading city ...',
            ),
            // animation
            Lottie.asset(
              getWeatherAnimation(_weather?.mainCondition),
            ),
            // temperature
            Text(
              '${_weather?.temperature.round().toString()} C',
            ),
            // weather condition
            Text(_weather?.mainCondition ?? "No condition"),
          ],
        ),
      ),
    );
  }
}
