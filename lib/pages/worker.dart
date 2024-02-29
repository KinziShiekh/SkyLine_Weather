// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class Worker {
  String location;

  // Constructor with named parameter 'location'
  Worker({required this.location});

  String? tempCelsius; // Variable to store temperature in Celsius
  double? humidityPercentage; // Variable to store humidity percentage
  double? airSpeedKmh; // Variable to store air speed in km/h
  String? description;
  String? main;
  String? icon;

  Future<void> getData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=0423a3499afba7d94824d92585e11059'));
      Map<String, dynamic> data = jsonDecode(response.body);

      // Get Temperature in Celsius
      double? tempKelvin = data['main']['temp']?.toDouble();
      if (tempKelvin != null) {
        double tempCelsiusValue =
            tempKelvin - 273.15; // Convert temperature from Kelvin to Celsius
        tempCelsius =
            tempCelsiusValue.toStringAsFixed(2); // Store temperature in Celsius
      }

      // Get Humidity
      double? getHumidity = data['main']['humidity']?.toDouble();
      if (getHumidity != null) {
        humidityPercentage = getHumidity;
      }

      // Get air speed in meters per second (m/s)
      double? getAirspeed = data['wind']['speed']?.toDouble();
      if (getAirspeed != null) {
        airSpeedKmh = getAirspeed / 0.27777777777778;
      }

      // Get Description
      List<dynamic> weatherData = data['weather'];
      if (weatherData.isNotEmpty) {
        Map<String, dynamic> weatherMainData = weatherData[0];
        description = weatherMainData['description'];
        main = weatherMainData['main'];
        icon = weatherMainData['icon'];
        print(icon);
      }
    } catch (e) {
      print('Error fetching data: $e');
      tempCelsius = 'N/A';
      humidityPercentage = 0.0;
      main = 'Data not found';
      airSpeedKmh = 0.0;
    }
  }
}
