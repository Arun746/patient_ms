import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient_ms/model/hospital.model.dart';
import 'package:patient_ms/services/hospital.service.dart';

class HospitalList extends StatefulWidget {
  const HospitalList({super.key});

  @override
  State<HospitalList> createState() => _HospitalListState();
}

class _HospitalListState extends State<HospitalList>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 2;
  late TabController _tabController;
  int currentTabIndex = 0;
  late TextEditingController searchController;
  late TextEditingController docSearchController;
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;

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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/Home');
        return false;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight * 0.08),
            child: AppBar(
              backgroundColor: const Color.fromRGBO(24, 97, 121, 0.8),
              automaticallyImplyLeading: false,
              title: Center(
                child: Text(
                  'Hospital List',
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
                      hintText: 'Search  hospitals  here',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                //specialities
                FutureBuilder<List<HospitalDt>>(
                    future: HospitalService.getData(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<HospitalDt>> snapshot) {
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
                        List<HospitalDt> filteredData = snapshot.data!
                            .where((item) => item.hospitalName
                                .toString()
                                .toLowerCase()
                                .contains(searchController.text.toLowerCase()))
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
                            height: screenHeight * 0.67,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(right: screenWidth * 0.02),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.02),
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: screenWidth * 0.05,
                                    mainAxisSpacing: screenHeight * 0.01,
                                  ),
                                  itemCount: filteredData.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.all(screenWidth * 0.02),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
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
                                                  height: screenHeight * 0.052,
                                                  child: FadeInImage(
                                                    placeholder: AssetImage(
                                                        'images/speciality/non.png'),
                                                    image: AssetImage(
                                                        'images/speciality/.png'),
                                                    fit: BoxFit.fill,
                                                    imageErrorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                          'images/speciality/non.png');
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: screenHeight * 0.005,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    filteredData[index]
                                                                .hospitalName ==
                                                            ""
                                                        ? "N/A"
                                                        : filteredData[index]
                                                            .hospitalName
                                                            .toString(),
                                                    textAlign: TextAlign.center,
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
                          );
                        }
                      }
                    })
              ],
            ),
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
}
