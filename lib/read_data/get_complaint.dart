import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetUserComplaint extends StatelessWidget {
  final String documentId;

  const GetUserComplaint({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    // get the collection
    CollectionReference complaints =
        FirebaseFirestore.instance.collection('complaints');
    return FutureBuilder<DocumentSnapshot>(
      future: complaints.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${data['title']}',
                  style: GoogleFonts.roboto(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${data['description']}',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          );
        }
        return Text('Loading...');
      },
    );
  }
}
