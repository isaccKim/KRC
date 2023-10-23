// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

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
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 400, // Adjust the width of the white box as needed
              height: 400,
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4), // Set the background color and opacity
                borderRadius: BorderRadius.circular(16.0), // Optional: Add border radius to the box
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Lottie.asset(
                          'assets/bear.json',
                          fit: BoxFit.cover,
                          height: 50,
                        ),
                        const SizedBox(height: 16.0),
                        Text('Welcome to KRC'),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        fillColor: Colors.white.withOpacity(0.2), // Set the background color and opacity
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        fillColor: Colors.white.withOpacity(0.1), // Set the background color and opacity
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        TextButton(
                          child: const Text('CANCEL', style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            _usernameController.clear();
                            _passwordController.clear();
                          },
                        ),
                        TextButton(
                          child: const Text('Sign Up', style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                        ),
                        ElevatedButton(
                          child: const Text('NEXT', style: TextStyle(color: Colors.white),),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
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
