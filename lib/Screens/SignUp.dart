import 'package:flutter/material.dart';

import 'LogIn.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SignUp App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Image.asset('assets/images/signup.jpg')
      ),
      debugShowCheckedModeBanner: false, // Hide the debug banner
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String _selectedRole;
  final List<String> _roles = ['Select', 'Teacher', 'Student'];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollNumberController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final List<String> _genderOptions = ['Male', 'Female'];
  late String _selectedGender;

  final List<String> _classOptions = [
    '1st',
    '2nd',
    '3rd',
    '4th',
    '5th',
    '6th',
    '7th',
    '8th',
    '9th',
    '10th',
    '11th',
    '12th'
  ];
  late String _selectedClass;

  @override
  void initState() {
    super.initState();
    _selectedRole = _roles[0]; // Set the initial selected role
    _selectedGender = _genderOptions[0]; // Set the initial selected gender
    _selectedClass = _classOptions[0]; // Set the initial selected class
  }

  bool _validateStudentDetails() {
    // Validate student details
    final String name = _nameController.text.trim();
    final String rollNumber = _rollNumberController.text.trim();
    final String fatherName = _fatherNameController.text.trim();
    final String dateOfBirth = _dateOfBirthController.text.trim();
    final String mobile = _mobileController.text.trim();
    final String email = _emailController.text.trim();

    if (name.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter student name.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return false;
    }

    if (rollNumber.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter roll number.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return false;
    }

    if (fatherName.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text("Please enter father's name."),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return false;
    }

    if (dateOfBirth.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter date of birth.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return false;
    }

    if (mobile.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter mobile number.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return false;
    }

    // Perform additional validation for mobile number
    // ...

    if (email.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter email id.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return false;
    }

    // Perform additional validation for email format
    // ...

    // All student details are valid
    return true;
  }

  bool _validateTeacherDetails() {
    // Validate teacher details
    final String name = _nameController.text.trim();
    final String mobile = _mobileController.text.trim();
    final String email = _emailController.text.trim();

    if (name.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter teacher name.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return false;
    }

    if (mobile.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter mobile number.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return false;
    }

    // Perform additional validation for mobile number
    // ...

    if (email.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter email id.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return false;
    }
    return true;
  }

  bool _submitSignUpForm() {
    if (_selectedRole == 'Teacher') {
      if (_validateTeacherDetails()) {
        showDialog(
          context: context,
          barrierDismissible:
              true, // Prevent dismissing the dialog on tap outside
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Signing Up'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(), // Show circular progress indicator
                  SizedBox(height: 16.0),
                  Text('Please wait...'),
                ],
              ),
            );
          },
        );
        // Perform signup logic for teacher
        // ...

        // Dismiss the popup
        Navigator.pop(context);

        // Navigate to the LoginApp
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginApp()),
        );
      }
    } else if (_selectedRole == 'Student') {
      if (_validateStudentDetails()) {
        showDialog(
          context: context,
          barrierDismissible:
              true, // Prevent dismissing the dialog on tap outside
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Signing Up'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(), // Show circular progress indicator
                  SizedBox(height: 16.0),
                  Text('Please wait...'),
                ],
              ),
            );
          },
        );
        // Perform signup logic for student
        // ...

        // Dismiss the popup
        Navigator.pop(context);

        // Navigate to the LoginApp
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginApp()),
        );
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: 30.0,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  'Sign Up As',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                // Set the background color
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButton<String>(
                isExpanded: true,
                value: _selectedRole,
                items: _roles.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedRole = value!;
                  });
                },
              ),
            ),
            SizedBox(height: 16.0),
            if (_selectedRole == 'Teacher') ...[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Teacher Name',
                  hintText: 'Enter teacher name',
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter teacher name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _mobileController,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  hintText: 'Enter mobile number',
                ),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter mobile number';
                  }
                  // Perform additional validation for mobile number
                  // ...
                  return null;
                },
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email ID',
                  hintText: 'Enter email id',
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter email id';
                  }
                  // Perform additional validation for email format
                  // ...
                  return null;
                },
              ),
            ] else if (_selectedRole == 'Student') ...[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Student Name',
                  hintText: 'Enter student name',
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter student name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _rollNumberController,
                decoration: InputDecoration(
                  labelText: 'Roll Number',
                  hintText: 'Enter roll number',
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter roll number';
                  }
                  // Perform additional validation for roll number
                  // ...
                  return null;
                },
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _fatherNameController,
                decoration: InputDecoration(
                  labelText: "Father's Name",
                  hintText: "Enter father's name",
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter father's name";
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _dateOfBirthController,
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  hintText: 'Select date of birth',
                ),
                onTap: () async {
                  // Show calendar or date picker
                  // ...
                  await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  ).then((pickedDate) {
                    if (pickedDate != null) {
                      setState(() {
                        _dateOfBirthController.text =
                            pickedDate.toString().split(' ')[0];
                      });
                    }
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select date of birth';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.0),
              DropdownButton<String>(
                isExpanded: true,
                value: _selectedGender,
                items: _genderOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _mobileController,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  hintText: 'Enter mobile number',
                ),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter mobile number';
                  }
                  // Perform additional validation for mobile number
                  // ...
                  return null;
                },
              ),
              SizedBox(height: 8.0),
              DropdownButton<String>(
                isExpanded: true,
                value: _selectedClass,
                items: _classOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedClass = value!;
                  });
                },
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email ID',
                  hintText: 'Enter email id',
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter email id';
                  }
                  // Perform additional validation for email format
                  // ...
                  return null;
                },
              ),
            ],
            SizedBox(height: 16.0),
            Visibility(
              visible: _selectedRole != 'Select',
              child: Container(
                width: 150, // Adjust the width value as per your requirement
                child: ElevatedButton(
                  onPressed: () async {
                    bool isValid = _submitSignUpForm();
                    if (isValid) {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Sign Up Successful'),
                        ),
                      );
                    }
                  },
                  child: Text('Sign Up'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.0, // Adjust the horizontal padding value
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
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
