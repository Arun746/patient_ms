// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class SelectUser extends StatefulWidget {
  const SelectUser({super.key});

  @override
  State<SelectUser> createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text('Select User'),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout_sharp),
              onPressed: () {
                // Navigator.pushNamed(context, '/Login');
                Navigator.pushReplacementNamed(context, '/Login');
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            SizedBox(
              height: screenHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < 4; i++) _list(i),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: screenWidth * 0.2,
              right: screenWidth * 0.2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  if (_selectedIndex == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Center(
                            child: Text(
                          'Select A Profile First',
                          style: TextStyle(fontSize: 15),
                        )),
                        duration: Duration(milliseconds: 500),
                      ),
                    );
                  } else {
                    Navigator.pushNamed(context, '/Home');
                    // Navigator.pushReplacementNamed(context, '/Home');
                  }
                },
                child: const Text('Continue as SelectedN'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _list(int i) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = _selectedIndex == i ? null : i;
        });
      },
      child: ListTile(
        title: Container(
          // height: 100,
          decoration: BoxDecoration(
            color: _selectedIndex == i
                ? const Color.fromRGBO(164, 191, 223, 1)
                : Colors.white,
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
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Container(
                      height: screenHeight * 0.12,
                      width: screenWidth * 0.2,
                      decoration: BoxDecoration(
                        color: _selectedIndex == i
                            ? const Color.fromRGBO(164, 191, 223, 1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
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
                        child: Image.asset('images/profile.png'),
                      ),
                    ),
                  ],
                ),
              ),
              //
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Id'),
                  Text('Name'),
                  Text('Redg date'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
