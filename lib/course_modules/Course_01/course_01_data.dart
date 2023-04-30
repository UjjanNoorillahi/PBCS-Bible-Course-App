import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class CourseInfo{
//   final String title;
//   final String content;
//   CourseInfo({required this.title, required this.content});
// }

class Course_01_data extends StatefulWidget {
  final auth = FirebaseAuth.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;
  Course_01_data({super.key});

  @override
  State<Course_01_data> createState() => _Course_01_dataState();
}

class _Course_01_dataState extends State<Course_01_data> {
  DatabaseReference ref = FirebaseDatabase.instance.ref('/Course_01');
  final firestore =
      FirebaseFirestore.instance.collection("Courses").snapshots();
  final CollectionReference = FirebaseFirestore.instance.collection("Courses");
  final documentRef =
      FirebaseFirestore.instance.collection('Courses').doc('Course_01');
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: appPrimaryColor,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          width: mediaQuery.size.width * 0.9,
          height: mediaQuery.size.height * 0.95,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: mediaQuery.size.width * 0.15,
                  ),
                  const SizedBox(width: 20),
                  // Expanded(
                  Text(
                    'Course_01',
                    style: TextStyle(
                      color: appPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Calibri',
                      fontSize: 35,
                    ),
                    textAlign: TextAlign.left,
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
                width: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.75,
                child: Column(
                  children: [
                    // Use the get() method to retrieve the document data
                    Expanded(
                      child: SingleChildScrollView(
                        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                          future: FirebaseFirestore.instance
                              .collection('Courses')
                              .doc('Course_01')
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              final documentData = snapshot.data!.data();
                              final fieldValue = documentData!['content'];
                              return Text(fieldValue);
                            } else if (snapshot.hasError) {
                              return Text(
                                  'Error retrieving document: ${snapshot.error}');
                            } else {
                              return const Text('Loading...');
                            }
                          },
                        ),
                      ),
                    ),
                    // StreamBuilder(
                    //   stream: firestore,
                    //   builder: (context, snapshot) {
                    //     if (!snapshot.hasData) {
                    //       return Text('Loading...');
                    //     } else {
                    //       return Expanded(
                    //         child: ListView.builder(
                    //           itemCount: snapshot.data!.docs.length,
                    //           itemBuilder: (context, index) {
                    //             DocumentSnapshot mypost =
                    //                 snapshot.data!.docs[index];
                    //             return ListTile(
                    //               title: Text(mypost['title']),
                    //             );
                    //           },
                    //         ),
                    //       );
                    //     }
                    //   },
                    // ),
                    // Expanded(
                    //   child: SingleChildScrollView(
                    //       // child: Text(
                    //       //   'تورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیا اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیا اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیا اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاء کی شہ اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیا اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیا اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیا اور صحیفۂ امبیاء کی شہادتتورات، زبور اور صحیفۂ امبیاادتتورات، زبور اور صحیفۂ امبیاء کی شہادت',
                    //       //   style: TextStyle(
                    //       //     // color: appPrimaryColor,
                    //       //     fontWeight: FontWeight.bold,
                    //       //     fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                    //       //     fontSize: 15,
                    //       //   ),
                    //       //   textAlign: TextAlign.center,
                    //       //   textDirection: TextDirection.rtl,
                    //       // ),

                    //       child: FirebaseAnimatedList(
                    //     query: ref,
                    //     itemBuilder: (context, snapshot, animation, index) {
                    //       return Text(
                    //         snapshot.child('/course_data').value.toString(),
                    //         style: const TextStyle(
                    //           // color: appPrimaryColor,
                    //           fontWeight: FontWeight.bold,
                    //           fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                    //           fontSize: 20,
                    //         ),
                    //         textAlign: TextAlign.center,
                    //         textDirection: TextDirection.rtl,
                    //       );
                    //     },
                    //   )),
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}