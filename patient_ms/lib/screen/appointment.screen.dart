// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

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
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    searchController = TextEditingController();
    _tabController.addListener(() {
      currentTabIndex = _tabController.index;
    });
  }

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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabController.animateTo(currentTabIndex);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/Home');
        return false;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(24, 97, 121, 0.8),
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
                          hintText: 'Search  specialities  here',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    //specialities
                    SizedBox(
                      height: screenHeight * 0.623,
                      child: Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.02),
                        child: Scrollbar(
                          controller: _scrollController,
                          thumbVisibility: true,
                          scrollbarOrientation: ScrollbarOrientation.right,
                          thickness: 5,
                          radius: Radius.circular(5),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.02),
                            child: GridView.builder(
                              controller: _scrollController,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: screenWidth * 0.01,
                                mainAxisSpacing: screenHeight * 0.001,
                              ),
                              itemCount: 18,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.all(screenWidth * 0.02),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/Doctors');
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            screenWidth * 0.03),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            offset: Offset(1, 1),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.all(screenWidth * 0.01),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                child: Image.asset(
                                                    'images/speciality.png'),
                                              ),
                                            ),
                                            Text(
                                              'Orthopedic Implants',
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
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
                      height: screenHeight * 0.63,
                      child: Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.02),
                        child: Scrollbar(
                          controller: _scrollController,
                          thumbVisibility: true,
                          scrollbarOrientation: ScrollbarOrientation.right,
                          thickness: 5,
                          radius: Radius.circular(5),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                for (int i = 0; i < 6; i++) _doctorlist(i),
                              ],
                            ),
                          ),
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
            backgroundColor: const Color.fromRGBO(24, 97, 121, 0.8),
            selectedItemColor: Color.fromARGB(255, 6, 245, 221),
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
      ),
    );
  }

  Widget _doctorlist(int i) {
    return GestureDetector(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/BookAppointment');
        },
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
                  padding: EdgeInsets.all(screenWidth * 0.015),
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight * 0.12,
                        width: screenWidth * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.02),
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
                          child: Image.asset('images/doctor.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                //
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.03),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Book An Appointment',
                            style: TextStyle(
                                color: const Color.fromARGB(255, 236, 3, 3)),
                          ),
                          SizedBox(width: screenWidth * 0.01),
                          Icon(
                            Icons.arrow_forward,
                            color: const Color.fromARGB(255, 240, 6, 6),
                            size: screenWidth * 0.05,
                          )
                        ],
                      ),
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
