import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TeacherPage extends StatefulWidget {
  final String teacherId;
  final String teacherName;

  const TeacherPage({required this.teacherId, required this.teacherName});

  @override
  _TeacherPageState createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  bool _showCalendar = false;

  void _toggleCalendar() {
    setState(() {
      _showCalendar = !_showCalendar;
    });
  }

  void _openAttendancePage(DateTime selectedDay) {
    // Navigate to the AttendancePage with selected date and other information
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AttendancePage(
          teacherId: widget.teacherId,
          teacherName: widget.teacherName,
          selectedDate: selectedDay,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 100.0),
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Container(
              height: 100.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: const [Colors.blue, Colors.purple],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  widget.teacherName,
                  style: const TextStyle(fontSize: 24.0, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 170.0,
                height: 200.0,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.report,
                      size: 60.0,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Complaint',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
                width: 170.0,
                height: 200.0,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 60.0,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Profile',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          GestureDetector(
            onTap: _toggleCalendar,
            child: Container(
              width: double.infinity,
              height: 60.0,
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: const Text(
                  'Take Attendance',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ),
          ),
          if (_showCalendar)
            Expanded(
              child: TableCalendar(
                firstDay: DateTime.utc(2023),
                lastDay: DateTime.utc(2024),
                focusedDay: _focusedDate,
                selectedDayPredicate: (day) {
                  return _selectedDate.year == day.year &&
                      _selectedDate.month == day.month &&
                      _selectedDate.day == day.day;
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDate = selectedDay;
                  });
                  _openAttendancePage(selectedDay); // Open AttendancePage
                },
                onPageChanged: (focusedDay) {
                  setState(() {
                    _focusedDate = focusedDay;
                  });
                },
                calendarStyle: const CalendarStyle(
                  defaultTextStyle: TextStyle(color: Colors.white),
                  weekendTextStyle: TextStyle(color: Colors.white),
                  selectedTextStyle: TextStyle(color: Colors.black),
                  todayTextStyle: TextStyle(color: Colors.black),
                  outsideDaysVisible: false,
                ),
                headerStyle: const HeaderStyle(
                  titleTextStyle: TextStyle(color: Colors.white),
                  formatButtonVisible: false,
                  leftChevronIcon:
                      Icon(Icons.chevron_left, color: Colors.white),
                  rightChevronIcon:
                      Icon(Icons.chevron_right, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class AttendancePage extends StatefulWidget {
  final String teacherId;
  final String teacherName;
  final DateTime selectedDate;

  const AttendancePage({
    required this.teacherId,
    required this.teacherName,
    required this.selectedDate,
  });

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  List<String> studentNames = [];
  List<String> studentRollNumbers = [];
  List<Color> cardColors = [];
  List<bool> isChecked = [];

  @override
  void initState() {
    super.initState();
    fetchStudentData();
  }

  void submitAttendance() async {
    try {
      CollectionReference attendanceRef =
          FirebaseFirestore.instance.collection('Attendance_Status');
      for (int i = 0; i < studentNames.length; i++) {
        String studentName = studentNames[i];
        // String studentId = student_ids[i];
        String rollNumber = studentRollNumbers[i];
        bool isPresent = isChecked[i];

        await attendanceRef.add({
          'teacherId': widget.teacherId,
          'teacherName': widget.teacherName,
          'selectedDate': widget.selectedDate,
          // 'studentId': studentId,
          'studentName': studentName,
          'rollNumber': rollNumber,
          'isPresent': isPresent,
        });
      }
    } catch (e) {
      print('Error submitting attendance: $e');
    }
  }

  void fetchStudentData() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Student_Details')
          .where('Class', isEqualTo: '11th')
          .get();

      if (snapshot.docs.isNotEmpty) {
        List<String> names = [];
        List<String> rollNumbers = [];
        List<String> student_ids = [];

        for (var doc in snapshot.docs) {
          String studentName = doc.get('student_name');
          String rollNumber = doc.get('roll_number');
          String ids = doc.get('student_ids');
          student_ids.add(ids);
          names.add(studentName);
          rollNumbers.add(rollNumber);
        }

        setState(() {
          studentNames = names;
          studentRollNumbers = rollNumbers;
          student_ids = student_ids;
          cardColors = _generateRandomColors(studentNames.length);
          isChecked = List<bool>.filled(studentNames.length, false);
        });
      }
    } catch (e) {
      print('Error fetching student data: $e');
    }
  }

  List<Color> _generateRandomColors(int length) {
    List<Color> colors = [];
    final random = Random();

    for (int i = 0; i < length; i++) {
      final color = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );
      colors.add(color);
    }

    return colors;
  }

  @override
  Widget build(BuildContext context) {
    final int day = widget.selectedDate.day;
    final int month = widget.selectedDate.month;
    final int year = widget.selectedDate.year;

    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Submit Attendance'),
                    content:
                        Text('Are you sure you want to submit the attendance?'),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Submit'),
                        onPressed: () {
                          submitAttendance();
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Attendance Submitted'),
                                content: Text(
                                    'Attendance for selected teachers is submitted.'),
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
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Selected Date: $day-$month-$year',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: studentNames.length,
              itemBuilder: (context, index) {
                return Card(
                  color: cardColors[index],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        studentRollNumbers[index],
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    title: Text(
                      studentNames[index],
                      style: TextStyle(fontSize: 20.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    trailing: Checkbox(
                      value: isChecked[index],
                      onChanged: (value) {
                        setState(() {
                          isChecked[index] = value!;
                        });
                      },
                      fillColor: MaterialStateProperty.resolveWith<Color?>(
                        (states) {
                          if (states.contains(MaterialState.selected)) {
                            return Colors.green;
                          }
                          return Colors.red;
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
