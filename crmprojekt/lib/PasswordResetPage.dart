import 'package:flutter/material.dart';



class PasswordResetPage extends StatefulWidget {
  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool _isObscured = true; // Initial value for text visibility

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured; // Toggle between true and false
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Passwort zurücksetzen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: newPasswordController,
              decoration: InputDecoration(
                labelText: 'Bitte geben Sie ein neues Passwort ein',
                suffixIcon: IconButton(
                  icon: Icon(
                    // Change the icon based on the obscureText state
                    _isObscured ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: _toggleVisibility, // Toggle the password visibility
                ),
              ),
              obscureText: _isObscured, // Use the _isObscured flag to obscure text
            ),
            SizedBox(height: 16),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Bitte wiederholen Sie das neue Passwort',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: _toggleVisibility,
                ),
              ),
              obscureText: _isObscured,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Logic to confirm password
              },
              child: Text('Passwort bestätigen'),
            ),
          ],
        ),
      ),
    );
  }
}
