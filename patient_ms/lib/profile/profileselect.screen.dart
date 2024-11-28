// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:patient_ms/Auth/screen/login.screen.dart';
import 'package:patient_ms/Auth/services/authservice.dart';
import 'package:patient_ms/profile/profile.model.dart';
import 'package:patient_ms/profile/profile.service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/config.dart';

class SelectProfile extends StatefulWidget {
  const SelectProfile({super.key});

  @override
  State<SelectProfile> createState() => _SelectProfileState();
}

class _SelectProfileState extends State<SelectProfile> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;
  int? _selectedIndex;
  String? _userId;

  String serializePatient(PatientInfoDt patient) =>
      json.encode(patient.toJson());

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString('userid') ?? '';
      // print(_userId);
    });
  }

  Future<void> saveSelectedPatient(PatientInfoDt filteredData) async {
    print('Saving patient data:');
    print('Policy ID: ${filteredData.policyid}');
    print('Full data: ${filteredData.toJson()}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String serializedPatient = serializePatient(filteredData);
    print('Serialized data: $serializedPatient');
    await prefs.setString('selected_patient_data', serializedPatient);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(24, 97, 121, 0.8),
          title: const Text(
            'Select Profile',
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.person_add_alt_1,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            SizedBox(
              width: screenWidth * 0.04,
            ),
            IconButton(
              icon: const Icon(
                Icons.logout_sharp,
                color: Colors.white,
              ),
              onPressed: () {
                AwesomeDialog(
                  dialogBackgroundColor: Colors.white,
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.topSlide,
                  // showCloseIcon: true,
                  title: "Ohh!",
                  desc: 'Are you sure you want to logout?',
                  descTextStyle: TextStyle(
                      fontSize: 16 * (screenWidth / 360),
                      color: Config.primarythemeColor),
                  btnCancelText: 'No',
                  btnCancelOnPress: () {},
                  btnOkText: 'Yes',
                  btnOkOnPress: () async {
                    await AuthService.logout(context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                    Fluttertoast.showToast(
                        msg: 'Logged Out !!',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP_LEFT,
                        timeInSecForIosWeb: 0.1.round(),
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  btnOkColor: Config.primarythemeColor,
                  btnCancelColor: Colors.grey.shade700,
                ).show();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            FutureBuilder<List<PatientInfoDt>>(
                future: ProfileService.getData(_userId),
                builder: (BuildContext context,
                    AsyncSnapshot<List<PatientInfoDt>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.2),
                      child: Column(
                        children: [
                          const Center(
                            child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 78, 131, 187),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: screenHeight * 0.02),
                            child: const Text('Loading...'),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.02),
                      child: Text(
                        '${snapshot.error}.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13 * (screenWidth / 360),
                        ),
                      ),
                    );
                  } else {
                    List<PatientInfoDt> filteredData = snapshot.data!.toList();

                    if (filteredData.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.15,
                          horizontal: screenWidth * 0.02,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                                height: screenHeight * 0.3,
                                child: Image.asset(
                                  'images/noresult.png',
                                  fit: BoxFit.fill,
                                )),
                            Text(
                              'Sorry! No Profile found. Create one by clicking the add button in above appbar.',
                              style: GoogleFonts.poppins(
                                fontSize: 14 * (screenWidth / 360),
                                color: Colors.red.shade500,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          SizedBox(
                            height: screenHeight * 0.8,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(right: screenWidth * 0.02),
                              child: ListView.builder(
                                itemCount: filteredData.length,
                                itemBuilder: (context, index) {
                                  final data = filteredData[index];
                                  return _list(data, index);
                                },
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromRGBO(24, 97, 121, 0.8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () async {
                              if (_selectedIndex == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Center(
                                        child: Text(
                                      'Select A Profile First',
                                      style: TextStyle(fontSize: 15),
                                    )),
                                    duration: Duration(milliseconds: 500),
                                  ),
                                );
                              } else {
                                if (_selectedIndex != null) {
                                  await saveSelectedPatient(
                                      filteredData[_selectedIndex!]);
                                  Navigator.pushNamed(context, '/Home');
                                }
                              }
                            },
                            child: const Text('Continue as Selected Profile'),
                          ),
                        ],
                      );
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget _list(PatientInfoDt data, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = _selectedIndex == index ? null : index;
          print(_selectedIndex);
        });
      },
      child: ListTile(
        title: Container(
          decoration: BoxDecoration(
            color: _selectedIndex == index
                ? Color.fromARGB(255, 136, 183, 197)
                : Colors.white,
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(1, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              // image
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.01),
                child: Column(
                  children: [
                    Container(
                      height: screenHeight * 0.12,
                      width: screenWidth * 0.2,
                      decoration: BoxDecoration(
                        color: _selectedIndex == index
                            ? Color.fromARGB(255, 136, 183, 197)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 128, 123, 123)
                                .withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: Image.asset('images/profile.png'),
                      ),
                    ),
                  ],
                ),
              ),
              // other content
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.pname.toString(),
                      style: TextStyle(
                        color: _selectedIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Text(
                      'Profile Id :${data.id.toString()}',
                      style: TextStyle(
                        color: _selectedIndex == index
                            ? Color.fromARGB(255, 255, 255, 255)
                            : Colors.black,
                      ),
                    ),
                    Text(
                      'Reg date : ${DateFormat('yyyy-MM-dd').format(DateTime.parse((data.ddate.toString())))}',
                      style: TextStyle(
                        color: _selectedIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
