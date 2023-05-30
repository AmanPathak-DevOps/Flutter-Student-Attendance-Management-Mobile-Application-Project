import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintViewListPage extends StatelessWidget {
  final String teacherClass;

  const ComplaintViewListPage({required this.teacherClass});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, Colors.purple],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Complaints'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Complaints')
              .where('studentClass', isEqualTo: teacherClass)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> filteredSnapshot) {
            if (filteredSnapshot.hasError) {
              return Center(
                child: Text('Error: ${filteredSnapshot.error}'),
              );
            }

            if (filteredSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<QueryDocumentSnapshot> filteredComplaints =
                filteredSnapshot.data!.docs;

            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Complaints')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> sortedSnapshot) {
                if (sortedSnapshot.hasError) {
                  return Center(
                    child: Text('Error: ${sortedSnapshot.error}'),
                  );
                }

                if (sortedSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<QueryDocumentSnapshot> allComplaints =
                    sortedSnapshot.data!.docs;

                // Filter the complaints based on studentClass
                List<QueryDocumentSnapshot> sortedComplaints =
                    allComplaints.where((complaint) {
                  return filteredComplaints.any((filteredComplaint) =>
                      filteredComplaint.id == complaint.id);
                }).toList();

                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue, Colors.purple],
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: sortedComplaints.length,
                        itemBuilder: (BuildContext context, int index) {
                          QueryDocumentSnapshot complaint =
                              sortedComplaints[index];
                          Map<String, dynamic>? data =
                              complaint.data() as Map<String, dynamic>?;

                          if (data == null) {
                            return SizedBox.shrink();
                          }

                          String title = data['title'] ?? '';
                          String description = data['description'] ?? '';
                          String studentName = data['studentName'] ?? '';
                          String date = data['timestamp'] != null
                              ? (data['timestamp'] as Timestamp)
                                  .toDate()
                                  .toString()
                              : '';

                          return Card(
                            elevation: 3.0,
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            color: Colors.white,
                            child: ListTile(
                              title: Text(
                                title,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Student: $studentName',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    description,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    date,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
