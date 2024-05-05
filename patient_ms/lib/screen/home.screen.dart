// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //profile
            // ignore: avoid_unnecessary_containers
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
                              onTap: () {},
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
                              onTap: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.switch_account_rounded),
                                  SizedBox(width: screenWidth * 0.04),
                                  Text('Switch Account'),
                                ],
                              ),
                            ),
                            PopupMenuItem<String>(
                              onTap: () {},
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
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            //svrcsheading
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15),
              child: Text(
                'Other Services',
                style: TextStyle(fontSize: 17 * (screenWidth / 360)),
              ),
            ),
            //svrcs
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: screenHeight * 0.5,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: screenWidth * 0.01,
                    mainAxisSpacing: screenHeight * 0.001,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 0,
                      color: const Color.fromARGB(255, 191, 136, 136),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.01),
                        child: Column(
                          children: [Text('data')],
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

        backgroundColor: Colors.grey,
        iconSize: 25,
        selectedItemColor: Color.fromARGB(255, 10, 95, 115),
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
    );
  }
}
