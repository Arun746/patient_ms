// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:patient_ms/AppointmentNew/screen/appointbooking.dart';
import 'package:patient_ms/Auth/screen/login.screen.dart';
import 'package:patient_ms/Auth/services/authservice.dart';
import 'package:patient_ms/config/config.dart';
import 'package:patient_ms/screen/hospital.screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;

  int _selectedIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushNamed(context, "/Home");
    } else if (index == 1) {
    } else if (index == 2) {
      Navigator.pushNamed(context, "/Appointment");
    } else if (index == 3) {}
  }

  void _alertSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color.fromARGB(255, 233, 59, 59),
        duration: Duration(milliseconds: 500),
        content: Text(
          message,
          style: TextStyle(fontSize: 14 * (screenWidth / 360)),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();
    return WillPopScope(
      onWillPop: () async {
        final differeance = DateTime.now().difference(timeBackPressed);
        timeBackPressed = DateTime.now();
        if (differeance >= Duration(seconds: 2)) {
          const String msg = 'Press again to exit';
          Fluttertoast.showToast(
            msg: msg,
          );
          return false;
        } else {
          Fluttertoast.cancel();
          SystemNavigator.pop();
          return true;
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.01,
              ),
              //profile
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: screenWidth * 0.3,
                      child: Image.asset('images/profile.png'),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Profile Name',
                        style: TextStyle(fontSize: 18 * (screenWidth / 360)),
                      ),
                      Text(
                        '#7267147',
                        style: TextStyle(fontSize: 15 * (screenWidth / 360)),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.13),
                        child: PopupMenuButton(
                          icon: Icon(
                            Icons.more_vert,
                            size: 25 * (screenWidth / 360),
                          ),
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<String>(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Icon(Icons.person),
                                    SizedBox(width: screenWidth * 0.04),
                                    Text('Profile'),
                                  ],
                                ),
                              ),
                              PopupMenuItem<String>(
                                onTap: () {
                                  Navigator.pushNamed(context, '/Appointment');
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.calendar_month),
                                    SizedBox(width: screenWidth * 0.04),
                                    Text('Appoinment'),
                                  ],
                                ),
                              ),
                              PopupMenuItem<String>(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Icon(Icons.medical_services_outlined),
                                    SizedBox(width: screenWidth * 0.04),
                                    Text('Medication'),
                                  ],
                                ),
                              ),
                              PopupMenuItem<String>(
                                onTap: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/SelectUser', (route) => false);
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.switch_account_rounded),
                                    SizedBox(width: screenWidth * 0.04),
                                    Text('Switch Profile'),
                                  ],
                                ),
                              ),
                              PopupMenuItem<String>(
                                onTap: () {
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
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()),
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
                                child: Row(
                                  children: [
                                    Icon(Icons.logout),
                                    SizedBox(width: screenWidth * 0.04),
                                    Text('Logout'),
                                  ],
                                ),
                              ),
                            ];
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
              //bookappointment
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 223, 235, 247),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.02,
                        vertical: screenHeight * 0.02),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'With Just One Click Book Your Appointment And Make Your Checkup Easy',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 4, 85, 106),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    AppointmentBookingPage()));
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color.fromARGB(255, 255, 255, 255),
                            backgroundColor: Color.fromARGB(255, 4, 85, 106),
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.1,
                                vertical: screenHeight * 0.01),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: Text(
                            'Book Now',
                            style: TextStyle(
                              fontSize: 15 * (screenWidth / 360),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              //svrcsheading
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.04, top: screenHeight * 0.02),
                child: Text(
                  'Other Services',
                  style: TextStyle(
                      fontSize: 17 * (screenWidth / 360),
                      color: const Color.fromRGBO(24, 97, 121, 0.8),
                      fontWeight: FontWeight.w500),
                ),
              ),
              //svrcs
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: SizedBox(
                  height: screenHeight * 0.5,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: screenWidth * 0.04,
                      mainAxisSpacing: screenHeight * 0.04,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      final dataList = [
                        {
                          'image': 'images/medication.png',
                          'text': 'Medication',
                          'onTap': () {
                            _alertSnackbar(
                                "This feature will be available soon");
                          }
                        },
                        {
                          'image': 'images/report.png',
                          'text': 'Reports',
                          'onTap': () {
                            _alertSnackbar(
                                "This feature will be available soon");
                          }
                        },
                        {
                          'image': 'images/vitals.png',
                          'text': 'Vitals',
                          'onTap': () {
                            _alertSnackbar(
                                "This feature will be available soon");
                          }
                        },
                        {
                          'image': 'images/welness.png',
                          'text': 'Wellness Plan',
                          'onTap': () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => HospitalList()),
                            );
                          }
                        },
                      ];
                      final data = dataList[index];
                      return InkWell(
                        onTap: data['onTap'] as VoidCallback,
                        child: Card(
                          shadowColor: Color.fromARGB(255, 6, 27, 32),
                          elevation: 1,
                          color: Color.fromARGB(255, 233, 245, 249),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.03),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(screenWidth * 0.01),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: screenHeight * 0.12,
                                  child: Image.asset(
                                    data['image'] as String,
                                  ),
                                ),
                                Text(
                                  data['text'] as String,
                                  style: TextStyle(
                                      fontSize: 16 * (screenWidth / 360)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        //bottombar
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: 25,
          backgroundColor: const Color.fromRGBO(24, 97, 121, 0.8),
          selectedItemColor: Color.fromARGB(255, 1, 235, 211),
          unselectedItemColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.medication),
              label: 'Medication',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Appoinment',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_vert),
              label: 'More',
            ),
          ],
          currentIndex: _selectedIndex,
          // selectedItemColor: Colors.black,
          onTap: onTabTapped,
        ),
      ),
    );
  }
}
