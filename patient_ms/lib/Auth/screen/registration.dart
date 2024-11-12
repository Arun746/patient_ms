// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, prefer_final_fields, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:patient_ms/Auth/model/signup.dart';
import 'package:patient_ms/Auth/services/authservice.dart';
import 'package:patient_ms/config/config.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;

  bool? userStatus;

  void checkStatus(String value) {
    AuthService.getUserStatus(value).then((bool result) {
      userStatus = result;
      if (mobile.text.length == 10 && userStatus == true) {
        SnackBar(
          content: Text("User already exists! Enter another number"),
        );
      }
    });
  }

  Future<void> postUser() async {
    context.loaderOverlay.show();
    SignUpModel user = SignUpModel(
      username: mobile.text,
      password: password.text,
      confirmPassword: confirmpassword.text,
      emailAddress: email.text,
      mobileNumber: mobile.text,
      address: address.text,
      firstName: firstname.text,
      lastName: lastname.text,
      userRoles: ['user'],
    );

    try {
      int statusCode = await AuthService.signUp(user);
      if (statusCode == 200) {
        SnackBar(
          backgroundColor: Colors.green,
          content: Text('User Registered Successfully'),
        );

        Navigator.pushNamed(context, '/Login');
      } else {
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Unable to register user : $statusCode'),
        );
      }
    } catch (e) {
      SnackBar(
        content: Text("An error occurred: $e"),
      );
    } finally {
      context.loaderOverlay.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //logo
                // Padding(
                //   padding: EdgeInsets.only(
                //     top: screenHeight * 0.03,
                //     right: screenWidth * 0.07,
                //   ),
                //   child: SizedBox(
                //     height: 0.1 * screenHeight,
                //     child: Image.asset('images/.......png'),
                //   ),
                // ),
                //signup txt
                Padding(
                  padding: EdgeInsets.only(top: 0.01 * screenHeight),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign ',
                        style: TextStyle(
                          fontSize: 25 * (screenWidth / 360),
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        'Up',
                        style: TextStyle(
                          fontSize: 25 * (screenWidth / 360),
                          fontWeight: FontWeight.w500,
                          color: Config.primarythemeColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.08 * screenWidth,
                    vertical: 0.008 * screenHeight,
                  ),
                  child: Text(
                    'Create An Account And Enjoy Our Services',
                    style: TextStyle(
                      fontSize: 16 * (screenWidth / 360),
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                //form
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0.12 * screenWidth,
                      vertical: 0.01 * screenHeight),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: firstname,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'First Name',
                            hintText: 'Enter your first name',
                            hintStyle: TextStyle(
                              fontSize: 12 * (screenWidth / 360),
                              color: Colors.grey.shade600,
                            ),
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 0.01 * screenHeight),
                        TextFormField(
                          controller: lastname,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Last Name',
                            hintText: 'Enter your Last name',
                            hintStyle: TextStyle(
                              fontSize: 12 * (screenWidth / 360),
                              color: Colors.grey.shade600,
                            ),
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 0.01 * screenHeight),
                        TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Email',
                            hintText: 'abc@gmail.com',
                            hintStyle: TextStyle(
                              fontSize: 12 * (screenWidth / 360),
                              color: Colors.grey.shade600,
                            ),
                            prefixIcon: Icon(Icons.mail),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: 0.01 * screenHeight),
                        TextFormField(
                          onChanged: (value) => checkStatus(value),
                          controller: mobile,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Mobile No',
                            hintText: '9861******',
                            hintStyle: TextStyle(
                              fontSize: 12 * (screenWidth / 360),
                              color: Colors.grey.shade600,
                            ),
                            prefixIcon: Icon(Icons.phone),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length != 10) {
                              return 'Please enter valid phone number';
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: 0.01 * screenHeight),
                        TextFormField(
                          controller: address,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Address',
                            hintText: 'your location',
                            hintStyle: TextStyle(
                              fontSize: 12 * (screenWidth / 360),
                              color: Colors.grey.shade600,
                            ),
                            prefixIcon: Icon(Icons.location_pin),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: 0.01 * screenHeight),
                        TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Password',
                            hintText: 'Enter Password',
                            hintStyle: TextStyle(
                              fontSize: 12 * (screenWidth / 360),
                              color: Colors.grey.shade600,
                            ),
                            prefixIcon: Icon(Icons.password),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                        SizedBox(height: 0.01 * screenHeight),
                        TextFormField(
                          controller: confirmpassword,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Confirm Password',
                            hintText: 'Confirm your password',
                            hintStyle: TextStyle(
                              fontSize: 12 * (screenWidth / 360),
                              color: Colors.grey.shade600,
                            ),
                            prefixIcon: Icon(Icons.password),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            } else if (value != password.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 0.02 * screenHeight),
                            child: SizedBox(
                              width: screenWidth * 0.5,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    postUser();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Config.primarythemeColor,
                                  shadowColor: Colors.transparent,
                                ),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 0.03 * screenHeight),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have a account?',
                        style: TextStyle(
                          fontSize: 14 * (screenWidth / 360),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/Login');
                        },
                        child: Text(
                          ' Login',
                          style: TextStyle(
                            color: Config.primarythemeColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14 * (screenWidth / 360),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
