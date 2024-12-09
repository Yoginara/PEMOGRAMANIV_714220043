import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';

class MyFormList extends StatefulWidget {
  const MyFormList({super.key});

  @override
  State<MyFormList> createState() => _MyFormListState();
}

class _MyFormListState extends State<MyFormList> {
  // Inisialisasi variabel
  DateTime? _dueDate; // Tanggal
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerTanggal = TextEditingController();
  Color _currentColor = Colors.orange;
  String? _dataFile;
  File? _imageFile;

  final List<Map<String, dynamic>> _myDataList = [];
  Map<String, dynamic>? editedData;

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor telepon wajib diisi';
    }

    // Memastikan hanya berisi angka
    final RegExp numericRegExp = RegExp(r'^\d+$');
    if (!numericRegExp.hasMatch(value)) {
      return 'Nomor telepon hanya boleh berisi angka';
    }

    // Memastikan panjang nomor telepon
    if (value.length < 8 || value.length > 13) {
      return 'Nomor telepon harus terdiri dari 8 hingga 13 digit';
    }

    // Memastikan nomor telepon dimulai dengan "62"
    if (!value.startsWith('62')) {
      return 'Nomor telepon harus dimulai dengan angka 62';
    }

    return null; // Validasi berhasil
  }

  String? _validateNama(String? value) {
    if (value == null || value.isEmpty) return 'Nama wajib diisi';

    // Memastikan nama terdiri dari minimal 2 kata
    final words = value.trim().split(RegExp(r'\s+'));
    if (words.length < 2) return 'Nama harus terdiri dari minimal 2 kata';

    // Memastikan setiap kata dimulai dengan huruf kapital
    for (final word in words) {
      if (word.isEmpty || word[0] != word[0].toUpperCase()) {
        return 'Setiap kata pada nama harus dimulai dengan huruf kapital';
      }
    }

    return null; // Validasi berhasil
  }

  String? _validateTanggal(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tanggal wajib diisi';
    }
    return null; // Validasi berhasil
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    // Mendapatkan path file
    final file = result.files.first;

    if (file.extension == 'jpg' ||
        file.extension == 'png' ||
        file.extension == 'jpeg') {
      setState(() {
        _imageFile = File(file.path!); // Mengambil file gambar
      });
    }

    // Simpan data file ke variabel dan tampilkan di UI
    setState(() {
      _dataFile = file.name;
    });
  }

  void _openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }

  void _addData() {
    // Validasi form
    if (!_formKey.currentState!.validate()) {
      return; // Jika form tidak valid, jangan lanjutkan
    }

    // Validasi gambar
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap pilih gambar sebelum submit!'),
          backgroundColor: Colors.red,
        ),
      );
      return; // Jangan lanjutkan jika gambar belum dipilih
    }

    final data = {
      'name': _controllerNama.text,
      'phone': _controllerPhone.text,
      'date': _controllerTanggal.text,
      'color': _currentColor, // Tambahkan warna yang dipilih
      'image': _imageFile, // Menambahkan gambar yang dipilih
    };

    setState(() {
      if (editedData != null) {
        // Mode edit
        editedData!['name'] = data['name'];
        editedData!['phone'] = data['phone'];
        editedData!['date'] = data['date'];
        editedData!['color'] = data['color']; // Update warna
        editedData!['image'] = data['image']; // Update gambar
        editedData = null;
      } else {
        // Mode tambah
        _myDataList.add(data);
      }
      _controllerNama.clear();
      _controllerPhone.clear();
      _controllerTanggal.clear();
      _dueDate = null; // Reset tanggal setelah submit
      _currentColor = Colors.orange; // Reset warna ke default
      _imageFile = null; // Reset gambar
    });
  }

  void _editData(Map<String, dynamic> data) {
    setState(() {
      _controllerPhone.text = data['phone'];
      _controllerNama.text = data['name'];
      _controllerTanggal.text = data['date'];
      _dueDate = DateFormat('dd MMMM yyyy').parse(data['date']);
      _currentColor = data['color']; // Mengatur warna yang sudah dipilih
      _imageFile = data['image']; // Mengatur gambar yang sudah dipilih
      editedData = data;
    });
  }

  void _deleteData(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Data'),
          content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _myDataList.remove(data);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      setState(() {
        _dueDate = selectedDate;
        _controllerTanggal.text =
            DateFormat('dd MMMM yyyy').format(selectedDate);
      });
    }
  }

  @override
  void dispose() {
    _controllerPhone.dispose();
    _controllerNama.dispose();
    _controllerTanggal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ATS'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Nomor Telepon
                    _buildTextInput(
                      controller: _controllerPhone,
                      labelText: 'Nomor Telepon',
                      hintText: 'Masukkan nomor telepon Anda...',
                      validator: _validatePhone,
                    ),
                    const SizedBox(height: 16),

                    // Nama
                    _buildTextInput(
                      controller: _controllerNama,
                      labelText: 'Nama',
                      hintText: 'Masukkan nama Anda...',
                      validator: _validateNama,
                    ),
                    const SizedBox(height: 16),

                    // Tanggal
                    TextFormField(
                      controller: _controllerTanggal,
                      readOnly: true,
                      onTap: _selectDate,
                      decoration: InputDecoration(
                        labelText: 'Tanggal',
                        hintText: 'Pilih tanggal...',
                        suffixIcon: const Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFEAF8F9),
                      ),
                      validator: _validateTanggal,
                    ),
                    const SizedBox(height: 16),

                    // Color Picker
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pilih Warna',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: _currentColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: _showColorPicker,
                          child: const Text('Ubah Warna'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Gambar
                    ElevatedButton(
                      onPressed: _pickFile,
                      child: const Text('Pilih Gambar'),
                    ),
                    if (_imageFile != null) ...[
                      const SizedBox(height: 8),
                      Image.file(
                        _imageFile!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 8),
                      Text(_dataFile ?? ''),
                    ],
                    const SizedBox(height: 16),

                    // Submit Button
                    ElevatedButton(
                      onPressed: _addData,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ListView Data
              const Divider(
                thickness: 2,
                color: Colors.grey,
              ),
              const Text(
                'Data Masukan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _myDataList.length,
                itemBuilder: (context, index) {
                  final data = _myDataList[index];
                  return ListTile(
                    leading: data['image'] != null
                        ? CircleAvatar(
                            backgroundImage: FileImage(data['image']),
                            radius: 30,
                          )
                        : const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.black,
                          ),
                    title: Text(data['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.phone,
                                size: 16), // Tambahkan ikon telepon
                            const SizedBox(width: 8), // Jarak kecil
                            Expanded(
                              child: Text(
                                data['phone'],
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4), // Jarak antar elemen
                        Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                size: 16), // Tambahkan ikon tanggal
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                data['date'],
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 10, // Ketebalan garis
                          width: double.infinity, // Penuh di baris
                          color:
                              data['color'], // Menampilkan warna sebagai garis
                        ),
                      ],
                    ),
                    trailing: Wrap(
                      spacing: 12,
                      children: [
                        IconButton(
                          onPressed: () => _editData(data),
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () => _deleteData(data),
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget helper untuk TextFormField
  Widget _buildTextInput({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: const Color(0xFFEAF8F9),
      ),
      validator: validator,
    );
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) {
        Color tempColor = _currentColor;

        return AlertDialog(
          title: const Text('Pilih Warna'),
          content: BlockPicker(
            pickerColor: tempColor,
            onColorChanged: (color) {
              tempColor = color;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() => _currentColor = tempColor);
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }
}
