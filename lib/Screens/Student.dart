import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:login_signup/Screens/StudentProfilePage.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:login_signup/Screens/Complaint.dart';

class StudentPage extends StatefulWidget {
  final String studentId;
  final String studentName;
  final String className;

  const StudentPage(
      {required this.studentId,
      required this.studentName,
      required this.className});

  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  bool _showCalendar = false;

  void _toggleCalendar() {
    setState(() {
      _showCalendar = !_showCalendar;
    });
  }

  void _openAttendancePage() {
    // Navigate to the AttendancePage with selected date and other information
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewAttendancePage(
          studentId: widget.studentId,
          studentName: widget.studentName,
          selectedDate: _selectedDate,
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
                  widget.studentName,
                  style: const TextStyle(fontSize: 24.0, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ComplaintPage(
                        studentId: widget.studentId,
                        className: widget.className,
                        studentName: widget.studentName,
                      ),
                    ),
                  );
                },
                child: Container(
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
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          StudentProfilePage(studentId: widget.studentId),
                    ),
                  );
                },
                child: Container(
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
              )
            ],
          ),
          const SizedBox(height: 20.0),
          GestureDetector(
            onTap: _openAttendancePage,
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
                  'View Attendance',
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

class ViewAttendancePage extends StatefulWidget {
  final String studentId;
  final String studentName;
  final DateTime selectedDate;

  const ViewAttendancePage({
    required this.studentId,
    required this.studentName,
    required this.selectedDate,
  });
  @override
  _ViewAttendancePage createState() => _ViewAttendancePage();
}

class _ViewAttendancePage extends State<ViewAttendancePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDate = DateTime.now();
  Map<DateTime, bool> _attendanceData = {};

  @override
  void initState() {
    super.initState();
    fetchAttendanceData();
  }

  void fetchAttendanceData() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Attendance_Status')
          .get();

      if (snapshot.docs.isNotEmpty) {
        Map<DateTime, bool> attendanceData = {};

        for (var doc in snapshot.docs) {
          DateTime date = doc.get('date').toDate();
          bool isPresent = doc.get('isPresent') ??
              false; // Default value of false if not available

          attendanceData[date] = isPresent;
        }

        setState(() {
          _attendanceData = attendanceData;
        });
      }
    } catch (e) {
      print('Error fetching attendance data: $e');
    }
  }

  void _onDaySelected(DateTime selectedDate, DateTime focusedDay) {
    setState(() {
      _selectedDate = selectedDate;
    });
    fetchAttendanceData();
  }

  Widget _buildCalendar() {
    return TableCalendar(
      calendarFormat: _calendarFormat,
      firstDay: DateTime.utc(2023, 1, 1),
      lastDay: DateTime.utc(2023, 12, 31),
      focusedDay: _selectedDate,
      selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
      eventLoader: (day) {
        if (_attendanceData.containsKey(day) && _attendanceData[day] == true) {
          return [true];
        } else {
          return [];
        }
      },
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.grey[300],
          shape: BoxShape.circle,
        ),
        weekendTextStyle: TextStyle(color: Colors.red),
      ),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          final isPresent = _attendanceData[date] ?? false;

          return Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isPresent ? Colors.green : Colors.green,
            ),
          );
        },
      ),
      onDaySelected: (selectedDate, focusedDate) {
        setState(() {
          _selectedDate = selectedDate;
        });
      },
    );
  }

  void generateAttendancePDF() async {
    try {
      // Fetch attendance data from Firestore
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Attendance_Status')
          .where('studentId',
              isEqualTo: widget.studentId) // Filter by student ID
          .get();

      // Create a PDF document
      final pdf = pw.Document();

      // Add content to the PDF
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            final studentName = snapshot.docs[0]['studentName'];
            final rollNumber = snapshot.docs[0]['rollNumber'];
            final student_class = snapshot.docs[0]['class'];
            final teacherName = snapshot.docs[0]['teacherName'];
            // Define the table headers
            final headers = ['Date', 'Status'];

            // Define the data rows
            final dataRows = snapshot.docs.map((doc) {
              final selectedDate = DateTime.parse(
                '20${doc.get('selectedDate').substring(6, 8)}-${doc.get('selectedDate').substring(0, 2)}-${doc.get('selectedDate').substring(3, 5)}',
              );
              final isPresent = doc.get('isPresent') ?? false;
              return [
                DateFormat('MM-dd-yyyy').format(selectedDate),
                isPresent ? 'Present' : 'Absent',
              ];
            }).toList();

            // Create a table widget
            final table = pw.Table.fromTextArray(
              headers: headers,
              data: dataRows,
              cellPadding: pw.EdgeInsets.all(5),
              headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 14,
              ),
              cellAlignment: pw.Alignment.center,
            );

            // Build the PDF content
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.Text(
                    'Attendance Report',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 30),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Name:',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text(' $studentName'),
                    pw.Text(
                      'Roll Number:',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text('$rollNumber'),
                    pw.Text(
                      'Class:',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text('$student_class'),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      'Teacher Name:',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text('$teacherName'),
                  ],
                ),
                pw.SizedBox(height: 20),
                table,
              ],
            );
          },
        ),
      );

      final Directory? appDocDir = await getApplicationDocumentsDirectory();
      final String appDocPath = appDocDir!.path;

      // Save the PDF to a file
      final File file = File('$appDocPath/attendance.pdf');
      await file.writeAsBytes(await pdf.save());

      print('PDF generated successfully: ${file.path}');

      // Open the PDF file
      // openPDFFile(file.path);

      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('PDF Preview'),
          content: Container(
            height: 300,
            width: 300,
            child: PDFView(
              filePath: file.path,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Open PDF'),
              onPressed: () {
                // Open the PDF file
                OpenFile.open(file.path);
              },
            ),
          ],
        ),
      );
    } catch (e) {
      print('Error generating or opening PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance View'),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () {
              // Code to generate the PDF
              generateAttendancePDF();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Text(
              'Attendance Calendar',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            _buildCalendar(),
          ],
        ),
      ),
    );
  }
}
