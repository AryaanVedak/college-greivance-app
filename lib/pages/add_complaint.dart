import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddComplaint extends StatefulWidget {
  const AddComplaint({super.key});

  @override
  State<AddComplaint> createState() => _AddComplaintState();
}

class _AddComplaintState extends State<AddComplaint> {
  final _complaintTitle = TextEditingController();
  final _complaintContent = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _complaintTitle.dispose();
    _complaintContent.dispose();
  }

  postComplaint() async {
    await addComplaintDetails(
      _complaintTitle.text.trim(),
      _complaintContent.text.trim(),
    );
    Navigator.pop(context);
  }

  Future addComplaintDetails(
      String complaintTitle, String complaintContent) async {
    await FirebaseFirestore.instance.collection('complaints').add({
      'title': complaintTitle,
      'description': complaintContent,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Top-G",
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          MaterialButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            color: null,
            child: Text(
              'Sign Out',
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),

            // Heading of our page
            Center(
              child: Text(
                "Add Complaint",
                style: GoogleFonts.poppins(
                    fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Title",
                  style: GoogleFonts.poppins(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            // Title text Field
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: TextField(
                      controller: _complaintTitle,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter title',
                          hintStyle: GoogleFonts.poppins(fontSize: 22)),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Complaint",
                  style: GoogleFonts.poppins(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            // Title text Field
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      controller: _complaintContent,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter complaint',
                          hintStyle: GoogleFonts.poppins(fontSize: 22)),
                      keyboardType: TextInputType.multiline,
                      minLines: 1, // <-- SEE HERE
                      maxLines: 5,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 40,
            ),

            // Submit button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: InkWell(
                onTap: postComplaint,
                // child: InkWell(
                //   onTap: (() {
                //     Navigator.pop(context);
                //   }),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Center(
                      child: Text(
                        'Submit',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // ),
          ],
        ),
      ),
    );
  }
}
