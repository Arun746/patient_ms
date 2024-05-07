// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({super.key});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;

  // DatePicker() {
  //   showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2025),
  //   ).then((pickedDate) {
  //     if (pickedDate != null) {
  //       print('Picked date: $pickedDate');
  //     }
  //   });
  // }

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
            SizedBox(width: 10), // Space between texts
            Text('      '),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //heading
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.002),
                        child: Text(
                          'Dr. Binod Kumar Nepal',
                          style: GoogleFonts.courgette(
                              fontSize: 18 * (screenWidth / 360)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.002),
                        child: Text(
                          'Cardiologist',
                          style: GoogleFonts.nunito(
                              fontSize: 16 * (screenWidth / 360)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.002),
                        child: Text(
                          '12 Years Of Experience',
                          style: TextStyle(
                            fontSize: 14 * (screenWidth / 360),
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.3,
                        child: Image.asset('images/profile.png'),
                      )
                    ],
                  )
                ],
              ),
            ),
            //divider
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Divider(
                color: const Color.fromRGBO(24, 97, 121, 0.8),
              ),
            ),
            //exp
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.002,
              ),
              child: Text(
                'Qualification',
                style: TextStyle(
                  fontSize: 18 * (screenWidth / 360),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.002,
              ),
              child: Text(
                'XXXXXXX XXXXXXXX XXXXXXXX',
                style: TextStyle(
                  fontSize: 14 * (screenWidth / 360),
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            //divider
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Divider(
                color: const Color.fromRGBO(24, 97, 121, 0.8),
              ),
            ),
            //calendar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
              ),
              child: Text(
                'Select Date',
                style: TextStyle(
                  fontSize: 16 * (screenWidth / 360),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: SizedBox(
                child: TableCalendar(
                  firstDay: DateTime.now(),
                  lastDay: DateTime.now().add(Duration(days: 7)),
                  focusedDay: DateTime.now(),
                  headerStyle: HeaderStyle(
                    headerMargin: EdgeInsets.zero,
                    leftChevronIcon: Icon(Icons.arrow_back_ios),
                    rightChevronIcon: Icon(Icons.arrow_forward_ios),
                    formatButtonVisible: false,
                  ),
                  calendarFormat: CalendarFormat.month,
                  // calendarBuilders: CalendarBuilders(
                  //   selectedBuilder: (context, date, _) {
                  //     return Container(
                  //       margin: EdgeInsets.all(2.0),
                  //       padding: EdgeInsets.all(3.0),
                  //       decoration: BoxDecoration(
                  //         color: Colors.blue,
                  //         borderRadius: BorderRadius.circular(8.0),
                  //       ),
                  //       child: Text(
                  //         '${date.day}',
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 16.0,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List<Widget>.generate(10, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: screenHeight * 0.05,
                            width: screenWidth * 0.25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color.fromARGB(204, 75, 186, 173),
                            ),
                            child: Center(
                                child: Text(
                              '10:00 AM',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
            //confirm slot btn
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromRGBO(24, 97, 121, 0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {},
                  child: Text('Confirm Date & Time'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
