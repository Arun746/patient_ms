// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient_ms/model/doctor.model.dart';
import 'package:patient_ms/model/speciality.model.dart';
import 'package:patient_ms/screen/bookappointment.screen.dart';
import 'package:patient_ms/screen/doctorslist.screen.dart';
import 'package:patient_ms/services/doctor.service.dart';
import 'package:patient_ms/services/speciality.services.dart';

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
  late TextEditingController docSearchController;
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;
  final ScrollController _scrollController = ScrollController();
  final ScrollController _dscrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    searchController = TextEditingController();
    docSearchController = TextEditingController();
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
    searchController.dispose();
    docSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabController.animateTo(currentTabIndex);
    // final statusbarHeight = MediaQuery.of(context).padding.top;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/Home');
        return false;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight * 0.15),
            child: AppBar(
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
                title: SizedBox(
                  height: screenHeight * 0.05,
                  child: TabBar(
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
                      height: screenHeight * 0.055,
                      margin: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.03,
                          vertical: screenHeight * 0.005),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 221, 234, 238),
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: (query) {
                          setState(() {
                            searchController.text = query;
                          });
                        },
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
                    FutureBuilder<List<SpecialityDt>>(
                        future: SpecialityService.getData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<SpecialityDt>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.02),
                                    child: const Text('Loading...'),
                                  ),
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.02),
                              child: Text(
                                '${snapshot.error}.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13 * (screenWidth / 360),
                                ),
                              ),
                            );
                          } else {
                            List<SpecialityDt> filteredData = snapshot.data!
                                .where((item) => item.detail
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                        searchController.text.toLowerCase()))
                                .toList();

                            if (filteredData.isEmpty) {
                              return Padding(
                                padding:
                                    EdgeInsets.only(top: screenHeight * 0.03),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height: screenHeight * 0.3,
                                        child: Image.asset(
                                          'images/noresult.png',
                                          fit: BoxFit.fill,
                                        )),
                                    Text(
                                      'Sorry! No Data Found',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14 * (screenWidth / 360),
                                        color: Colors.red.shade500,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return SizedBox(
                                height: screenHeight * 0.67,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: screenWidth * 0.02),
                                  child: Scrollbar(
                                    controller: _scrollController,
                                    thumbVisibility: true,
                                    scrollbarOrientation:
                                        ScrollbarOrientation.right,
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
                                          crossAxisSpacing: screenWidth * 0.05,
                                          mainAxisSpacing: screenHeight * 0.01,
                                        ),
                                        itemCount: filteredData.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.all(
                                                screenWidth * 0.02),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                                DoctorList(
                                                                  spId: filteredData[
                                                                          index]
                                                                      .spId,
                                                                  detail: filteredData[
                                                                          index]
                                                                      .detail,
                                                                )));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          screenWidth * 0.03),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                      offset: Offset(1, 1),
                                                      spreadRadius: 2,
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      screenWidth * 0.01),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        height: screenHeight *
                                                            0.052,
                                                        child: FadeInImage(
                                                          placeholder: AssetImage(
                                                              'images/speciality/non.png'),
                                                          image: AssetImage(
                                                              'images/speciality/${filteredData[index].spId}.png'),
                                                          fit: BoxFit.fill,
                                                          imageErrorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return Image.asset(
                                                                'images/speciality/non.png');
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: screenHeight *
                                                            0.005,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          filteredData[index]
                                                                      .detail ==
                                                                  ""
                                                              ? "N/A"
                                                              : filteredData[
                                                                      index]
                                                                  .detail
                                                                  .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(),
                                                        ),
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
                              );
                            }
                          }
                        })
                  ],
                ),
              ),
              //doctors
              SingleChildScrollView(
                child: Column(
                  children: [
                    //search
                    Container(
                      height: screenHeight * 0.055,
                      margin: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.03,
                          vertical: screenHeight * 0.005),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 221, 234, 238),
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      ),
                      child: TextField(
                        controller: docSearchController,
                        onChanged: (query) {
                          docSearchController.text = query;
                        },
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
                    FutureBuilder<List<DoctorDt>>(
                        future: DoctorService.getData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<DoctorDt>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.02),
                                    child: const Text('Loading...'),
                                  ),
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.02),
                              child: Text(
                                '${snapshot.error}.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13 * (screenWidth / 360),
                                ),
                              ),
                            );
                          } else {
                            List<DoctorDt> filteredData = snapshot.data!
                                .where((item) => item.referer
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                        docSearchController.text.toLowerCase()))
                                .toList();

                            if (filteredData.isEmpty) {
                              return Padding(
                                padding:
                                    EdgeInsets.only(top: screenHeight * 0.03),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height: screenHeight * 0.3,
                                        child: Image.asset(
                                          'images/noresult.png',
                                          fit: BoxFit.fill,
                                        )),
                                    Text(
                                      'Sorry! No Data Found',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14 * (screenWidth / 360),
                                        color: Colors.red.shade500,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return SizedBox(
                                height: screenHeight * 0.67,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: screenWidth * 0.02),
                                  child: Scrollbar(
                                    controller: _dscrollController,
                                    thumbVisibility: true,
                                    scrollbarOrientation:
                                        ScrollbarOrientation.right,
                                    thickness: 5,
                                    radius: Radius.circular(5),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.02),
                                      child: ListView.builder(
                                        controller: _dscrollController,
                                        itemCount: filteredData.length,
                                        itemBuilder: (context, index) {
                                          final data = filteredData[index];
                                          return _doctorlist(data);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          }
                        })
                  ],
                ),
              ),
            ],
          ),
          //bottomnavbar
          bottomNavigationBar: SizedBox(
            height: screenHeight * 0.08,
            child: BottomNavigationBar(
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
      ),
    );
  }

  Widget _doctorlist(DoctorDt data) {
    return GestureDetector(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BookAppointment(docData: data)));
        },
        child: ListTile(
          title: Container(
            // height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.35),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.017),
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
                  padding: EdgeInsets.only(left: screenWidth * 0.025),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.referer.toString(),
                        style: TextStyle(
                            color: Color.fromARGB(255, 3, 58, 80),
                            fontSize: 14 * (screenWidth / 360)),
                      ),
                      Text(
                        data.qualification.toString(),
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
                              color: const Color.fromARGB(255, 236, 3, 3),
                              fontSize: 13 * (screenWidth / 360),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.01),
                          Icon(
                            Icons.arrow_forward,
                            color: const Color.fromARGB(255, 240, 6, 6),
                            size: screenWidth * 0.045,
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
