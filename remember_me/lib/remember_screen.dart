import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    try {
      await _loadRememberMe();
    } catch (e) {
      print('Initialization error: $e');
    }
  }

  Future<void> _loadRememberMe() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? savedRememberMe = prefs.getBool('rememberMe');
      String? savedUsername = prefs.getString('username');
      String? savedPassword = prefs.getString('password');

      if (savedRememberMe != null) {
        setState(() {
          _rememberMe = savedRememberMe;
          if (_rememberMe) {
            _usernameController.text = savedUsername ?? '';
            _passwordController.text = savedPassword ?? '';
          }
        });
      }
    } catch (e) {
      print('Error loading preferences: $e');
    }
  }

  Future<void> _saveRememberMe() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (_rememberMe) {
        await prefs.setBool('rememberMe', true);
        await prefs.setString('username', _usernameController.text);
        await prefs.setString('password', _passwordController.text);
      } else {
        await prefs.setBool('rememberMe', false);
        await prefs.remove('username');
        await prefs.remove('password');
      }
    } catch (e) {
      print('Error saving preferences: $e');
    }
  }

  void _login() {

    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(' plrase, fill  ')),
      );
      return;
    }

    _saveRememberMe().then((_) {

      print('Login successful - Remember me: $_rememberMe');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' Login')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Email ',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),

            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: ' Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),


            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _rememberMe = !_rememberMe;
                    });
                  },
                  child: Text(
                    'remember me',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Checkbox(
                  value: _rememberMe,
                  onChanged: (bool? value) {
                    if (value != null) {
                      setState(() {
                        _rememberMe = value;
                      });
                    }
                  },
                ),
              ],
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text(' Login'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}