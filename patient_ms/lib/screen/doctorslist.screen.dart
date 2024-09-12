// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient_ms/model/doctor.model.dart';
import 'package:patient_ms/screen/bookappointment.screen.dart';
import 'package:patient_ms/services/doctor.service.dart';

class DoctorList extends StatefulWidget {
  final int? spId;
  final String? detail;
  const DoctorList({super.key, required this.spId, required this.detail});

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
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
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
                Navigator.pop(context);
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.detail.toString(),
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
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenWidth * 0.02,
                ),
                child: Container(
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
                      searchController.text = query;
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
              ),
              //dlist
              FutureBuilder<List<DoctorDt>>(
                  future: DoctorService.getData(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<DoctorDt>> snapshot) {
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
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.02),
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
                      List<DoctorDt> filteredData = snapshot.data!
                          .where((item) =>
                              item.spId == widget.spId &&
                              item.referer.toString().toLowerCase().contains(
                                  searchController.text.toLowerCase()))
                          .toList();

                      if (filteredData.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.03),
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
                          height: screenHeight * 0.77,
                          child: Padding(
                            padding: EdgeInsets.only(right: screenWidth * 0.02),
                            child: Scrollbar(
                              controller: _scrollController,
                              thumbVisibility: true,
                              scrollbarOrientation: ScrollbarOrientation.right,
                              thickness: 5,
                              radius: Radius.circular(5),
                              child: ListView.builder(
                                controller: _scrollController,
                                itemCount: filteredData.length,
                                itemBuilder: (context, index) {
                                  final data = filteredData[index];
                                  return _doctorlist(data);
                                },
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
