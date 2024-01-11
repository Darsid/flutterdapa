import 'package:flutter/material.dart';
import 'calculator.dart';
import 'pilihananda.dart';
import 'sejarahitenas.dart';
import 'settings.dart';
import 'aboutme.dart';
import 'loginpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> holidaysData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('https://www.gov.uk/bank-holidays.json'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          holidaysData = data['england-and-wales']['events'];
        });
        print(holidaysData);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Kalkulator'),
              leading: Icon(Icons.calculate),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalculatorPage()),
                );
              },
            ),
            ListTile(
              title: Text('Pilihan Anda'),
              leading: Icon(Icons.touch_app),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PilihanAndaPage()),
                );
              },
            ),
            ListTile(
              title: Text('Sejarah Itenas'),
              leading: Icon(Icons.school),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SejarahItenasPage()),
                );
              },
            ),
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            ListTile(
              title: Text('About Me'),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutMePage()),
                );
              },
            ),
            ListTile(
              title: Text('Logout'),
              trailing: Icon(Icons.power_settings_new),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CalculatorPage()),
                      );
                    },
                    child: Icon(
                      Icons.calculate,
                      size: 30,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Kalkulator',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PilihanAndaPage()),
                      );
                    },
                    child: Icon(
                      Icons.touch_app,
                      size: 30,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Pilihan Anda',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SejarahItenasPage()),
                      );
                    },
                    child: Icon(
                      Icons.school,
                      size: 30,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Sejarah Itenas',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Tanggal')),
                  DataColumn(label: Text('Nama Hari')),
                  DataColumn(label: Text('Deskripsi')),
                ],
                rows: holidaysData.map((data) {
                  return DataRow(cells: [
                    DataCell(Text(data['date'])),
                    DataCell(Text(data['title'])),
                    DataCell(Text(data['notes'] ?? '')),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
