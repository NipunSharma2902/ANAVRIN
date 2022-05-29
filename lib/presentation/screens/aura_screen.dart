// ignore_for_file: unused_element, camel_case_types, prefer_const_constructors_in_immutables, prefer_const_constructors, unused_import
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:anavrin/presentation/widgets/mytextfield.dart';


final Map<String, dynamic> _question={
  "question": "Hello guys"
};



Future<Reply> createReply(String question) async {
  final response = await http.post(
    Uri.parse('https://chatbot-aurora.herokuapp.com/chatbot?question='+_question["question"],),
  );

    return Reply.fromJson(jsonDecode(response.body));
}

class Reply {
  final String reply;

  const Reply({required this.reply});

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      reply: json['response'],
    );
  }
}



final TextEditingController _controller = TextEditingController();
  Future<Reply>? _futureReply;








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
          buildFutureBuilder(),
        ],
      ),
      bottomNavigationBar:buildChatInputWidget(context),
        
    );
  }
  FutureBuilder<Reply> buildFutureBuilder() {
  return FutureBuilder<Reply>(
      future: _futureReply,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.reply);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
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
            child: ElevatedButton(
          onPressed: () {
            if (_controller.text == null) {
              _controller.text=='Hello';
            }
            _futureReply = createReply(_controller.text);
          },
          child: const Text('Send'),
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
