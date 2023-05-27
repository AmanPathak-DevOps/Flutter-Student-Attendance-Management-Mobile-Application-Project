import 'package:flutter/material.dart';

class StudentPage extends StatefulWidget {
  final String studentId;
  final String studentName;

  StudentPage({required this.studentId, required this.studentName});

  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, ${widget.studentName}!',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                'Student ID: ${widget.studentId}',
                style: TextStyle(fontSize: 16.0),
              ),
              // Add more widgets as needed
            ],
          ),
        ),
      ),
    );
  }
}
