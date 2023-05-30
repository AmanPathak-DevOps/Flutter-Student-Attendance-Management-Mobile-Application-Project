import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminProfile extends StatefulWidget {
  final String adminName;

  const AdminProfile({super.key, required this.adminName});

  @override
  _AdminProfile createState() => _AdminProfile();
}

class _AdminProfile extends State<AdminProfile> {
  late DocumentSnapshot _adminData;

  @override
  void initState() {
    super.initState();
    _fetchAdminData();
  }

  Future<void> _fetchAdminData() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Admin_Account')
        .where('Name', isEqualTo: widget.adminName)
        .get();
    if (querySnapshot.size > 0) {
      setState(() {
        _adminData = querySnapshot.docs[0];
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
                _adminData['Name'] ?? '',
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
                  'Admin ID',
                  style: TextStyle(fontSize: 16.0),
                ),
                subtitle: Text(
                  _adminData['Admin_ID'] ?? '',
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
                leading: Icon(Icons.format_list_numbered),
                title: Text(
                  'Email ID',
                  style: TextStyle(fontSize: 16.0),
                ),
                subtitle: Text(
                  _adminData['email_id'] ?? '',
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
