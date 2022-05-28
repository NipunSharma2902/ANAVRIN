import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:anavrin/presentation/widgets/mytextfield.dart';

class aura extends StatefulWidget {
  aura({Key? key}) : super(key: key);

  @override
  State<aura> createState() => _auraState();
}

class _auraState extends State<aura> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.person,
          color: Colors.white,
        ),

        title: const Text(
          "Aura Is Here!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
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
                



                //WE CAN PUT THE POST COMMANDS HERE



              });
            },
            icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
        ],
      ),
    );


  }
}