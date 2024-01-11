// sejarahitenas.dart

import 'package:flutter/material.dart';

class SejarahItenasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang Itenas'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Institut Teknologi Nasional (Itenas) Bandung',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'merupakan perguruan tinggi yang terletak di Jl. PH.H. Mustopa No. 23 – Bandung. Area yang mudah dijangkau dari berbagai arah Kota Bandung menjadikan lokasi Kampus Itenas cukup strategis. Dikelilingi oleh berbagai pusat perbelanjaan, pusat kuliner, percetakan, dan juga perumahan, Itenas menjadi salah satu kampus yang sangat hidup dan menyenangkan.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SejarahItenasPage(),
  ));
}
