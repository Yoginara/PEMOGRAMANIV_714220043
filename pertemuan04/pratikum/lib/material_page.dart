import 'package:flutter/material.dart';
import 'package:pratikum/material_app.dart';

// StatelessWidget for HomePage
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      drawer: Drawer(
        child: ListView(
          children: const [
            ListTile(title: Text('Home Page')),
            ListTile(title: Text('About Page')),
          ],
        ),
      ),
      body: MyRow(),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ]),
    );
  }
}

// StatelessWidget for custom Heading
class Heading extends StatelessWidget {
  final String text;

  const Heading({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// StatefulWidget to manage dynamic text size
class BiggerText extends StatefulWidget {
  final String teks;

  const BiggerText({Key? key, required this.teks}) : super(key: key);

  @override
  State<BiggerText> createState() => _BiggerTextState();
}

class _BiggerTextState extends State<BiggerText> {
  double _textSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          widget.teks,
          style: TextStyle(fontSize: _textSize),
        ),
        ElevatedButton(
          child: Text(_textSize == 16.0 ? "Perbesar" : "Perkecil"),
          onPressed: () {
            setState(() {
              _textSize = _textSize == 16.0 ? 32.0 : 16.0;
            });
          },
        )
      ],
    );
  }
}

// class MyContainer extends StatelessWidget {
//   const MyContainer({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         Icon(Icons.share),
//         Icon(Icons.thumb_up),
//         Icon(Icons.thumb_down),
//       ],
//     );

//     // Column(
//     //   crossAxisAlignment: CrossAxisAlignment.start,
//     //   children: <Widget>[
//     //     Text(
//     //       'Ini Judul',
//     //       style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//     //     ),
//     //     Text('Universitas Logistik dan Bisnis Internasional (ULBI)'),
//     //   ],
//     // );

//     // Column(
//     //   children: <Widget>[

//     //     // Text('Teks 1'),
//     //     // SizedBox(height: 20),
//     //     // Text('Teks 2'),
//     //   ],
//     // );

//     // Center(
//     //   child: const Text('Text Berada di Tengah'),
//     // );

//     // Padding(
//     //   padding: const EdgeInsets.all(30),
//     //   child: const Text('Ini Padding'),
//     // );

//     // Container(
//     //   decoration: BoxDecoration(
//     //     color: Colors.red,
//     //     border: Border.all(color: Colors.green, width: 3),
//     //     borderRadius: BorderRadius.circular(15),
//     //     //   boxShadow: const [
//     //     //   BoxShadow(
//     //     //     color: Colors.black,
//     //     //     offset: Offset(3, 6),
//     //     //     blurRadius: 10,
//     //     //   )
//     //     // ]
//     //     // shape: BoxShape.circle,
//     //   ),
//     //   // margin: const EdgeInsets.all(10),
//     //   // padding: const EdgeInsets.all(10),
//     //   // width: 200,
//     //   // height: 100,
//     //   child: const Text(
//     //     'Hi',
//     //     style: TextStyle(fontSize: 40),
//     //   ),
//     // );
//   }
// }

class MyRow extends StatelessWidget {
  const MyRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('MainAxisAlignment.spaceEvenly'),
        // Row with MainAxisAlignment.spaceEvenly
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(Icons.share),
            Icon(Icons.thumb_up),
            Icon(Icons.thumb_down),
          ],
        ),
        SizedBox(height: 20), // Space between rows

        Text('MainAxisAlignment.spaceAround'),
        // Row with MainAxisAlignment.spaceAround
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(Icons.share),
            Icon(Icons.thumb_up),
            Icon(Icons.thumb_down),
          ],
        ),
        SizedBox(height: 20),

        Text('MainAxisAlignment.spaceBetween'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(Icons.share),
            Icon(Icons.thumb_up),
            Icon(Icons.thumb_down),
          ],
        ),
        SizedBox(height: 20),

        Text('MainAxisAlignment.start'),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.share),
            Icon(Icons.thumb_up),
            Icon(Icons.thumb_down),
          ],
        ),
        SizedBox(height: 20),

        Text('MainAxisAlignment.center'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.share),
            Icon(Icons.thumb_up),
            Icon(Icons.thumb_down),
          ],
        ),
        SizedBox(height: 20),

        Text('MainAxisAlignment.end'),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(Icons.share),
            Icon(Icons.thumb_up),
            Icon(Icons.thumb_down),
          ],
        ),
      ],
    );
  }
}
