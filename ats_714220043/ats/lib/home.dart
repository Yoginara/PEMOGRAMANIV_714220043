import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Biodata Saya',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                      'assets/profile.jpg'), // Ganti dengan path foto Anda
                ),
                SizedBox(height: 10),
                Text(
                  'Yoginara Pratama Sitorus',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'FORTIS FORTUNA ADIUVAT',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Detail Section
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildInfoTile(
                  icon: Icons.email,
                  title: 'Email',
                  subtitle: 'yoginara2004@gmail.com',
                ),
                const SizedBox(height: 10),
                _buildInfoTile(
                  icon: Icons.phone,
                  title: 'Nomor Telepon',
                  subtitle: '+62 813 6064 0668',
                ),
                const SizedBox(height: 10),
                _buildInfoTile(
                  icon: Icons.location_on,
                  title: 'Alamat',
                  subtitle: 'Konoha, Indonesia',
                ),
                const SizedBox(height: 10),
                _buildInfoTile(
                  icon: Icons.school,
                  title: 'Pendidikan',
                  subtitle: 'D4 Teknik Informatika - ULBI',
                ),
                const SizedBox(height: 10),
                _buildInfoTile(
                  icon: Icons.favorite,
                  title: 'Hobi',
                  subtitle: 'Travelling',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.deepPurple,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
