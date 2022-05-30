// ignore_for_file: unused_element, camel_case_types, prefer_const_constructors_in_immutables, prefer_const_constructors, unused_import
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:anavrin/presentation/widgets/mytextfield.dart';


Map<String, dynamic> _question={
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
          Expanded(child: buildFutureBuilder(),
          ),
          buildSenderMessage("Hello"),
          buildChatInputWidget(context),
        ],
      ),
      
        
    );
  }


Widget buildRecieverMessage(String answer) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          width: 10,
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
          ),
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  margin: const EdgeInsets.only(
                    right: 50,
                    top: 10,
                    bottom: 10,
                    left: 10,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Text(
                    answer,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Metropolis Regular',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }







  FutureBuilder<Reply> buildFutureBuilder() {
  return FutureBuilder<Reply>(
      future: _futureReply,
      builder: (context, snapshot) {
        String message='It\'s kinda working';
        Text answer;

        if (snapshot.hasData) {
          answer = Text(snapshot.data!.reply);
          return Text(snapshot.data!.reply);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36.0),
          topRight: Radius.circular(36.0),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(36.0),
          topRight: Radius.circular(36.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
          child: buildRecieverMessage(message),
          ),

        ),
      
    );
    
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
            _question={
              "question":_controller.text
            };
            MaterialPageRoute(builder: (context) => buildSenderMessage(_controller.text));
          },
          child: const Text('Send'),
        ),
          ),
        ],
      ),
    ),
  );
}

Widget buildSenderMessage(String text) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            margin: const EdgeInsets.only(
              right: 10,
              top: 10,
              bottom: 10,
              left: 300,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFFEDEEF7),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                topLeft: Radius.circular(40.0),
                bottomLeft: Radius.circular(40.0),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14.0,
                fontFamily: 'Metropolis Regular',
              ),
            ),
          ),
        ),
      ],
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
