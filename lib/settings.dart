import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  String username;
  String password;

  User(this.username, this.password);
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<User> userAccounts = [];
  TextEditingController newUsernameController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  void _loadUserAccounts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedAccounts = prefs.getStringList('user_accounts');

    if (savedAccounts != null) {
      setState(() {
        userAccounts = savedAccounts.map((username) {
          String password = prefs.getString(username) ?? '';
          return User(username, password);
        }).toList();
      });
    }
  }

  void _addUserAccount(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userAccounts.add(User(username, password));
    prefs.setStringList(
        'user_accounts', userAccounts.map((user) => user.username).toList());
    prefs.setString(username, password);
    _loadUserAccounts();
  }

  void _deleteUserAccount(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userAccounts.remove(user);
    prefs.setStringList(
        'user_accounts', userAccounts.map((user) => user.username).toList());
    prefs.setString(user.username, '');
    _loadUserAccounts();
  }

  Future<void> _showUserDialog(String dialogTitle, {User? user}) async {
    newUsernameController.text = user?.username ?? '';
    newPasswordController.text = user?.password ?? '';

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(dialogTitle),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Username:'),
              TextField(
                controller: newUsernameController,
                decoration: InputDecoration(hintText: 'Enter username'),
              ),
              SizedBox(height: 10),
              Text('Password:'),
              TextField(
                controller: newPasswordController,
                decoration: InputDecoration(hintText: 'Enter password'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                String newUsername = newUsernameController.text;
                String newPassword = newPasswordController.text;

                if (newUsername.isNotEmpty && newPassword.isNotEmpty) {
                  if (user != null) {
                    // If editing existing user
                    _deleteUserAccount(user);
                  }
                  _addUserAccount(newUsername, newPassword);
                  newUsernameController.clear();
                  newPasswordController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: Text(dialogTitle),
            ),
            TextButton(
              onPressed: () {
                newUsernameController.clear();
                newPasswordController.clear();
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadUserAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'User Accounts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            if (userAccounts.isEmpty)
              Text('No user accounts available.')
            else
              Expanded(
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Username')),
                    DataColumn(label: Text('Password')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: userAccounts
                      .map(
                        (user) => DataRow(
                          cells: [
                            DataCell(Text(user.username)),
                            DataCell(Text(user.password)),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () => _showUserDialog(
                                        'Edit User',
                                        user: user),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () => _deleteUserAccount(user),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showUserDialog('Add New User'),
              child: Text('Add New User'),
            ),
          ],
        ),
      ),
    );
  }
}
