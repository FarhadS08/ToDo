import 'package:flutter/material.dart';
import 'package:list_manipulation/models/user.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

class Login extends StatefulWidget {
  static String id = 'login';

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _isLoading = false;

  UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF2F2F2),
                      // This is a color that is a bit darker than white
                      hintText: 'Email',
                      contentPadding: EdgeInsets.all(15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    }),
                const SizedBox(height: 15.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFF2F2F2),
                    // This is a color that is a bit darker than white
                    hintText: 'Password',
                    contentPadding: EdgeInsets.all(15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15.0),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0.2, // This removes the shadow
                        ),
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          if (_formKey.currentState!.validate()) {
                            user =
                                await Provider.of<Auth>(context, listen: false)
                                    .signIn(
                              _emailController.text,
                              _passwordController.text,
                            );

                            if(mounted){
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          }
                        },
                        child: Text('Sign In'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
