// ignore_for_file: camel_case_types
import 'package:anavrin/data/models/note_model.dart';
import 'package:anavrin/presentation/screens/addjournal_screen.dart';
import 'package:anavrin/presentation/screens/my_homepage.dart';
import 'package:anavrin/presentation/widgets/myindicator.dart';
import 'package:anavrin/shared/constants/assets_path.dart';
import 'package:animate_do/animate_do.dart';
import 'package:sizer/sizer.dart';
import '../../data/repositories/firestore_crud.dart';
import '../../shared/constants/consts_variables.dart';
import '../widgets/note_container.dart';
import 'aura_screen.dart';
import 'package:flutter/material.dart';

class journal extends StatefulWidget {
  const journal({Key? key}) : super(key: key);

  @override
  State<journal> createState() => _journalState();
}

class _journalState extends State<journal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF5B61B9),
        title: buildTitleWidget(context),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
            stream: FireStoreCrud().getNote(),
            builder: (BuildContext context,
                AsyncSnapshot<List<NoteModel>> snapshot) {
              if (snapshot.hasError) {
                return _nodatawidget();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const MyCircularIndicator();
              }
              return snapshot.data!.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var note = snapshot.data![index];
                        Widget _notecontainer = noteContainer(
                          id: note.id,
                          color: colors[note.colorindex],
                          title: note.title,
                          note: note.note,
                        );
                        return InkWell(
                            onTap: () {},
                            child: index % 2 == 0
                                ? BounceInLeft(
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    child: _notecontainer)
                                : BounceInRight(
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    child: _notecontainer));
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
            'There\'s Nothing Here',
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
        color: Color(0xFF5B61B9),
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
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
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
      InkWell(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Addjournal_screen())),
        child: const Text(
          "Add",
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
