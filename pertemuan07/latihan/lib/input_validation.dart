import 'package:flutter/material.dart';

class MyFormValidation extends StatefulWidget {
  const MyFormValidation({super.key});

  @override
  State<MyFormValidation> createState() => _MyFormValidationState();
}

class _MyFormValidationState extends State<MyFormValidation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerNama = TextEditingController();

  String? _validateEmail(String? value) {
    const String expression =
        "[a-zA-Z0-9+._%-+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+";
    final RegExp regExp = RegExp(expression);

    if (value!.isEmpty) return 'Email wajib diisi';
    if (!regExp.hasMatch(value)) return "Tolong inputkan email yang valid!";
    return null;
  }

  String? _validateNama(String? value) {
    if (value!.length < 3) return 'Masukkan setidaknya 3 karakter';
    return null;
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerNama.dispose();
    super.dispose();
  }

  void _showDialog(String email, String nama) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Data yang Dimasukkan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Email: $email'),
              Text('Nama: $nama'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Validation')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _controllerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Write your email here...',
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 222, 254, 255),
                ),
                validator: _validateEmail,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _controllerNama,
                decoration: const InputDecoration(
                  hintText: 'Write your name here...',
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 222, 254, 255),
                ),
                validator: _validateNama,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text("Submit"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final email = _controllerEmail.text;
                    final nama = _controllerNama.text;
                    _showDialog(email, nama);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please complete the form')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
