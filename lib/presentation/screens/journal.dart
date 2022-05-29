import 'package:anavrin/presentation/screens/my_homepage.dart';
//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:anavrin/presentation/screens/my_homepage.dart';
import 'aura_screen.dart';
import 'package:flutter/material.dart';

class journal extends StatefulWidget {
  journal({Key? key}) : super(key: key);

  @override
  State<journal> createState() => _journalState();
}

class _journalState extends State<journal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu_book_outlined,
          color: Colors.white,
        ),
        title: const Text(
          "Journal Mode",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      //body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(
        bottom: 10,
        left: 50,
        right: 50,
      ),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
        color: Color.fromARGB(255, 111, 12, 198),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              });
            },
            icon: const Icon(
              Icons.calendar_month,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => aura()),
                );
              });
            },
            icon: const Icon(
              Icons.chat_bubble_outline_rounded,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(
              Icons.book_outlined,
              color: Color.fromARGB(255, 21, 170, 234),
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}
