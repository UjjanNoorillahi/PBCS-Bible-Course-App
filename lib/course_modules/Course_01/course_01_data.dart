// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import '../../constants/colors.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';

// import '../model_bottom_sheet/bottom_sheet.dart';

// class Course_01_data extends StatefulWidget {
//   final auth = FirebaseAuth.instance;
//   FirebaseDatabase database = FirebaseDatabase.instance;
//   Course_01_data({super.key});
//   final String pdfUrl =
//       "https://firebasestorage.googleapis.com/v0/b/pbcs-bible-course-81b4b.appspot.com/o/courses%2Fcourse_01%2FFaithfulness%20of%20God%20Part-1.pdf?alt=media&token=ec7af450-9bc7-4539-b375-1a5e087437c1";

//   @override
//   State<Course_01_data> createState() => _Course_01_dataState();
// }

// class _Course_01_dataState extends State<Course_01_data> {
//   // Start of loading pdf file.......

//   int _pages = 0;
//   int _currentPage = 0;
//   String? _pdfPath;

//   @override
//   void initState() {
//     super.initState();
//     _downloadPdf();
//     // _loadFromFirebase();
//   }

// // load pdf file into firebase storage and than store the link into firebase firestore
//   // Future<void> _loadFromFirebase() async {
//   //   final storage = FirebaseStorage.instance;
//   //   final ref = storage
//   //       .ref()
//   //       .child('/courses/course_02/Faithfulness of God Part-2.pdf');
//   //   final url = await ref.getDownloadURL();

//   //   setState(() {
//   //     _pdfUrl = url;
//   //     _isLoading = false;
//   //   });
//   //   storePdfUrlInFirestore(url);
//   // }

//   // Future<void> storePdfUrlInFirestore(String pdfUrl) async {
//   //   try {
//   //     final firestore = FirebaseFirestore.instance;
//   //     final documentReference =
//   //         firestore.collection('Courses').doc('Course_02');

//   //     await documentReference.set({'pdf_02': pdfUrl});
//   //     print('PDF URL stored in Firestore successfully.');
//   //   } catch (error) {
//   //     print('Error storing PDF URL in Firestore: $error');
//   //   }
//   // }

//   // Ending of loading pdf file.......

//   // final firestore =
//   //     FirebaseFirestore.instance.collection("Courses").snapshots();
//   // DatabaseReference ref = FirebaseDatabase.instance.ref('/Course_01');

//   Future<void> _downloadPdf() async {
//     final pdfFile = await DefaultCacheManager().getSingleFile(widget.pdfUrl);
//     setState(() {
//       _pdfPath = pdfFile.path;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);

//     return Scaffold(
//       backgroundColor: appPrimaryColor,
//       body: Center(
//         child: Container(
//           padding: const EdgeInsets.all(20.0),
//           width: mediaQuery.size.width * 0.9,
//           height: mediaQuery.size.height * 0.95,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(32),
//             color: Colors.white,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Row(
//                 children: [
//                   Image.asset(
//                     'assets/logo.png',
//                     width: mediaQuery.size.width * 0.15,
//                   ),
//                   const SizedBox(width: 20),
//                   // Expanded(
//                   Text(
//                     'Course_01',
//                     style: TextStyle(
//                       color: appPrimaryColor,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Calibri',
//                       fontSize: 35,
//                     ),
//                     textAlign: TextAlign.left,
//                     textDirection: TextDirection.ltr,
//                   ),
//                 ],
//               ),

//               // add the elevatedButton in the column

//               const SizedBox(
//                 height: 20,
//                 width: 20,
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.9,
//                 height: MediaQuery.of(context).size.height * 0.8,
//                 child: Column(
//                   children: [
//                     // Use the get() method to retrieve the document data
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: FutureBuilder<
//                             DocumentSnapshot<Map<String, dynamic>>>(
//                           future: FirebaseFirestore.instance
//                               .collection('Courses')
//                               .doc('Course_01')
//                               .get(),
//                           builder: (context, snapshot) {
//                             if (snapshot.hasData && snapshot.data != null) {
//                               final documentData = snapshot.data!.data();
//                               final fieldValue = documentData!['content'];
//                               return Text(
//                                 fieldValue,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Gulzar-Regular',
//                                   fontSize: 12,
//                                 ),
//                                 textAlign: TextAlign.right,
//                                 textDirection: TextDirection.rtl,
//                               );
//                             } else if (snapshot.hasError) {
//                               return Text(
//                                   'Error retrieving document: ${snapshot.error}');
//                             } else {
//                               return const Text('Loading...');
//                             }
//                           },
//                         ),
//                       ),
//                     ),

//                     Expanded(
//                       child: _pdfPath != null
//                           ? PDFView(
//                               filePath: _pdfPath!,
//                               autoSpacing: false,
//                               onPageChanged: (int? page, int? total) {
//                                 setState(() {
//                                   _currentPage = page!;
//                                   _pages = total!;
//                                 });
//                               },
//                               onRender: (_pages) {},
//                               onError: (error) {
//                                 print(error);
//                                 // Handle error while loading PDF
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) => AlertDialog(
//                                     title: const Text('Error'),
//                                     content: Text('Failed to load PDF: $error'),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: const Text('OK'),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             )
//                           : const Center(child: CircularProgressIndicator()),
//                     ),

//                     const SizedBox(
//                       height: 10,
//                       width: 10,
//                     ),

//                     // add the elevatedButton

//                     const ModelBottomSheet(),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../constants/colors.dart';
import 'model_bottom_sheet/c1_bottom_sheet.dart';

class Course_01_data extends StatefulWidget {
  final auth = FirebaseAuth.instance;
  final String pdfUrl =
      "https://firebasestorage.googleapis.com/v0/b/pbcs-bible-course-81b4b.appspot.com/o/courses%2Fcourse_01%2FTLPP%20Text%20only%20Unicode%20complete.pdf?alt=media&token=34b78844-4a7b-4d37-9330-7691be96a41d";

  Course_01_data({super.key});

  @override
  State<Course_01_data> createState() => _Course_01_dataState();
}

class _Course_01_dataState extends State<Course_01_data> {
  int _pages = 0;
  int _currentPage = 0;
  String? _pdfPath;
  String? _fieldValue;

  @override
  void initState() {
    super.initState();
    _downloadPdf();
    _fetchDocumentData();
  }

  Future<void> _downloadPdf() async {
    final pdfFile = await DefaultCacheManager().getSingleFile(widget.pdfUrl);
    setState(() {
      _pdfPath = pdfFile.path;
    });
  }

  Future<void> _fetchDocumentData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Courses')
          .doc('Course_01')
          .get();

      if (snapshot.exists) {
        final documentData = snapshot.data();
        setState(() {
          _fieldValue = documentData?['content'];
        });
      }
    } catch (error) {
      print('Error fetching document data: $error');
    }
  }

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: mediaQuery.size.width * 0.15,
                  ),
                  const SizedBox(width: 20),
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
              // const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.80,
                child: Column(
                  children: [
                    // Use the get() method to retrieve the document data
                    Expanded(
                      child: _pdfPath != null
                          ? PDFView(
                              filePath: _pdfPath!,
                              autoSpacing: false,
                              onPageChanged: (int? page, int? total) {
                                setState(() {
                                  _currentPage = page!;
                                  _pages = total!;
                                });
                              },
                              onRender: (pages) {},
                              onError: (error) {
                                // print(error);
                                // Handle error while loading PDF
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Error'),
                                    content: Text('Failed to load PDF: $error'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : const Center(child: CircularProgressIndicator()),
                    ),

                    const CourseOneModelBottomSheet(),
                  ],
                ),
              )
              // Container(
              //   width: MediaQuery.of(context).size.width * 0.9,
              //   height: MediaQuery.of(context).size.height * 0.8,
              //   child: Column(
              //     children: [
              //       Expanded(
              //         child: SingleChildScrollView(
              //           child: _fieldValue != null
              //               ? Text(
              //                   _fieldValue!,
              //                   style: const TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     fontFamily: 'Gulzar-Regular',
              //                     fontSize: 12,
              //                   ),
              //                   textAlign: TextAlign.right,
              //                   textDirection: TextDirection.rtl,
              //                 )
              //               : const Text(
              //                   'No data available.',
              //                   style: TextStyle(
              //                     fontStyle: FontStyle.italic,
              //                     color: Colors.grey,
              //                   ),
              //                 ),
              //         ),
              //       ),
              //       Expanded(
              //         child: _pdfPath != null
              //             ? PDFView(
              //                 filePath: _pdfPath!,
              //                 autoSpacing: false,
              //                 onPageChanged: (int? page, int? total) {
              //                   setState(() {
              //                     _currentPage = page!;
              //                     _pages = total!;
              //                   });
              //                 },
              //                 onRender: (_pages) {},
              //                 onError: (error) {
              //                   print(error);
              //                   showDialog(
              //                     context: context,
              //                     builder: (context) => AlertDialog(
              //                       title: const Text('Error'),
              //                       content: Text('Failed to load PDF: $error'),
              //                       actions: [
              //                         TextButton(
              //                           onPressed: () {
              //                             Navigator.pop(context);
              //                           },
              //                           child: const Text('OK'),
              //                         ),
              //                       ],
              //                     ),
              //                   );
              //                 },
              //               )
              //             : const Center(child: CircularProgressIndicator()),
              //       ),
              //       const SizedBox(height: 10),
              //       const ModelBottomSheet(),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
