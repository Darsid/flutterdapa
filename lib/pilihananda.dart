// pilihananda.dart

import 'package:flutter/material.dart';
import 'homepage.dart'; // Import file homepage.dart

class PilihanAndaPage extends StatefulWidget {
  @override
  _PilihanAndaPageState createState() => _PilihanAndaPageState();
}

class _PilihanAndaPageState extends State<PilihanAndaPage> {
  String selectedCandidate = 'Pilih kandidat';
  bool isButtonActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilihan Anda'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Siapa yang akan anda pilih saat pemilu 2024?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedCandidate,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCandidate = newValue!;
                  isButtonActive = selectedCandidate != 'Pilih kandidat';
                });
              },
              items: <String>['Pilih kandidat', 'Anies', 'Prabowo', 'Ganjar']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isButtonActive
                  ? () {
                      // Navigasi kembali ke homepage
                      Navigator.pop(context);
                    }
                  : null,
              child: Text('Semoga menjadi pilihan terbaik'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PilihanAndaPage(),
  ));
}
