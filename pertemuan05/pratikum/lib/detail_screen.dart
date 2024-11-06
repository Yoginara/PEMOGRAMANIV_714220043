import 'package:flutter/material.dart';
import 'model/tourism_place.dart';

var iniFontCustom = const TextStyle(fontFamily: 'Staatliches');

class DetailScreen extends StatelessWidget {
  final TourismPlace place;

  const DetailScreen({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Image.asset(place.imageAsset),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: Text(
                place.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Staatliches',
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const Icon(
                      Icons.calendar_today,
                      color: Color.fromARGB(255, 34, 107, 0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      place.openDays,
                      style: const TextStyle(fontFamily: 'Staatliches'),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Color.fromARGB(255, 34, 107, 0),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      place.openTime,
                      style: const TextStyle(fontFamily: 'Staatliches'),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Icon(
                      Icons.attach_money,
                      color: Color.fromARGB(255, 34, 107, 0),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      place.ticketPrice,
                      style: const TextStyle(fontFamily: 'Staatliches'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                place.description,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: place.imageUrls.map((url) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(url),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
