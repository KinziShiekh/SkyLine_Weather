// ignore_for_file: unused_local_variable, avoid_print, unnecessary_string_interpolations

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_icons/weather_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Extract the arguments passed from the previous screen
    Map? info = ModalRoute.of(context)?.settings.arguments as Map?;

    // Check if info is not null before accessing its properties
    String temp = info?['temp_value']?.toString() ?? 'N/A';
    String icon = info?['icon_value']?.toString() ?? 'n/a';
    String des = info?['main_value'] ?? 'N/A';
    String city = info?['city_value'] ?? '';
    String airSpeed = info?['air_speed_value']?.toString().substring(
            0, min(info['air_speed_value']?.toString().length ?? 0, 4)) ??
        'N/A';
    String humi = info?['humi_value']
            ?.toString()
            .substring(0, min(info['humi_value']?.toString().length ?? 0, 4)) ??
        'N/A';

    // Random city name for demonstration
    var cityNames = [
      'Faisalabad',
      'Lahore',
      'London',
      'Multan',
      'Murree',
      'China',
      'Islamabad'
    ];
    String backgroundImage = 'images/s (2).jpg'; // Default background image

    // Map city names to corresponding background images
    final Map<String, String> cityBackgroundImages = {
      'Faisalabad': 'images/s (1).jpg',
      'Lahore': 'images/l (2).jpg',
      'London': 'images/l (3).jpg',
      'Multan': 'images/l (4).jpg',
      'Murree': 'images/l (5).jpg',
      'China': 'images/sun.jpg',
      'Islamabad': 'images/sun.jpg'
    };

    final random = Random();
    var randomCity = cityNames[random.nextInt(cityNames.length)];
    TextEditingController searchController = TextEditingController();
    if (cityBackgroundImages.containsKey(city)) {
      backgroundImage = cityBackgroundImages[city]!;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if ((searchController.text).replaceAll('', '') ==
                              '') {
                            print('Blank Search');
                          } else {
                            Navigator.pushNamed(context, '/loading',
                                arguments: {
                                  'searchText': searchController.text
                                });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.withOpacity(0.5),
                          ),
                          child: const Icon(Icons.search, color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search $city',
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.adamina(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(26),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white30,
                        ),
                        child: Row(
                          children: [
                            if (icon !=
                                'n/a') // Only display image if icon is available
                              Image.network(
                                'https://openweathermap.org/img/wn/$icon@2x.png',
                              ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  des,
                                  style:
                                      GoogleFonts.adamina(color: Colors.black),
                                ),
                                Text(
                                  city.isNotEmpty ? 'In $city' : 'N/A',
                                  style:
                                      GoogleFonts.adamina(color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        padding: const EdgeInsets.all(26),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              WeatherIcons.thermometer,
                              size: 40,
                              color: Colors.redAccent,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$temp',
                                  style: GoogleFonts.adamina(
                                      color: Colors.black, fontSize: 50),
                                ),
                                Text(
                                  '°C',
                                  style: GoogleFonts.adamina(
                                      color: Colors.black, fontSize: 30),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  WeatherIcons.wind,
                                  size: 40,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Text(
                              '$airSpeed',
                              style: GoogleFonts.adamina(
                                  color: Colors.black, fontSize: 30),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Wind Speed',
                              style: GoogleFonts.adamina(
                                  color: Colors.black, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 200,
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: const Row(
                                children: [
                                  Icon(
                                    WeatherIcons.wind_beaufort_7,
                                    size: 40,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$humi ',
                                  style: GoogleFonts.adamina(
                                      color: Colors.black, fontSize: 30),
                                ),
                                Text(
                                  'Humidity',
                                  style: GoogleFonts.adamina(
                                      color: Colors.black, fontSize: 10),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Column(
                  children: [
                    Text(
                      'Made By Kinza Zahid',
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      'Data Fetch Open Weather',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
