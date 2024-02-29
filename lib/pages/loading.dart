// ignore_for_file: avoid_print, unnecessary_null_comparison, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/pages/worker.dart'; // Import Worker class

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String city = 'Faisalabad';
  String? temp;
  String? main;
  String? airSpeed;
  String? humidity;
  String? icon;
  bool isLoading = true; // Add a loading state

  @override
  void initState() {
    super.initState();
    // Start fetching data when the widget is initialized
  }

  void startApp(String city) async {
    try {
      // Store the context in a local variable to avoid null context error
      BuildContext? context = this.context;
      if (context == null) return; // Check if context is null

      Worker instance = Worker(location: city);
      await instance.getData();

      setState(() {
        temp = instance.tempCelsius;
        airSpeed = instance.airSpeedKmh?.toString();
        humidity = instance.humidityPercentage?.toStringAsFixed(2);
        main = instance.main;
        icon = instance.icon;

        isLoading = false; // Update loading state after data is fetched
      });

      // Delay navigation for a better user experience
      await Future.delayed(const Duration(seconds: 4));

      // Check again if context is null
      if (context == null) return;

      Navigator.pushReplacementNamed(context, 'home', arguments: {
        'temp_value': temp,
        'humi_value': humidity,
        'air_speed_value': airSpeed,
        'main_value': main,
        'icon_value': icon,
        'city_value': city
      });
    } catch (error) {
      print('Error fetching data: $error');
      // Handle error gracefully, e.g., show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map? search = ModalRoute.of(context)!.settings.arguments as Map?;

    if (search?.isNotEmpty ?? false) {
      city = search?['searchText'];
    }
    startApp(city);
    return Scaffold(
      backgroundColor:
          Colors.transparent, // Set background color to transparent
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/k.jpg"), // Replace with your image path
            fit: BoxFit.cover, // Adjust the fit as needed
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/w.png',
                height: 240,
                width: 240,
              ),
              Text(
                'SkyLine',
                style: GoogleFonts.adamina(color: Colors.white, fontSize: 40),
              ),
              Text(
                'Weather',
                style: GoogleFonts.adamina(color: Colors.white, fontSize: 20),
              ),
              if (isLoading) // Display a loading indicator while fetching data
                const SpinKitWave(
                  color: Colors.white,
                  duration: Duration(minutes: 2),
                )
            ],
          ),
        ),
      ),
    );
  }
}
