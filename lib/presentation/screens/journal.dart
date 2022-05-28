import 'package:anavrin/presentation/screens/journal.dart';
import 'package:anavrin/presentation/screens/my_homepage.dart';
import 'package:animate_do/animate_do.dart';
//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:anavrin/bloc/auth/authentication_cubit.dart';
import 'package:anavrin/bloc/connectivity/connectivity_cubit.dart';
import 'package:anavrin/data/models/task_model.dart';
import 'package:anavrin/data/repositories/firestore_crud.dart';
import 'package:anavrin/presentation/widgets/mybutton.dart';
import 'package:anavrin/presentation/widgets/myindicator.dart';
import 'package:anavrin/presentation/widgets/mysnackbar.dart';
import 'package:anavrin/presentation/widgets/mytextfield.dart';
import 'package:anavrin/presentation/widgets/task_container.dart';
import 'package:anavrin/shared/constants/assets_path.dart';
import 'package:anavrin/shared/constants/consts_variables.dart';
import 'package:anavrin/shared/constants/strings.dart';
import 'package:anavrin/shared/services/notification_service.dart';
import 'package:anavrin/shared/styles/colors.dart';
import 'package:anavrin/presentation/screens/my_homepage.dart';





import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:anavrin/main.dart';
import 'package:anavrin/presentation/widgets/task_container.dart';
import 'package:anavrin/shared/constants/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anavrin/bloc/connectivity/connectivity_cubit.dart';
import 'package:anavrin/bloc/auth/authentication_cubit.dart';
import 'package:anavrin/presentation/widgets/myindicator.dart';
import 'package:anavrin/presentation/widgets/mysnackbar.dart';
import 'package:anavrin/shared/constants/consts_variables.dart';



 int pageIndex = 0;
  
  final pages = [
    const MyHomePage(),
    //const (),
    journal(),
  ];


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
        leading: Icon(
          Icons.book_online,
          color: Theme.of(context).primaryColor,
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.calendar_month_outlined,
                    color: Color.fromARGB(255, 21, 170, 234),
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
                    Icons.chat_bubble_rounded,
                    color: Color.fromARGB(255, 21, 170, 234),
                    size: 35,
                  )
                : const Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          
          IconButton(
            enableFeedback: false,
            
            onPressed: () {
              setState(() {
                
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
                    Icons.book,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
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



      
            