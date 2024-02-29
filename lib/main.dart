// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(const WeatherApp());
// }

// class WeatherApp extends StatefulWidget {
//   const WeatherApp({Key? key}) : super(key: key);

//   @override
//   State<WeatherApp> createState() => _WeatherAppState();
// }

// class _WeatherAppState extends State<WeatherApp> {
//   int temperature = 0;
//   int woeid = 2487956;
//   String location = 'San Francisco';
//   String searchApiUrl = 'https://www.metaweather.com/api/location/search/?query=';
//   String locationApiUrl = 'https://www.metaweather.com/api/location/';

//   Future<void> fetchSearch(String input) async {
//     var searchResult = await http.get(Uri.parse(searchApiUrl + input));
//     var result = json.decode(searchResult.body)[0];

//     setState(() {
//       location = result['title'];
//       woeid = result['woeid'];
//     });
//     fetchLocation();
//   }

//   Future<void> fetchLocation() async {
//     var locationResult = await http.get(Uri.parse(locationApiUrl + woeid.toString()));
//     var result = json.decode(locationResult.body);
//     var consolidatedWeather = result['consolidated_weather'];
//     var data = consolidatedWeather[0];

//     setState(() {
//       temperature = data['the_temp'].round();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'WeatherApp',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: SafeArea(
//           child: Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('images/sun.jpg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Column(
//                   children: [
//                     Text(
//                       '$temperature°C',
//                       style: const TextStyle(color: Colors.white, fontSize: 60.0),
//                     ),
//                     Text(
//                       location,
//                       style: const TextStyle(color: Colors.white, fontSize: 40.0),
//                     ),
//                     Container(
//                       width: 300,
//                       child: TextField(
//                         onSubmitted: (String input) {
//                           fetchSearch(input);
//                         },
//                         style: const TextStyle(color: Colors.white, fontSize: 25),
//                         decoration: const InputDecoration(
//                           hintText: 'Search Another Location',
//                           hintStyle: TextStyle(color: Colors.white, fontSize: 18.0),
//                           prefixIcon: Icon(Icons.search, color: Colors.white),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:weather_app/pages/home.dart';
import 'package:weather_app/pages/loading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Loading(),
        'home': (context) => const HomePage(),
        '/loading': (context) => const Loading(),
      },
    );
  }
}
