import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  final String teacherId;

  const ProfilePage({required this.teacherId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late DocumentSnapshot _teacherData;

  @override
  void initState() {
    super.initState();
    _fetchTeacherData();
  }

  Future<void> _fetchTeacherData() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Staff_Details')
        .where('Teacher_ID', isEqualTo: widget.teacherId)
        .get();
    if (querySnapshot.size > 0) {
      setState(() {
        _teacherData = querySnapshot.docs[0];
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
                _teacherData['teacher_name'] ?? '',
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
                  'Teacher ID',
                  style: TextStyle(fontSize: 16.0),
                ),
                subtitle: Text(
                  _teacherData['Teacher_ID'] ?? '',
                  style: TextStyle(
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
                leading: Icon(Icons.class_),
                title: Text(
                  'Class',
                  style: TextStyle(fontSize: 16.0),
                ),
                subtitle: Text(
                  _teacherData['teacher_class'] ?? '',
                  style: TextStyle(
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
                leading: Icon(Icons.email),
                title: Text(
                  'Email',
                  style: TextStyle(fontSize: 16.0),
                ),
                subtitle: Text(
                  _teacherData['email_id'] ?? '',
                  style: TextStyle(
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
                leading: Icon(Icons.phone),
                title: Text(
                  'Mobile Number',
                  style: TextStyle(fontSize: 16.0),
                ),
                subtitle: Text(
                  _teacherData['mobile_number'] ?? '',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
