import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefScreen extends StatefulWidget {
  const SharedPrefScreen({super.key});

  @override
  State<SharedPrefScreen> createState() => _SharedPrefScreenState();
}

class _SharedPrefScreenState extends State<SharedPrefScreen> {
  final TextEditingController _saveController = TextEditingController();
  final TextEditingController _getController = TextEditingController();

  void _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_data', _saveController.text);
    _saveController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data Saved!')),
    );
  }

  void _getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _getController.text = prefs.getString('saved_data') ?? 'No Data Found';
    });
  }

  void _deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('saved_data');
    setState(() {
      _getController.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data Deleted!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal, // Warna hijau AppBar
        title: const Text('Shared Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _saveController,
              decoration: const InputDecoration(
                labelText: 'Enter text to save',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Warna hijau tombol
                foregroundColor: Colors.white,
              ),
              child: const Text('Save'),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _getController,
              decoration: const InputDecoration(
                labelText: 'Saved data will appear here',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _getData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Warna hijau tombol
                foregroundColor: Colors.white,
              ),
              child: const Text('Get Value'),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: _deleteData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Warna hijau tombol
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete Value'),
            ),
          ],
        ),
      ),
    );
  }
}
