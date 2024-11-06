import 'package:flutter/material.dart';
import 'package:latihan/first_screen.dart';
// import 'package:latihan/scrolling_screen_list_separated.dart';
// import 'package:latihan/scrolling_screen_list_builder.dart';
// import 'package:latihan/scrolling_list_view.dart';
// import 'package:latihan/list_view_screen.dart';
// import 'package:latihan/font_screen.dart';
// import 'package:latihan/image_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Oswald',
      ),
      home: const FirstScreen(),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: 'Oswald',
//       ),
//       home: const ScrollingScreenListSeparated(),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: 'Oswald',
//       ),
//       home: const ScrollingScreenListBuilder(),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: 'Oswald',
//       ),
//       home: const ScrollingScreenList(),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: 'Oswald',
//       ),
//       home: const ScrollingScreen(),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: 'Oswald',
//       ),
//       home: const MyCustomFont(),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: false,
//       ),
//       home: const MyImage(),
//     );
//   }
// }



