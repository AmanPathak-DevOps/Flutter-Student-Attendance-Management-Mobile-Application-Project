import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SignUp App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  final List<String> _roles = ['Teacher', 'Student'];

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

  void _submitSignUpForm() {
    if (_selectedRole == 'Teacher') {
      // Perform signup logic for teacher
      // ...
    } else if (_selectedRole == 'Student') {
      if (_validateStudentDetails()) {
        // Perform signup logic for student
        // ...
      }
    }
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
            Text(
              'Sign Up As',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.red, // Set the background color
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
                        color: Colors.white,
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
                onTap: () {
                  // Show calendar or date picker
                  // ...
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
            ElevatedButton(
              onPressed: _submitSignUpForm,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
