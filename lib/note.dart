import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  TextEditingController _noteController = TextEditingController();
  List<String> savedNotes = []; // List untuk menyimpan catatan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: savedNotes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(savedNotes[index]),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _noteController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Write your notes here...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Save note logic here
                String noteText = _noteController.text;
                // Do something with the note, e.g., save to storage or database
                savedNotes.add(noteText); // Tambahkan catatan ke dalam list
                print('Note saved: $noteText');
                // Optionally, you can clear the text field after saving
                _noteController.clear();
                // Refresh tampilan untuk menampilkan catatan yang baru disimpan
                setState(() {});
              },
              child: Text('Save Note'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NotePage(),
  ));
}
