import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key}); // Menggunakan super parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tugas Pertemuan 4'), titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20)),
      body: const Mycenter(),
    );
  }
}

class Heading extends StatelessWidget {
  final String text;

  const Heading({super.key, required this.text}); // Menggunakan super parameter

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

class BiggerText extends StatefulWidget {
  final String teks;

  const BiggerText(
      {super.key, required this.teks}); // Menggunakan super parameter

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
        ),
      ],
    );
  }
}

//my container 
class Mycenter extends StatelessWidget {
  const Mycenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Box 1 di tengah
          Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            width: 300,
            height: 100,
            padding: const EdgeInsets.all(20.0),
            child: const Text(
              'box 1',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          const SizedBox(height: 20), 
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
                width: 95,
                height: 200,
                padding: const EdgeInsets.all(20.0),
                child: const Text(
                  'box 2',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(width: 20), // Spasi antara Box 2 dan Box 3
              Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
                width: 95,
                height: 200,
                padding: const EdgeInsets.all(20.0),
                child: const Text(
                  'box 3',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}