import 'package:anavrin/data/models/task_model.dart';
import 'package:anavrin/presentation/screens/my_homepage.dart';
import 'package:anavrin/presentation/widgets/myindicator.dart';
import 'package:anavrin/shared/constants/assets_path.dart';
import 'package:animate_do/animate_do.dart';
//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:anavrin/presentation/screens/my_homepage.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../data/repositories/firestore_crud.dart';
import '../../shared/constants/consts_variables.dart';
import '../widgets/task_container.dart';
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
          color: Color.fromARGB(255, 255, 255, 255),
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
        body:Column(children: [




                        Expanded(
                          child: StreamBuilder(
                        stream: FireStoreCrud().getTasks(mydate: 'currentdate',
                        ),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<TaskModel>> snapshot) {
                          if (snapshot.hasError) {
                            return _nodatawidget();
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const MyCircularIndicator();
                          }
                          return snapshot.data!.isNotEmpty
                              ? ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    var task = snapshot.data![index];
                                    Widget _taskcontainer = TaskContainer(
                                      id: task.id,
                                      color: colors[task.colorindex],
                                      title: task.title,
                                      starttime: task.starttime,
                                      endtime: task.endtime,
                                      note: task.note,
                                    );
                                    return InkWell(
                                        onTap: () {},
                                        child: index % 2 == 0
                                            ? BounceInLeft(
                                                duration: const Duration(
                                                    milliseconds: 1000),
                                                child: _taskcontainer)
                                            : BounceInRight(
                                                duration: const Duration(
                                                    milliseconds: 1000),
                                                child: _taskcontainer));
                                  },
                                )
                              : _nodatawidget();
                        },
                      )),


          ],
        ),
        bottomNavigationBar: buildMyNavBar(context),
      );
            
  }












Widget _nodatawidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            MyAssets.clipboard,
            height: 30.h,
          ),
          SizedBox(height: 3.h),
          Text(
            'You\'re All Set',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontSize: 16.sp),
          ),
        ],
      ),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => aura()),                
                  );            
                }
              );
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



      
            