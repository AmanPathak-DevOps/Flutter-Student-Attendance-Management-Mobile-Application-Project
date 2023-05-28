import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  void sendEmail(String recipientEmail, String subject, String body) async {
    final smtpServer = gmail('avianvista@gmail.com', 'ykxfjsvwfhantoqu');

    final message = Message()
      ..from = Address('avianvista@gmail.com', 'Avian Vista')
      ..recipients.add(recipientEmail)
      ..subject = subject
      ..text = body;

    try {
      final sendReport = await send(message, smtpServer);
      print('Email sent: ${sendReport.toString()}');
    } catch (e) {
      print('Error sending email: $e');
    }
  }

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String mobile = _mobileController.text;

      // Query Student_Details collection
      QuerySnapshot studentSnapshot = await FirebaseFirestore.instance
          .collection('Student_Details')
          .where('mobile_number', isEqualTo: mobile)
          .where('email_id', isEqualTo: email)
          .get();

      QuerySnapshot staffSnapshot = await FirebaseFirestore.instance
          .collection('Staff_Details')
          .where('mobile_number', isEqualTo: mobile)
          .where('email_id', isEqualTo: email)
          .get();

      String recipientEmail = email; // Replace with appropriate field
      String subject;
      String body;
      // Check if any matching document is found in Student_Details collection
      if (studentSnapshot.size > 0) {
        // print('Student Found');
        FirebaseFirestore.instance
            .collection('Student_Details')
            .where('mobile_number', isEqualTo: mobile)
            .where('email_id', isEqualTo: email)
            .get()
            .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            String studentId = studentSnapshot.docs[0].get('student_id');
            String studentpassword =
                studentSnapshot.docs[0].get('student_password');
            String studentName = studentSnapshot.docs[0].get('student_name');
            subject = 'Request Accepted $studentName';
            body =
                'Use Below details while Log In!\n ID: $studentId\n Password: $studentpassword\n\n\nHave A Great Day!\n\nAman Pathak';
            sendEmail(recipientEmail, subject, body);
          }
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Password Reset'),
              content: Text('Check your Email'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else if (staffSnapshot.size > 0) {
        FirebaseFirestore.instance
            .collection('Staff_Details')
            .where('mobile_number', isEqualTo: mobile)
            .where('email_id', isEqualTo: email)
            .get()
            .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            String teacherId = staffSnapshot.docs[0].get('Teacher_ID');
            String teacherpassword =
                staffSnapshot.docs[0].get('teacher_password');
            String teacherName = staffSnapshot.docs[0].get('teacher_name');
            subject = 'Request Accepted $teacherName';
            body =
                'Use Below details while Log In!\n ID: $teacherId\n Password: $teacherpassword\n\n\nHave A Great Day!\n\nAman Pathak';
            sendEmail(recipientEmail, subject, body);
          }
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Password Reset'),
              content: Text('Check your Email'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid Details'),
              content: Text(
                  'The entered email and mobile do not match any account.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    RegExp emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a mobile number';
    }
    RegExp numeric = RegExp(r'^[0-9]+$');
    if (!numeric.hasMatch(value)) {
      return 'Mobile number must be numeric';
    }
    if (value.length != 10) {
      return 'Invalid number. Mobile number must be 10 digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.orange,
              Colors.red,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Reset Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          validator: _validateEmail,
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: _mobileController,
                          decoration: InputDecoration(
                            labelText: 'Mobile Number',
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          validator: _validateMobile,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: _resetPassword,
                          child: Text('Reset Password'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            primary: Colors.white,
                            onPrimary: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ResetPasswordPage(),
    debugShowCheckedModeBanner: false,
  ));
}
