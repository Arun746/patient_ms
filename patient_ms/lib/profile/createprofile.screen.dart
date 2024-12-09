import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:patient_ms/AppointmentNew/services/insurance.service.dart';
import 'package:patient_ms/config/config.dart';
import 'package:patient_ms/profile/profile.service.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bimaNo = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _contactNo = TextEditingController();
  final TextEditingController _dob = TextEditingController();

  int? _gender;
  int? _fieldstatus;
  @override
  void initState() {
    super.initState();
    _gender = 1;
    _fieldstatus = 0;
  }

//postbima
  Future<void> bima() async {
    try {
      final insuranceService = InsuranceService();
      final bimaDetails = await insuranceService.fetchBimaDetails(
        _bimaNo.text.toString(),
      );

      setState(() {
        _fieldstatus = 1;
        _name.text = "${bimaDetails.first.given} ${bimaDetails.first.family}";
        _address.text = bimaDetails.first.address.toString();
        _email.text = bimaDetails.first.email.toString();
        _contactNo.text = bimaDetails.first.telephone.toString();
        _dob.text = bimaDetails.first.birthdate.toString();
        _gender = bimaDetails.first.gender == "male"
            ? 1
            : bimaDetails.first.gender == "female"
                ? 2
                : 3;
      });
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  InputDecoration _getInputDecoration() {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade500),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Config.primarythemeColor),
      ),
    );
  }

//postappointment
  Future<void> postProfile() async {
    try {
      context.loaderOverlay.show();
      final response = await ProfileService.postProfile(
        _bimaNo.text,
        _name.text,
        _address.text,
        _email.text,
        _contactNo.text,
        _dob.text,
        _gender == 1
            ? "male"
            : _gender == 2
                ? "female"
                : "others",
      );

      context.loaderOverlay.hide();

      if (response['success']) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/SelectUser', (Route<dynamic> route) => false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Profile Created Successfully !!',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response['message'],
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'An error occurred: ${e.toString()}',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  void dispose() {
    _bimaNo.dispose();
    _name.dispose();
    _address.dispose();
    _email.dispose();
    _contactNo.dispose();
    _dob.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Config.primarythemeColor,
          foregroundColor: Colors.white,
          title: const Text(
            'Create Profile ',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bima No',
                  style: TextStyle(
                    fontSize: 14 * (screenWidth / 360),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: screenHeight * 0.001),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: screenHeight * 0.075,
                        child: TextFormField(
                          controller: _bimaNo,
                          readOnly: _fieldstatus == 1 ? true : false,
                          keyboardType: TextInputType.phone,
                          decoration: _getInputDecoration().copyWith(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.08,
                      child: InkWell(
                        onTap: () async {
                          bima();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.01,
                              horizontal: screenWidth * 0.04),
                          child: Icon(
                            color: Config.primarythemeColor,
                            Icons.post_add,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),

                // Full Name field
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Full Name ',
                        style: TextStyle(
                          fontSize: 14 * (screenWidth / 360),
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                          fontSize: 14 * (screenWidth / 360),
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.001),
                SizedBox(
                  height: screenHeight * 0.075,
                  child: TextFormField(
                    controller: _name,
                    readOnly: _fieldstatus == 1 ? true : false,
                    decoration: _getInputDecoration().copyWith(
                        // filled: true,
                        // fillColor: Color.fromARGB(255, 231, 240, 242),
                        ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),

                // Address field
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Address',
                        style: TextStyle(
                          fontSize: 14 * (screenWidth / 360),
                          fontWeight: FontWeight.w500,
                          color: Colors.black, // or your default text color
                        ),
                      ),
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                          fontSize: 14 * (screenWidth / 360),
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.001),
                SizedBox(
                  height: screenHeight * 0.075,
                  child: TextFormField(
                    readOnly: _fieldstatus == 1 ? true : false,
                    controller: _address,
                    decoration: _getInputDecoration().copyWith(
                        // filled: true,
                        // fillColor: Color.fromARGB(255, 231, 240, 242),
                        ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter address';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),

                // Email field
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Email',
                        style: TextStyle(
                          fontSize: 14 * (screenWidth / 360),
                          fontWeight: FontWeight.w500,
                          color: Colors.black, // or your default text color
                        ),
                      ),
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                          fontSize: 14 * (screenWidth / 360),
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.001),
                SizedBox(
                  height: screenHeight * 0.075,
                  child: TextFormField(
                    readOnly: _fieldstatus == 1 ? true : false,
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _getInputDecoration().copyWith(
                        // filled: true,
                        // fillColor: Color.fromARGB(255, 231, 240, 242),
                        ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),

                // Contact No field
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Contact No',
                        style: TextStyle(
                          fontSize: 14 * (screenWidth / 360),
                          fontWeight: FontWeight.w500,
                          color: Colors.black, // or your default text color
                        ),
                      ),
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                          fontSize: 14 * (screenWidth / 360),
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.001),
                SizedBox(
                  height: screenHeight * 0.075,
                  child: TextFormField(
                    readOnly: _fieldstatus == 1 ? true : false,
                    controller: _contactNo,
                    keyboardType: TextInputType.phone,
                    decoration: _getInputDecoration().copyWith(
                        // filled: true,
                        // fillColor: Color.fromARGB(255, 231, 240, 242),
                        ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter contact number';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),

                // Date of Birth field
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Date Of Birth',
                        style: TextStyle(
                          fontSize: 14 * (screenWidth / 360),
                          fontWeight: FontWeight.w500,
                          color: Colors.black, // or your default text color
                        ),
                      ),
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                          fontSize: 14 * (screenWidth / 360),
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.001),
                SizedBox(
                  height: screenHeight * 0.075,
                  child: TextFormField(
                    controller: _dob,
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select date of birth';
                      }
                      return null;
                    },
                    decoration: _getInputDecoration().copyWith(
                      suffixIcon: _fieldstatus == 1
                          ? Container()
                          : InkWell(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  _dob.text =
                                      "${pickedDate.toLocal()}".split(' ')[0];
                                }
                              },
                              child: const Icon(Icons.calendar_today),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),

                //gender
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Gender',
                        style: TextStyle(
                          fontSize: 14 * (screenWidth / 360),
                          fontWeight: FontWeight.w500,
                          color: Colors.black, // or your default text color
                        ),
                      ),
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                          fontSize: 14 * (screenWidth / 360),
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Radio<int>(
                      value: 1,
                      groupValue: _gender,
                      onChanged: (int? value) {
                        _fieldstatus == 0
                            ? setState(() {
                                _gender = value;
                              })
                            : "";
                      },
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
                        _fieldstatus == 0
                            ? setState(() {
                                _gender = value;
                              })
                            : "";
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
                        _fieldstatus == 0
                            ? setState(() {
                                _gender = value;
                              })
                            : "";
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
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                // Create Button
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_fieldstatus == 1) {
                        postProfile();
                      } else {
                        if (_formKey.currentState!.validate()) {
                          postProfile();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Config.primarythemeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      ),
                      minimumSize: Size(screenWidth * 0.2, screenHeight * 0.05),
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Create Profile',
                    ),
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
