// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({super.key});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;
  int? _selectedTime;
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              'Book Appointment',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(width: 10),
            Text('      '),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //drinfo
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: Colors.white,
                  color: Color.fromARGB(223, 233, 249, 249),
                  boxShadow: [
                    BoxShadow(
                      color:
                          const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.33,
                      child: Image.asset('images/doctor.png'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.001),
                          child: Text(
                            'Dr Rajendra Khanal',
                            style: TextStyle(
                              fontSize: (screenWidth / 360) * 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.002),
                          child: Text(
                            'Cardiology',
                            style: TextStyle(
                                fontSize: (screenWidth / 360) * 16,
                                color: Colors.grey.shade800),
                            softWrap: true,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.005,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.002),
                          child: Text(
                            '12 yrs of Experience',
                            style: TextStyle(
                                fontSize: (screenWidth / 360) * 16,
                                color: Colors.grey.shade700),
                            softWrap: true,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.005,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            //exp
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: screenWidth * 0.05,
            //     vertical: screenHeight * 0.002,
            //   ),
            //   child: Container(
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       color: Color.fromARGB(255, 122, 231, 231),
            //     ),
            //     child: Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 8),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             'Qualification',
            //             style: TextStyle(
            //               fontSize: 18 * (screenWidth / 360),
            //             ),
            //           ),
            //           Text(
            //             'xxxxx xxxx xxxx',
            //             style: TextStyle(
            //               fontSize: 14 * (screenWidth / 360),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            //calendar
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.005),
              child: Text(
                'Select Date',
                style: TextStyle(
                  fontSize: 16 * (screenWidth / 360),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Container(
                color: Color.fromARGB(255, 206, 246, 245),
                child: TableCalendar(
                  firstDay: DateTime.now(),
                  lastDay: DateTime(2025),
                  focusedDay: _focusedDay,
                  headerStyle: HeaderStyle(
                    headerMargin: EdgeInsets.zero,
                    leftChevronIcon: Icon(Icons.arrow_back_ios),
                    rightChevronIcon: Icon(Icons.arrow_forward_ios),
                    formatButtonVisible: false,
                    titleCentered: true,
                    //  backgroundColor: Colors.blue,
                    // titleStyle: TextStyle(color: Colors.white),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 174, 230, 234),
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    rowDecoration: BoxDecoration(
                      color: Color.fromARGB(255, 206, 246, 245),
                    ),
                  ),
                  calendarFormat: CalendarFormat.month,
                  selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      // print(_selectedDay);
                    });
                  },
                  calendarBuilders: CalendarBuilders(
                    selectedBuilder: (context, date, _) => Container(
                      margin: EdgeInsets.all(screenWidth * 0.01),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 239, 92, 81),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${date.day}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //slots
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.02,
              ),
              child: Text(
                'Select Time',
                style: TextStyle(
                  fontSize: 16 * (screenWidth / 360),
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.023),
            //   child: SizedBox(
            //     child: SingleChildScrollView(
            //       scrollDirection: Axis.horizontal,
            //       child: Row(
            //         children: List<Widget>.generate(10, (i) {
            //           return Padding(
            //             padding: EdgeInsets.all(screenWidth * 0.02),
            //             child: GestureDetector(
            //               onTap: () {
            //                 setState(() {
            //                   _selectedTime = _selectedTime == i ? null : i;
            //                 });
            //               },
            //               child: Container(
            //                 height: screenHeight * 0.05,
            //                 width: screenWidth * 0.25,
            //                 decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(15),
            //                     color: _selectedTime == i
            //                         ? Color.fromARGB(255, 239, 75, 63)
            //                         : Color.fromARGB(255, 22, 189, 158)),
            //                 child: Center(
            //                     child: Text(
            //                   '10:00 AM',
            //                   style: TextStyle(color: Colors.white),
            //                 )),
            //               ),
            //             ),
            //           );
            //         }),
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.023),
              child: SizedBox(
                height: screenHeight * 0.2,
                child: Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  scrollbarOrientation: ScrollbarOrientation.right,
                  thickness: screenWidth * 0.015,
                  radius: Radius.circular(5),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.02,
                      right: screenWidth * 0.04,
                    ),
                    child: GridView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: screenWidth * 0.04,
                        mainAxisSpacing: screenHeight * 0.02,
                        childAspectRatio: 4.2 / 1.5,
                      ),
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedTime =
                                  _selectedTime == index ? null : index;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: _selectedTime == index
                                    ? Color.fromARGB(255, 239, 75, 63)
                                    : Color.fromARGB(255, 22, 189, 158)),
                            child: Center(
                                child: Text(
                              '10:00 AM',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            //confirm slot btn
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromRGBO(24, 97, 121, 0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                    fixedSize: Size(screenWidth * 0.5, screenHeight * 0.055),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/BookPayment');
                  },
                  child: Text(
                    'Book Appointment',
                    style: TextStyle(
                      fontSize: 12 * (screenWidth / 360),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
