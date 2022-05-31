// ignore_for_file: unnecessary_null_comparison, prefer_typing_uninitialized_variables, camel_case_types, avoid_unnecessary_containers, avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:anavrin/shared/constants/strings.dart';
import 'package:http/http.dart' as http;
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';


Map<String, dynamic> _question={
  "question": "Hello guys"
};


var messages = <Map<String, dynamic>>[];





Future<Reply> createReply() async {
  final response = await http.post(
    Uri.parse('https://chatbot-aurora.herokuapp.com/chatbot?question='+_question["question"],),
  );
  var repl = Reply.fromJson(jsonDecode(response.body));
    messages.insert(0, {"data": 0, "message": repl.reply});
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

class Question {
  final String question;
  const Question({required this.question});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
    );
  }
  
}


final TextEditingController _controller = TextEditingController();
  
  Future<Question>? _futureQuestion;








class aura extends StatefulWidget {
  const aura({Key? key, user}) : super(key: key);

  @override
  State<aura> createState() => _auraState();
}

class _auraState extends State<aura> {
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(40),
                  ),
        ),
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF5B61B9),
        title: Row(children: [
          buildTitleWidget(context),
        buildContactInformationWidget(),
        ],
        ),
        elevation: 10,
      ),
      body: 
      Container(

      child: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) => chat(
                messages[index]["message"].toString(),
                messages[index]["data"]
              )
          ),  
        ),



Container(
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
            child: TextFormField(
              controller: _controller,
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
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF5B61B9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
              ),
          onPressed: () {
            setState(() {
              
            if (_controller.text.isEmpty) {
              print("Please insert a vlaid message");
            }
            else{
              _futureQuestion?.then((question) => _controller.text);

              _question={
                "question":_controller.text
              };

              messages.insert(0, {"data": 1, "message": _controller.text});
              messages[0]["message"]=_controller.text;
              createReply().whenComplete(() => setState(() {
                
              }));
              _controller.clear();
            }
            
            });
            
          },
          
          child: const Icon(Icons.send),
        ),
          ),
        ],
      ),
    ),
  ),




        ],
      ),
      ),
      
        
    );
  }
}












Widget chat(String message, int data) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),

      child: Row(
          mainAxisAlignment: data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [


        Padding(
        padding: const EdgeInsets.all(10.0),
        child: Bubble(
            radius: const Radius.circular(15.0),
            color: data == 0 ? const Color.fromRGBO(23, 157, 139, 1) : Colors.orangeAccent,
            elevation: 0.0,

            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  const SizedBox(
                    width: 10.0,
                  ),
                  Flexible(
                      child: Container(
                        constraints: const BoxConstraints( maxWidth: 200),
                        child: Text(
                          message,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              ),
            )),
      ),


          ],
        ),
    );
  }




Widget buildTitleWidget(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: const Icon(Icons.arrow_back_ios),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Padding(
          padding: EdgeInsets.only(left: 65) ,
          child: SizedBox(
            width: 200.0,
            child: Text(
              "AURORA",
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.normal,
                color: Colors.white,
                wordSpacing: 1.1,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ],
    ),
  );









}
