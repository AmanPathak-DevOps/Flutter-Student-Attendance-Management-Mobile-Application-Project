import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintViewListAllPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaints'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Complaints')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<QueryDocumentSnapshot> complaints = snapshot.data!.docs;

            return SingleChildScrollView(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(20.0),
                itemCount: complaints.length,
                itemBuilder: (BuildContext context, int index) {
                  QueryDocumentSnapshot complaint = complaints[index];
                  Map<String, dynamic>? data =
                      complaint.data() as Map<String, dynamic>?;

                  if (data == null) {
                    return SizedBox.shrink();
                  }

                  String title = data['title'] ?? '';
                  String description = data['description'] ?? '';
                  String studentName = data['studentName'] ?? '';
                  String date = data['timestamp'] != null
                      ? (data['timestamp'] as Timestamp).toDate().toString()
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
                                fontSize: 14.0, fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
