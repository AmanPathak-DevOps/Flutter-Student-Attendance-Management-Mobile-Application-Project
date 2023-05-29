import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentProfilePage extends StatefulWidget {
  final String studentId;

  const StudentProfilePage({required this.studentId});

  @override
  _StudentProfilePageState createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  late DocumentSnapshot _studentdata;

  @override
  void initState() {
    super.initState();
    _fetchStudentData();
  }

  Future<void> _fetchStudentData() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Student_Details')
        .where('student_id', isEqualTo: widget.studentId)
        .get();
    if (querySnapshot.size > 0) {
      setState(() {
        _studentdata = querySnapshot.docs[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      backgroundColor: Colors
          .lightBlueAccent, // Set the background color for the entire page
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 60.0,
              child: Icon(
                Icons.person,
                size: 60.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                _studentdata['student_name'] ?? '',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Card(
              margin: EdgeInsets.all(20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.white,
              child: ListTile(
                leading: Icon(Icons.format_list_numbered),
                title: Text(
                  'Student ID',
                  style: TextStyle(fontSize: 16.0),
                ),
                subtitle: Text(
                  _studentdata['student_id'] ?? '',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.white,
              child: ListTile(
                leading: Icon(Icons.email),
                title: Text(
                  'Roll Number',
                  style: TextStyle(fontSize: 16.0),
                ),
                subtitle: Text(
                  _studentdata['roll_number'] ?? '',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.white,
              child: ListTile(
                leading: Icon(Icons.class_),
                title: Text(
                  'Class',
                  style: TextStyle(fontSize: 16.0),
                ),
                subtitle: Text(
                  _studentdata['Class'] ?? '',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.white,
              child: ListTile(
                leading: Icon(Icons.email),
                title: Text(
                  'Date of birth',
                  style: TextStyle(fontSize: 16.0),
                ),
                subtitle: Text(
                  _studentdata['Date_of_birth'] ?? '',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.white,
              child: ListTile(
                leading: Icon(Icons.phone),
                title: Text(
                  'Fathers Name',
                  style: TextStyle(fontSize: 16.0),
                ),
                subtitle: Text(
                  _studentdata['father_name'] ?? '',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.white,
              child: ListTile(
                leading: Icon(Icons.class_),
                title: const Text(
                  'Gender',
                  style: TextStyle(fontSize: 16.0),
                ),
                subtitle: Text(
                  _studentdata['Gender'] ?? '',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.white,
              child: ListTile(
                leading: Icon(Icons.format_list_numbered),
                title: Text(
                  'Email ID',
                  style: TextStyle(fontSize: 16.0),
                ),
                subtitle: Text(
                  _studentdata['email_id'] ?? '',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.white,
              child: ListTile(
                leading: Icon(Icons.format_list_numbered),
                title: Text(
                  'Mobile Number',
                  style: TextStyle(fontSize: 16.0),
                ),
                subtitle: Text(
                  _studentdata['Mobile_number'] ?? '',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
