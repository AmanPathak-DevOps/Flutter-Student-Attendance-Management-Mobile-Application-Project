import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintPage extends StatefulWidget {
  final String studentId;
  final String className;
  final String studentName;

  ComplaintPage(
      {required this.studentId,
      required this.className,
      required this.studentName});

  @override
  _ComplaintPageState createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  String title = '';
  String description = '';

  void submitComplaint() {
    if (title.length < 6) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid Title'),
            content: Text('Title must be at least 6 characters long.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
              ),
            ],
          );
        },
      );
      return;
    }

    if (description.split(' ').length < 50) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid Description'),
            content: Text('Description must be at least 50 words long.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
              ),
            ],
          );
        },
      );
      return;
    }

    // Save the complaint to the Complaint collection in Firestore
    FirebaseFirestore.instance.collection('Complaints').add({
      'title': title,
      'description': description,
      'studentId': widget.studentId,
      'studentName': widget.studentName,
      'studentClass': widget.className,
      'timestamp': DateTime.now(),
    });

    // Show a confirmation dialog or navigate to another page
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Complaint Submitted'),
          content: Text('Your complaint has been submitted successfully.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Close the dialog
                // Navigate to another page if needed
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Title',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Enter the title of your complaint',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Description',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Enter the description of your complaint',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: submitComplaint,
              child: Text('Submit Complaint'),
            ),
          ],
        ),
      ),
    );
  }
}
