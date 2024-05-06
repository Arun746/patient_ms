// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 2;
  late TabController _tabController;
  int currentTabIndex = 0;
  late TextEditingController searchController;
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;
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
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    searchController = TextEditingController();
    _tabController.addListener(() {
      currentTabIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabController.animateTo(currentTabIndex);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              'Get Doctor Appointment',
              style: TextStyle(color: Colors.white),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Color.fromARGB(255, 247, 244, 244)),
            onPressed: () {
              Navigator.pushNamed(context, '/Home');
            },
          ),
          bottom: AppBar(
            automaticallyImplyLeading: false,
            title: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  child: Text(' Select Speciality'),
                ),
                Tab(
                  child: Text(' Select Doctors'),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            //Speciality
            SingleChildScrollView(
              child: Column(
                children: [
                  //search
                  Container(
                    margin: EdgeInsets.all(screenWidth * 0.03),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 221, 234, 238),
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: (query) {},
                      decoration: InputDecoration(
                        contentPadding: EdgeInsetsDirectional.symmetric(
                            vertical: 0.015 * screenHeight),
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search Specialities here',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  //specialities
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: screenHeight * 0.68,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: screenWidth * 0.01,
                          mainAxisSpacing: screenHeight * 0.001,
                        ),
                        itemCount: 15,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/Doctors');
                            },
                            child: Card(
                              elevation: 0,
                              color: Color.fromARGB(255, 168, 197, 201),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.03),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(screenWidth * 0.01),
                                child: Column(
                                  children: [],
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
            //doctors
            SingleChildScrollView(
              child: Column(
                children: [
                  //search
                  Container(
                    margin: EdgeInsets.all(screenWidth * 0.03),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 221, 234, 238),
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: (query) {},
                      decoration: InputDecoration(
                        contentPadding: EdgeInsetsDirectional.symmetric(
                            vertical: 0.015 * screenHeight),
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search doctors here',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  //dlist
                  SizedBox(
                    height: screenHeight * 0.68,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (int i = 0; i < 6; i++) _list(i),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        //bottomnavbar
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
          onTap: onTabTapped,
        ),
      ),
    );
  }

  Widget _list(int i) {
    return GestureDetector(
      child: ListTile(
        title: Container(
          // height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
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
              //image
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Container(
                      height: screenHeight * 0.12,
                      width: screenWidth * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
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
              //
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Doctor Name',
                      style: TextStyle(
                          color: Color.fromARGB(255, 3, 58, 80),
                          fontSize: 16 * (screenWidth / 360)),
                    ),
                    Text(
                      'Speciality',
                      style: TextStyle(
                          color: Color.fromARGB(255, 26, 30, 31),
                          fontSize: 14 * (screenWidth / 360)),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Book An Appointment',
                            style: TextStyle(
                                color: const Color.fromARGB(255, 236, 3, 3)),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward,
                            color: const Color.fromARGB(255, 240, 6, 6),
                            size: 20,
                          )
                        ],
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
