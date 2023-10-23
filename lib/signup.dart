import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.17, -0.98),
            end: Alignment(-0.17, 0.98),
            colors: [Color(0xE800C1FF), Colors.white.withOpacity(0.8999999761581421)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: 400, // Adjust the width of the white box as needed
              height: 500, // Adjust the height of the white box as needed
              padding: EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4), // Set the background color and opacity
                borderRadius: BorderRadius.circular(16.0), // Optional: Add border radius to the box
              ),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        // Username validation
                        final usernameRegex = RegExp(r'^(?=(?:.*[a-zA-Z]){3})(?=(?:.*\d){3})[a-zA-Z\d]*$');
                        if (value == null || value.isEmpty || !usernameRegex.hasMatch(value)) {
                          return 'Username is invalid';
                        }
                        return null;
                      },
                      controller: _usernameController,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Username',
                        fillColor: Colors.white.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Password',
                        fillColor: Colors.white.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        // Password validation
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      controller: _confirmpasswordController,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Confirm Password',
                        fillColor: Colors.white.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        // Confirm Password validation
                        if (value != _passwordController.text) {
                          return 'Confirm Password doesn\'t match Password';
                        }
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Email Address',
                        fillColor: Colors.white.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      validator: (value) {
                        // Email validation
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email Address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ElevatedButton(
                          child: const Text('Back', style: TextStyle(color: Colors.white),),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.transparent),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          child: const Text('Sign Up', style: TextStyle(color: Colors.white),),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Processing Data')),
                              );
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
