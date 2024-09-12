// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:patient_ms/model/doctor.model.dart';
import 'package:patient_ms/services/appointment.service.dart';

class BookConfirm extends StatefulWidget {
  final DoctorDt docData;
  final String date;
  final String time;

  const BookConfirm({
    super.key,
    required this.docData,
    required this.date,
    required this.time,
  });

  @override
  State<BookConfirm> createState() => _BookConfirmState();
}

class _BookConfirmState extends State<BookConfirm> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;
  int? _paymenttype = 1;
  String? tDes = "am";

  @override
  void initState() {
    super.initState();
    if (int.parse(widget.time.split(":").first) > 12) {
      tDes = "pm";
    }
  }

  Future<void> postData() async {
    try {
      context.loaderOverlay.show();
      bool orderSuccess = await AppointmentService.postAppointment(
        widget.date.toString(),
        widget.time.toString(),
      );

      if (orderSuccess) {
        context.loaderOverlay.hide();

        Navigator.pushNamedAndRemoveUntil(
            context, '/Home', (Route<dynamic> route) => false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Appointment Booked !',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        context.loaderOverlay.hide();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Order Error',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1),
          ),
        );
      }
      context.loaderOverlay.hide();
    } catch (e) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'An error occurred: $e',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                'Confirm Appointment',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 10),
              Text('      '),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
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
                              widget.docData.referer.toString(),
                              style: GoogleFonts.karma(
                                fontSize: (screenWidth / 360) * 18,
                                color: Color.fromARGB(255, 98, 40, 108),
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
                                  color: Colors.grey.shade500),
                              softWrap: true,
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.001),
                            child: Row(
                              children: [
                                Text(
                                  'Appointment Date',
                                  style: TextStyle(
                                    fontSize: (screenWidth / 360) * 15,
                                    color: Color.fromRGBO(143, 59, 16, 1),
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.02,
                                ),
                                Icon(
                                  Icons.av_timer_rounded,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.002),
                            child: Text(
                              '${widget.date.toString().split(' ').first} -- ${widget.time} $tDes ',
                              style: TextStyle(
                                  fontSize: (screenWidth / 360) * 14,
                                  color: Color.fromARGB(255, 28, 154, 156)),
                              softWrap: true,
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              //pinfo
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
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
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight * 0.02,
                              left: screenWidth * 0.015,
                              bottom: screenHeight * 0.015),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Patient Information',
                              style: GoogleFonts.poppins(
                                  fontSize: 17 * (screenWidth / 360),
                                  color: Color.fromARGB(255, 86, 83, 83)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.004,
                              horizontal: screenWidth * 0.015),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Name',
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 14 * (screenWidth / 360),
                                  // fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Nitish Kumar',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 60, 136, 222),
                                  fontSize: 15 * (screenWidth / 360),
                                  // fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.004,
                              horizontal: screenWidth * 0.015),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Address',
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 14 * (screenWidth / 360),
                                  // fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Kathmandu',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 60, 136, 222),
                                  fontSize: 15 * (screenWidth / 360),
                                  // fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.004,
                              horizontal: screenWidth * 0.015),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Gender',
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 14 * (screenWidth / 360),
                                  // fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Male',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 60, 136, 222),
                                  fontSize: 15 * (screenWidth / 360),
                                  // fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.004,
                              horizontal: screenWidth * 0.015),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Contact',
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 14 * (screenWidth / 360),
                                  // fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '9879876543',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 60, 136, 222),
                                  fontSize: 15 * (screenWidth / 360),
                                  // fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: screenHeight * 0.004,
                            bottom: screenHeight * 0.015,
                            left: screenWidth * 0.015,
                            right: screenWidth * 0.015,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'DoB',
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 14 * (screenWidth / 360),
                                  // fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '1997/05/02',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 60, 136, 222),
                                  fontSize: 15 * (screenWidth / 360),
                                  // fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //pamnt
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.04,
                  right: screenWidth * 0.04,
                  top: screenHeight * 0.02,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.02,
                      vertical: screenHeight * 0.02,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Payment Information',
                            style: GoogleFonts.poppins(
                                fontSize: 17 * (screenWidth / 360),
                                color: Color.fromARGB(255, 86, 83, 83)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.004,
                              horizontal: screenWidth * 0.015),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Amount',
                                    style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 14 * (screenWidth / 360),
                                      // fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    'Rs. 500 ',
                                    style: GoogleFonts.poppins(
                                        fontSize: 15 * (screenWidth / 360),
                                        color:
                                            Color.fromARGB(255, 240, 49, 49)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 0.005,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Discount',
                                    style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 14 * (screenWidth / 360),
                                      // fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    ' 0 %',
                                    style: GoogleFonts.poppins(
                                        fontSize: 15 * (screenWidth / 360),
                                        color:
                                            Color.fromARGB(255, 240, 49, 49)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 0.005,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 14 * (screenWidth / 360),
                                      // fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    'Rs. 500 ',
                                    style: GoogleFonts.poppins(
                                        fontSize: 15 * (screenWidth / 360),
                                        color:
                                            Color.fromARGB(255, 240, 49, 49)),
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
              //payment
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.02,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.02,
                      vertical: screenHeight * 0.02,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Choose Payment Method',
                            style: GoogleFonts.poppins(
                                fontSize: 17 * (screenWidth / 360),
                                color: Color.fromARGB(255, 86, 83, 83)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: screenWidth * 0.0015,
                            right: screenWidth * 0.0015,
                            top: screenHeight * 0.01,
                          ),
                          child: Column(
                            children: [
                              Row(children: [
                                //
                                Radio<int>(
                                  value: 1,
                                  groupValue: _paymenttype,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _paymenttype = value;
                                    });
                                  },
                                ),
                                //
                                SizedBox(
                                  height: 70,
                                  width: 250,
                                  child: Image.asset('images/esewa.png'),
                                )
                              ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(204, 239, 34, 34),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: Size(screenWidth * 0.6, screenHeight * 0.06),
                  ),
                  onPressed: () {
                    postData();
                  },
                  child: const Text('Pay Now'),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
