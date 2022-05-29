// ignore_for_file: unused_element, camel_case_types, prefer_const_constructors_in_immutables, prefer_const_constructors, unused_import
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:anavrin/presentation/widgets/mytextfield.dart';








Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int id;
  final String title;

  const Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}












class aura extends StatefulWidget {
  aura({Key? key, user}) : super(key: key);

  @override
  State<aura> createState() => _auraState();
}

class _auraState extends State<aura> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5B61B9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF5B61B9),
        title: buildTitleWidget(context),
        elevation: 0,
      ),
      body: Column(
        children: [
          buildContactInformationWidget(),
        ],
      ),
      bottomNavigationBar: buildChatInputWidget(context),
    );
  }
}

Widget buildTitleWidget(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: const Text(
          "Back",
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Metropolis Regular',
            fontWeight: FontWeight.w400,
            color: Colors.white54,
          ),
        ),
      ),
    ],
  );
}

Widget buildChatInputWidget(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 18,
    ),
    color: Colors.white,
    child: Container(
      padding: const EdgeInsets.only(
        left: 20,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F8),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                // ignore: todo
                // TODO:
              },
              decoration: const InputDecoration.collapsed(
                hintText: "Type your message...",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF5B61B9),
              ),
              child: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildContactInformationWidget() {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 32,
      horizontal: 16,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Padding(
          padding: EdgeInsets.only(right: 24.0),
          child: SizedBox(
            width: 200.0,
            child: Text(
              "AURORA",
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'Metropolis Black',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                wordSpacing: 1.1,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
