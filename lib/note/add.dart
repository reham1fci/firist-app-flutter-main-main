import 'package:betakety_app/view/base/custom_password_textfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  AddNotes() async {
    //var response = await post(url)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add Note"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            CustomPasswordTextField(
              hintTxt: "Title",
            )
          ],
        ),
      ),
    );
  }
}
