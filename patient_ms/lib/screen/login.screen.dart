// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_element

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:patient_ms/Auth/screen/registration.dart';
import 'package:patient_ms/Auth/services/authservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;
  bool _passwordVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ipAddressController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  void showErrorToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM_LEFT,
        timeInSecForIosWeb: 0.1.round(),
        backgroundColor: const Color.fromARGB(255, 239, 108, 99),
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

//--------------------------------- POST USER --------------------------------//
  Future<void> postUser() async {
    if (!_formKey.currentState!.validate()) return;
    context.loaderOverlay.show();
    try {
      Map<String, dynamic> responseJson = await AuthService()
          .login(_usernameController.text, _passwordController.text);
      if (responseJson.containsKey('access_token')) {
        String accessToken = responseJson['access_token'];
        await _storeToken(accessToken);
        print(accessToken);
        context.loaderOverlay.hide();
        Navigator.pushNamed(context, '/Home');
        showSuccessToast('Logged In Successfully');
      } else {
        context.loaderOverlay.hide();
        showErrorToast('Authentication failed. No access token received.');
      }
    } catch (e) {
      context.loaderOverlay.hide();
      showErrorToast(' $e');
    } finally {
      context.loaderOverlay.hide();
    }
  }

  Future<void> _storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

//-------------------------------- Remember me -------------------------------//
  Future<void> _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setString('username', _usernameController.text);
      await prefs.setString('password', _passwordController.text);
    } else {
      await prefs.remove('username');
      await prefs.remove('password');
    }
  }

  Future<void> _loadCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? password = prefs.getString('password');
    // print("Username: $username");
    // print("Password: $password");
    if (username != null && password != null) {
      setState(() {
        _usernameController.text = username;
        _passwordController.text = password;
        _rememberMe = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 246, 248),
      body: LoaderOverlay(
        child: SafeArea(
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
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.03),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          //id
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 0.11 * screenWidth,
                              vertical: 0.01 * screenHeight,
                            ),
                            child: TextFormField(
                              controller: _usernameController,
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
                                hintText: 'Enter your username',
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
                          //paw
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 0.11 * screenWidth,
                              vertical: 0.01 * screenHeight,
                            ),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: !_passwordVisible,
                              obscuringCharacter: '*',
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
                          //remember me
                          Padding(
                            padding: EdgeInsets.only(
                              top: 0.01 * screenHeight,
                              left: 0.1 * screenWidth,
                            ),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: CheckboxListTile(
                                  checkColor: Colors.white,
                                  activeColor: Colors.blueGrey,
                                  value: _rememberMe,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      // print('value changed');
                                      _rememberMe = newValue!;
                                    });
                                  },
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: Text(
                                    "Remember Me",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                )),
                          ),
                          //btn
                          Padding(
                            padding: EdgeInsets.only(top: 0.02 * screenHeight),
                            child: ElevatedButton(
                              onPressed: () {
                                postUser();
                                _saveCredentials();
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
                                      color: const Color.fromARGB(
                                          255, 129, 123, 123),
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
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                shadowColor: Colors.transparent,
                                fixedSize: Size(
                                  screenWidth * 0.5,
                                  screenHeight * 0.008,
                                ),
                                side: const BorderSide(
                                  color: Color.fromARGB(255, 116, 111, 111),
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 140, 136, 136),
                                    fontSize: 16 * (screenWidth / 360)),
                              ),
                            ),
                          ),
                        ],
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

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _ipAddressController.dispose();
    super.dispose();
  }
}
