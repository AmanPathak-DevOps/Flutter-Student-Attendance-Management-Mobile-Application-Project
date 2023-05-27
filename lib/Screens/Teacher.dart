import 'package:flutter/material.dart';

class TeacherPage extends StatefulWidget {
  final String teacherId;
  final String teacherName;

  TeacherPage({required this.teacherId, required this.teacherName});

  @override
  _TeacherPageState createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, ${widget.teacherName}!',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                'Teacher ID: ${widget.teacherId}',
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
