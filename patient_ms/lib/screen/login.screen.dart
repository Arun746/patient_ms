// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;
  bool _passwordVisible = false;
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void showErrorToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_LEFT,
        timeInSecForIosWeb: 0.1.round(),
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void showSuccessToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_LEFT,
        timeInSecForIosWeb: 0.1.round(),
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 246, 248),
      body: SafeArea(
        child: LoaderOverlay(
          child: SingleChildScrollView(
            child: Container(
              height: screenHeight,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/bgimg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  //norviclogo
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.03,
                      left: screenWidth * 0.1,
                    ),
                    child: SizedBox(
                      height: 0.1 * screenHeight,
                      child: Image.asset('images/norvichospital.png'),
                    ),
                  ),
                  //welcome txt
                  Padding(
                    padding: EdgeInsets.only(
                      top: 0.03 * screenHeight,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome ',
                          style: TextStyle(
                            fontSize: 25 * (screenWidth / 360),
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 25 * (screenWidth / 360),
                            fontWeight: FontWeight.w500,
                            color: Colors.pink.shade200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //sp txt
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.08 * screenWidth,
                      vertical: 0.008 * screenHeight,
                    ),
                    child: Text(
                      'Sign In To Your Account For Appointment Booking And Report Preview',
                      style: TextStyle(fontSize: 16 * (screenWidth / 360)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //form
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.03),
                    child: Form(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 0.11 * screenWidth,
                              vertical: 0.01 * screenHeight,
                            ),
                            child: TextFormField(
                              controller: _userIdController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    25 * (screenWidth / 360),
                                  ),
                                ),
                                labelText: 'User Id',
                                labelStyle: const TextStyle(
                                  color: Color.fromARGB(255, 80, 108, 121),
                                ),
                                hintText: 'Registered contact number',
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade500),
                                prefixIcon: const Icon(Icons.person),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'User Id required';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 0.11 * screenWidth,
                              vertical: 0.01 * screenHeight,
                            ),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    25 * (screenWidth / 360),
                                  ),
                                ),
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade500),
                                labelStyle: const TextStyle(
                                  color: Color.fromARGB(255, 80, 108, 121),
                                ),
                                prefixIcon: const Icon(Icons.password),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password required';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 0.01 * screenHeight,
                              right: 0.15 * screenWidth,
                            ),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {},
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Colors.lightBlue.shade900,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12 * (screenWidth / 360),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.032 * screenHeight),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/SelectUser');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(24, 97, 121, 0.8),
                                shadowColor: Colors.transparent,
                                fixedSize: Size(
                                  screenWidth * 0.5,
                                  screenHeight * 0.01,
                                ),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16 * (screenWidth / 360)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //divider
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.15 * screenWidth,
                      vertical: screenHeight * 0.025,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.03),
                            child: const Divider(
                              color: Color.fromARGB(255, 162, 159, 159),
                              thickness: 0.8,
                            ),
                          ),
                        ),
                        Text(
                          "Or",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 129, 123, 123),
                              fontSize: 15 * (screenWidth / 360),
                              fontWeight: FontWeight.w500),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.03),
                            child: const Divider(
                              color: Color.fromARGB(255, 133, 132, 132),
                              thickness: 0.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't Have Account?",
                          style: TextStyle(
                              fontSize: 11 * (screenWidth / 360),
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        shadowColor: Colors.transparent,
                        fixedSize: Size(
                          screenWidth * 0.5,
                          screenHeight * 0.008,
                        ),
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16 * (screenWidth / 360)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
