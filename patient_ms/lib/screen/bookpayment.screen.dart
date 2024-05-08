// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class BookPayment extends StatefulWidget {
  const BookPayment({super.key});

  @override
  State<BookPayment> createState() => _BookPaymentState();
}

class _BookPaymentState extends State<BookPayment> {
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
    );
  }
}
