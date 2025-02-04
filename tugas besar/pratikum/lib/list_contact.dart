import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class BettaFishFormList extends StatefulWidget {
  const BettaFishFormList({super.key});

  @override
  State<BettaFishFormList> createState() => _BettaFishFormListState();
}

class _BettaFishFormListState extends State<BettaFishFormList> {
  String? _selectedGender;
  final List<String> _genders = ['Jantan', 'Betina'];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerSpecies = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();
  String? _dataFile;
  File? _imageFile;

  final List<Map<String, dynamic>> _bettaFishList = [];
  Map<String, dynamic>? editedData;

  final NumberFormat _currencyFormat =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) return 'Nama ikan wajib diisi';
    return null;
  }

  String? _validateSpecies(String? value) {
    if (value == null || value.isEmpty) return 'Jenis ikan wajib diisi';
    return null;
  }

  String? _validatePrice(String? value) {
    if (value == null || value.isEmpty) return 'Harga ikan wajib diisi';
    if (double.tryParse(value) == null) return 'Harga harus berupa angka';
    if (double.parse(value) <= 0) return 'Harga harus lebih besar dari 0';
    return null;
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    final file = result.files.first;

    if (file.extension == 'jpg' ||
        file.extension == 'png' ||
        file.extension == 'jpeg') {
      setState(() {
        _imageFile = File(file.path!);
      });
    }

    setState(() {
      _dataFile = file.name;
    });
  }

  void _addBettaFish() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap pilih gambar sebelum submit!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final data = {
      'name': _controllerName.text,
      'species': _controllerSpecies.text,
      'gender': _selectedGender,
      'price': _controllerPrice.text,
      'image': _imageFile,
    };

    setState(() {
      if (editedData != null) {
        editedData!['name'] = data['name'];
        editedData!['species'] = data['species'];
        editedData!['gender'] = data['gender'];
        editedData!['price'] = data['price'];
        editedData!['image'] = data['image'];
        editedData = null;
      } else {
        _bettaFishList.add(data);
      }
      _controllerName.clear();
      _controllerSpecies.clear();
      _controllerPrice.clear();
      _selectedGender = null;
      _imageFile = null;
    });
  }

  void _editBettaFish(Map<String, dynamic> data) {
    setState(() {
      _controllerName.text = data['name'];
      _controllerSpecies.text = data['species'];
      _controllerPrice.text = data['price'];
      _selectedGender = data['gender'];
      _imageFile = data['image'];
      editedData = data;
    });
  }

  void _deleteBettaFish(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Data'),
          content: const Text('Apakah Anda yakin ingin menghapus ikan ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _bettaFishList.remove(data);
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

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerSpecies.dispose();
    _controllerPrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Betta Store'),
        centerTitle: true,
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
                    _buildTextInput(
                      controller: _controllerName,
                      labelText: 'Nama Ikan',
                      hintText: 'Masukkan nama ikan cupang...',
                      validator: _validateName,
                    ),
                    const SizedBox(height: 16),
                    _buildTextInput(
                      controller: _controllerSpecies,
                      labelText: 'Jenis Ikan',
                      hintText: 'Masukkan jenis ikan...',
                      validator: _validateSpecies,
                    ),
                    const SizedBox(height: 16),
                    _buildTextInput(
                      controller: _controllerPrice,
                      labelText: 'Harga Ikan',
                      hintText: 'Masukkan harga ikan...',
                      validator: _validatePrice,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Jenis Kelamin',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFEDE7F6),
                      ),
                      items: _genders
                          .map((gender) => DropdownMenuItem(
                                value: gender,
                                child: Text(gender),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Jenis kelamin wajib dipilih';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _pickFile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Pilih Gambar'),
                    ),
                    if (_imageFile != null) ...[
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          _imageFile!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(_dataFile ?? ''),
                    ],
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _addBettaFish,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Tambah Ikan'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(
                thickness: 2,
                color: Colors.grey,
              ),
              const Text(
                'Data Ikan Cupang',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 12),
              _bettaFishList.isEmpty
                  ? Center(child: Text('Belum ada data ikan!'))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _bettaFishList.length,
                      itemBuilder: (context, index) {
                        final data = _bettaFishList[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
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
                            subtitle: Text(
                                '${data['species']} - ${_currencyFormat.format(double.parse(data['price']))}'),
                            trailing: Wrap(
                              spacing: 12,
                              children: [
                                IconButton(
                                  onPressed: () => _editBettaFish(data),
                                  icon: const Icon(Icons.edit),
                                  color: Colors.deepPurple,
                                ),
                                IconButton(
                                  onPressed: () => _deleteBettaFish(data),
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                ),
                              ],
                            ),
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

  Widget _buildTextInput({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: const Color(0xFFEDE7F6),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}
