// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:patient_ms/screen/appointment.screen.dart';

class DoctorList extends StatefulWidget {
  const DoctorList({super.key});

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  late TextEditingController searchController;
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Appointment()),
        );
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.09),
          child: AppBar(
            backgroundColor: const Color.fromRGBO(24, 97, 121, 0.8),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Appointment()),
                );
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Choosen Speciality',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 10), // Space between texts
                Text('      '),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //search
              Container(
                height: screenHeight * 0.055,
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenHeight * 0.02),
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
                height: screenHeight * 0.77,
                child: Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.02),
                  child: Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    scrollbarOrientation: ScrollbarOrientation.right,
                    thickness: 5,
                    radius: Radius.circular(5),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          for (int i = 0; i < 10; i++) _list(i),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _list(int i) {
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
                        'Dr. Doctor Name',
                        style: TextStyle(
                          color: Color.fromARGB(255, 3, 58, 80),
                          fontSize: 15 * (screenWidth / 360),
                        ),
                      ),
                      Text(
                        'Speciality',
                        style: TextStyle(
                          color: Color.fromARGB(255, 26, 30, 31),
                          fontSize: 13.5 * (screenWidth / 360),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Book An Appointment',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 236, 3, 3),
                              fontSize: 12.5 * (screenWidth / 360),
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward,
                            color: const Color.fromARGB(255, 240, 6, 6),
                            size: screenWidth * 0.045,
                          ),
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
