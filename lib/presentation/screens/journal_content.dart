import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:anavrin/data/models/note_model.dart';
import 'package:anavrin/shared/constants/consts_variables.dart';
import 'package:anavrin/shared/styles/colors.dart';

class journal_content extends StatefulWidget {
  final NoteModel? note;
  const journal_content({this.note, Key? key}) : super(key: key);

  @override
  State<journal_content> createState() => _journal_contentState();
}

class _journal_contentState extends State<journal_content> {


  final _formKey = GlobalKey<FormState>();
  late int _selectedcolor;

  @override
  void initState() {
    super.initState();
    _selectedcolor = widget.note!.colorindex;
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colors[_selectedcolor],
        //backgroundColor: Color(0xFF5B61B9),
        title: buildTitleWidget(context),
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: _displayform(context),
          ),
        ),
      ),
    );
  }

  Form _displayform(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.h,
          ),
          SizedBox(
            height: 3.h,
          ),
          Text(
            widget.note!.title,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontSize: 18.sp),
          ),
          SizedBox(
            height: 2.h,
          ),
          Divider(
            height: 2.h,
            thickness: 1,
            color: Colors.black,
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            widget.note!.note,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.black38,
                fontFamily: 'Metropolis',
                fontWeight: FontWeight.w200),
          ),
        ],
      ),
    );
  }
}

Widget buildTitleWidget(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back_ios_new)),
      const Padding(
        padding: EdgeInsets.only(left: 65),
      ),
      const Text("Your thoughts that day",
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w100,
            color: Colors.white,
            wordSpacing: 1.1,
            letterSpacing: 1.0,
          ))
    ],
  );
}
