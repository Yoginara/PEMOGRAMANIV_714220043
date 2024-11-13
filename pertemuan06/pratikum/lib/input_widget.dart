import 'package:flutter/material.dart';

class MyInput extends StatefulWidget {
  const MyInput({Key? key}) : super(key: key);

  @override
  State<MyInput> createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  final TextEditingController _controller = TextEditingController();
  bool lightOn = false;

  // The nullable string variable for holding selected language
  String? language;

  // Boolean variable for the checkbox
  bool agree = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Function to show a SnackBar with the selected language
  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Widget'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Write your name here...',
                  labelText: 'Your Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text('Hello, ${_controller.text}'),
                        );
                      },
                    );
                  }
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text('Light'),
                value: lightOn,
                onChanged: (bool value) {
                  setState(() {
                    lightOn = value;
                  });
                  showSnackbar(lightOn ? 'Light On' : 'Light Off');
                },
              ),
              const SizedBox(height: 20),
              // Column containing Radio options
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Radio<String>(
                      value: 'Dart',
                      groupValue: language,
                      onChanged: (String? value) {
                        setState(() {
                          language = value;
                          showSnackbar('Selected Language: $language');
                        });
                      },
                    ),
                    title: const Text('Dart'),
                  ),
                  ListTile(
                    leading: Radio<String>(
                      value: 'Kotlin',
                      groupValue: language,
                      onChanged: (String? value) {
                        setState(() {
                          language = value;
                          showSnackbar('Selected Language: $language');
                        });
                      },
                    ),
                    title: const Text('Kotlin'),
                  ),
                  ListTile(
                    leading: Radio<String>(
                      value: 'Swift',
                      groupValue: language,
                      onChanged: (String? value) {
                        setState(() {
                          language = value;
                          showSnackbar('Selected Language: $language');
                        });
                      },
                    ),
                    title: const Text('Swift'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Checkbox widget
              ListTile(
                leading: Checkbox(
                  value: agree,
                  onChanged: (bool? value) {
                    setState(() {
                      agree = value!;
                    });
                    showSnackbar(agree ? 'You Agree' : 'You Disagree');
                  },
                ),
                title: const Text('Agree / Disagree'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
