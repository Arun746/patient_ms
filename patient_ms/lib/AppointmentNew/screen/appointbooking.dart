import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:patient_ms/AppointmentNew/model/datemodel.dart';
import 'package:patient_ms/AppointmentNew/model/department.model.dart';
import 'package:patient_ms/AppointmentNew/services/appointment.service.dart';
import 'package:patient_ms/AppointmentNew/services/dateservice.dart';
import 'package:patient_ms/AppointmentNew/services/department.service.dart';
import 'package:patient_ms/AppointmentNew/services/insurance.service.dart';
import 'package:patient_ms/config/config.dart';
import 'package:patient_ms/profile/profile.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentBookingPage extends StatefulWidget {
  const AppointmentBookingPage({super.key});

  @override
  State<AppointmentBookingPage> createState() => _AppointmentBookingPageState();
}

class _AppointmentBookingPageState extends State<AppointmentBookingPage> {
  final _formKey = GlobalKey<FormState>();
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;
  int? _registrationType;
  int? _gender;
  int? patientid;
  String _userId = '';
  bool? eligible;
  final TextEditingController _address = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _bima = TextEditingController();
  final TextEditingController _remarks = TextEditingController();

  List<DateDt> _dateList = [];
  String? _selectedDate;
  Future<void> _fetchAndStoreData() async {
    final data = await DateService.getData();
    setState(() {
      _dateList = data;
    });
  }

  List<DepartmentDt> _departList = [];
  String? _selectedDepart;
  String? _selectedTime;

  Future<void> _fetchdepart() async {
    final data = await DepartmentService.getData();
    setState(() {
      _departList = data;
    });
  }

  void _checkeligiblity() async {
    String bimano = _bima.text;

    final eligibilityData =
        await InsuranceService.getEligibility(bimano, _userId);
    if (eligibilityData.statusCode == 200) {
      setState(() {
        eligible == true;
        print("user is eligible");
      });
    }
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString('userid') ?? '';
      // print(_userId);
    });
  }

//postappointment
  Future<void> postAppointment() async {
    int? dpid = int.tryParse(_selectedDepart ?? '');
    try {
      context.loaderOverlay.show();
      bool appointmentsuccess = await NewAppointmentService.postAppointment(
        _selectedDate!,
        _selectedTime!,
        dpid!,
        _remarks.text,
        _registrationType == 1 ? true : false,
        _registrationType == 2 ? true : false,
        _registrationType == 3 ? true : false,
        patientid!,
      );

      if (appointmentsuccess) {
        context.loaderOverlay.hide();

        Navigator.pushNamedAndRemoveUntil(
            context, '/Home', (Route<dynamic> route) => false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Appointment Confirmed ! We will reach to you soon .',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        context.loaderOverlay.hide();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Error Posting Appointment ',
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
        const SnackBar(
          content: Text(
            'An error occurred: Check all form field !',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  void initState() {
    _registrationType = 1;
    _fetchdepart();
    _fetchAndStoreData();
    _loadUserId();
    // _checkeligiblity();
    getSelectedPatientData().then((data) {
      setState(() {
        _bima.text = data['bimano'] ?? '';
        _address.text = data['address'] ?? '';
        _name.text = data['fullName'] ?? '';
        _email.text = data['email'] ?? '';
        _number.text = data['contactNumber'] ?? '';
        _dob.text =
            DateFormat('yyyy-MM-dd').format(DateTime.parse(data['dob'] ?? ''));
        data['pgender'] == 'male'
            ? _gender = 1
            : data['pgender'] == 'female'
                ? _gender = 2
                : _gender = 3;
        patientid = data["patientid"];
      });
    });
    super.initState();
  }

  PatientInfoDt deserializePatient(String json) =>
      PatientInfoDt.fromJson(jsonDecode(json));

  Future<Map<String, dynamic>> getSelectedPatientData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? serializedPatient = prefs.getString('selected_patient_data');
    if (serializedPatient != null) {
      PatientInfoDt patient = deserializePatient(serializedPatient);
      return {
        'fullName': patient.pname,
        'email': patient.email,
        'address': patient.address,
        'contactNumber': patient.telephone,
        'dob': patient.dob,
        'pgender': patient.gender,
        'bimano': patient.policyid,
        'patientid': patient.id,
      };
    }
    return {};
  }

//time
  void _selectTime(BuildContext context) async {
    final timePickerResult = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
      helpText: 'Select time',
      cancelText: 'Cancel',
      errorInvalidText: 'Please enter a valid time',
    );

    if (timePickerResult != null) {
      setState(() {
        _selectedTime =
            '${timePickerResult.hour.toString().padLeft(2, '0')}:${timePickerResult.minute.toString().padLeft(2, '0')} ${timePickerResult.period == DayPeriod.am ? 'AM' : 'PM'}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        // backgroundColor: Color.fromARGB(255, 236, 243, 250),
        appBar: AppBar(
          backgroundColor: Config.primarythemeColor,
          foregroundColor: Colors.white,
          title: const Center(
              child: Text(
            'Appointment Booking',
            style: TextStyle(color: Colors.white),
          )),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //img
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.01,
                    bottom: screenHeight * 0.01,
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Image.asset(
                          'images/full_team.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: screenHeight * 0.003,
                        left: screenWidth * 0.13,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.09,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            color: Color.fromARGB(255, 202, 218, 252),
                          ),
                          child: Image.asset(
                            'images/hosp_name.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //dept
                      Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.03,
                            bottom: screenHeight * 0.01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select Department',
                              style: TextStyle(
                                fontSize: 14 * (screenWidth / 360),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.075,
                              child: DropdownButtonFormField<String>(
                                value: _selectedDepart,
                                hint: const Text('Select department'),
                                isExpanded: true,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: _departList.map((item) {
                                  return DropdownMenuItem(
                                    value: item.grpid.toString(),
                                    child: Text(item.groupname.toString()),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedDepart = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      //appdate
                      Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.03,
                            bottom: screenHeight * 0.01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select Appointment Date',
                              style: TextStyle(
                                fontSize: 14 * (screenWidth / 360),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.075,
                              child: DropdownButtonFormField<String>(
                                value: _selectedDate,
                                hint: const Text('Select date'),
                                isExpanded: true,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: _dateList.map((item) {
                                  return DropdownMenuItem(
                                    value: item.adDate.toString(),
                                    child: Text(item.adDate
                                        .toString()
                                        .substring(0, 10)),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedDate = value;
                                    print(_selectedDate);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      //time
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select Time',
                              style: TextStyle(
                                fontSize: 14 * (screenWidth / 360),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // SizedBox(
                            //   width: screenWidth * 0.02,
                            // ),
                            GestureDetector(
                              onTap: () => _selectTime(context),
                              child: Container(
                                // width: screenWidth * 0.71,
                                height: screenHeight * 0.07,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidth * 0.037),
                                      child: Text(
                                        _selectedTime ?? "Select time",
                                        style: TextStyle(
                                            fontSize: (screenWidth * 13 / 360),
                                            fontWeight: FontWeight.w400),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: screenWidth * 0.04),
                                      child: const Icon(Icons.timer_outlined),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // TimePickerFormField(
                            //   width: MediaQuery.of(context).size.width * 0.35,
                            //   height: 200,
                            //   oldValue: _selectedTime ?? '',
                            //   onChanged: (String newValue) {
                            //     setState(() {
                            //       _selectedTime = newValue;
                            //     });
                            //   },
                            // ),
                          ],
                        ),
                      ),
                      //regtype
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        child: Container(
                          width: screenWidth * 0.97,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 240, 247, 247),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 3),
                              )
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(screenWidth * 0.02),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Registration Type',
                                  style: TextStyle(
                                    fontSize: 15 * (screenWidth / 360),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Radio<int>(
                                      value: 1,
                                      groupValue: _registrationType,
                                      onChanged: (int? value) {
                                        setState(() {
                                          _registrationType = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Normal',
                                      style: TextStyle(
                                        fontSize: 13 * (screenWidth / 360),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.05),
                                    Radio<int>(
                                      value: 2,
                                      groupValue: _registrationType,
                                      onChanged: (int? value) {
                                        setState(() {
                                          _bima.text.isEmpty
                                              ? ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                  const SnackBar(
                                                    backgroundColor: Colors.red,
                                                    duration:
                                                        Duration(seconds: 1),
                                                    content: Text(
                                                      'You are not eligible as your profile do not have Bima ID !',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                )
                                              : _registrationType = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Insurance',
                                      style: TextStyle(
                                        fontSize: 13 * (screenWidth / 360),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.06),
                                    Radio<int>(
                                      value: 3,
                                      groupValue: _registrationType,
                                      onChanged: (int? value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor: Colors.red,
                                            duration: Duration(seconds: 1),
                                            content: Text(
                                              'This feature will be available soon !',
                                              style: TextStyle(
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Text(
                                      'SSF',
                                      style: TextStyle(
                                        fontSize: 13 * (screenWidth / 360),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      _registrationType == 1
                          ? _formdetails()

                          // Insurance form fields
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bima No',
                                  style: TextStyle(
                                    fontSize: 14 * (screenWidth / 360),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.075,
                                  child: TextFormField(
                                    controller: _bima,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      // hintText: 'Add bima no from profile',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ),
                                // Text(
                                //   'Scheme Name',
                                //   style: TextStyle(
                                //     fontSize: 14 * (screenWidth / 360),
                                //     fontWeight: FontWeight.w500,
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: screenHeight * 0.075,
                                //   child: DropdownButtonFormField<String>(
                                //     menuMaxHeight: screenHeight * 0.5,
                                //     borderRadius: BorderRadius.circular(10),
                                //     value: _selectedValue,
                                //     onChanged: (String? newValue) {
                                //       setState(() {
                                //         _selectedValue = newValue;
                                //       });
                                //     },
                                //     items: departmentMap.entries.map((entry) {
                                //       return DropdownMenuItem<String>(
                                //         alignment: Alignment.centerLeft,
                                //         value: entry.key.toString(),
                                //         child: Text(entry.value),
                                //       );
                                //     }).toList(),
                                //     decoration: InputDecoration(
                                //       border: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(10),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // // SizedBox(
                                //   //   height: screenHeight * 0.02,
                                //   // ),
                                //   // Text(
                                //   //   'Scheme Prod.',
                                //   //   style: TextStyle(
                                //   //     fontSize: 14 * (screenWidth / 360),
                                //   //     fontWeight: FontWeight.w500,
                                //   //   ),
                                //   // ),
                                //   // SizedBox(
                                //   //   height: screenHeight * 0.075,
                                //   //   child: DropdownButtonFormField<String>(
                                //   //     menuMaxHeight: screenHeight * 0.5,
                                //   //     borderRadius: BorderRadius.circular(10),
                                //   //     value: _selectedValue,
                                //   //     onChanged: (String? newValue) {
                                //   //       setState(() {
                                //   //         _selectedValue = newValue;
                                //   //       });
                                //   //     },
                                //   //     items: departmentMap.entries.map((entry) {
                                //   //       return DropdownMenuItem<String>(
                                //   //         alignment: Alignment.centerLeft,
                                //   //         value: entry.key.toString(),
                                //   //         child: Text(entry.value),
                                //   //       );
                                //   //     }).toList(),
                                //   //     decoration: InputDecoration(
                                //   //       border: OutlineInputBorder(
                                //   //         borderRadius: BorderRadius.circular(10),
                                //   //       ),
                                //   //     ),
                                //   //   ),
                                //   // ),
                                //   // SizedBox(
                                //   height: screenHeight * 0.02,
                                // ),
                                _formdetails(),
                              ],
                            ),

                      SizedBox(
                        height: screenHeight * 0.02,
                      ),

                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              postAppointment();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Config.primarythemeColor,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.05),
                            ),
                            minimumSize:
                                Size(screenWidth * 0.2, screenHeight * 0.05),
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.15),
                            elevation: 5,
                          ),
                          child: const Text('Book Appointment'),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
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

  Widget _formdetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Full Name',
          style: TextStyle(
            fontSize: 14 * (screenWidth / 360),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.075,
          child: TextFormField(
            readOnly: true,
            controller: _name,
            decoration: InputDecoration(
              filled: true,
              // fillColor: Colors.grey,
              // hintText: 'enter your full name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter name';
              }
              return null;
            },
          ),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Text(
          'Email',
          style: TextStyle(
            fontSize: 14 * (screenWidth / 360),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.075,
          child: TextFormField(
            controller: _email,
            decoration: InputDecoration(
              // hintText: 'enter your email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter email';
              }
              return null;
            },
          ),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Text(
          'Address',
          style: TextStyle(
            fontSize: 14 * (screenWidth / 360),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.075,
          child: TextFormField(
            controller: _address,
            readOnly: true,
            decoration: InputDecoration(
              filled: true,
              hintText: 'enter your address',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter address';
              }
              return null;
            },
          ),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Text(
          'Contact Number',
          style: TextStyle(
            fontSize: 14 * (screenWidth / 360),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.075,
          child: TextFormField(
            controller: _number,
            decoration: InputDecoration(
              hintText: 'enter your contact number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your number';
              }
              return null;
            },
          ),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Text(
          'Date of Birth',
          style: TextStyle(
            fontSize: 14 * (screenWidth / 360),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.075,
          child: TextFormField(
            readOnly: true,
            controller: _dob,
            decoration: InputDecoration(
              filled: true,
              hintText: 'enter your dob',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a dob';
              }
              return null;
            },
          ),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select  Gender',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14 * (screenWidth / 360),
              ),
            ),
            Row(
              children: [
                Radio<int>(
                  value: 1,
                  groupValue: _gender,
                  onChanged: (value) {},
                ),
                Text(
                  'Male',
                  style: TextStyle(
                    fontSize: 13 * (screenWidth / 360),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: screenWidth * 0.1),
                Radio<int>(
                  value: 2,
                  groupValue: _gender,
                  onChanged: (int? value) {
                    // setState(() {
                    //   _gender = value;
                    // });
                  },
                ),
                Text(
                  'Female',
                  style: TextStyle(
                    fontSize: 13 * (screenWidth / 360),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: screenWidth * 0.1),
                Radio<int>(
                  value: 3,
                  groupValue: _gender,
                  onChanged: (int? value) {
                    // setState(() {
                    //   _gender = value;
                    // });
                  },
                ),
                Text(
                  'Others',
                  style: TextStyle(
                    fontSize: 13 * (screenWidth / 360),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          'Remarks',
          style: TextStyle(
            fontSize: 14 * (screenWidth / 360),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          // height: screenHeight * 0.075,
          child: TextFormField(
            controller: _remarks,
            maxLines: 4,
            minLines: 2,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              hintText: 'Enter subject to appointment',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter remarks';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _address.dispose();
    _name.dispose();
    _email.dispose();
    _number.dispose();
    _dob.dispose();
    _bima.dispose();
    _remarks.dispose();
  }
}
