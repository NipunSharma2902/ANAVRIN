import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:anavrin/data/models/note_model.dart';
import 'package:anavrin/data/repositories/firestore_crud.dart';
import 'package:anavrin/presentation/widgets/mybutton.dart';
import 'package:anavrin/presentation/widgets/mytextfield.dart';
import 'package:anavrin/shared/constants/consts_variables.dart';
import 'package:anavrin/shared/styles/colors.dart';




// ignore: camel_case_types
class Addjournal_screen extends StatefulWidget {
  final NoteModel? note;

  const Addjournal_screen({
    this.note,
    Key? key,
  }) : super(key: key);

  @override
  State<Addjournal_screen> createState() => AddJournalScreenState();
}

class AddJournalScreenState extends State<Addjournal_screen> {
  get isEditMote => widget.note != null;

  late TextEditingController _titlecontroller;
  late TextEditingController _notecontroller;


  final _formKey = GlobalKey<FormState>();
  late int _selectedcolor;

  
  @override
  void initState() {
    super.initState();
    _titlecontroller =
        TextEditingController(text: isEditMote ? widget.note!.title : '');
    _notecontroller =
        TextEditingController(text: isEditMote ? widget.note!.note : '');
    _selectedcolor = isEditMote ? widget.note!.colorindex : 0;
  }

  @override
  void dispose() {
    super.dispose();
    _titlecontroller.dispose();
    _notecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: _buildform(context),
          ),
        ),
      ),
    );
  }

  Form _buildform(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.h,
          ),
          _buildAppBar(context),
          SizedBox(
            height: 3.h,
          ),
          Text(
            'Title',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontSize: 14.sp),
          ),
          SizedBox(
            height: 1.h,
          ),
          MyTextfield(
            hint: 'Enter Title',
            icon: Icons.title,
            showicon: false,
            validator: (value) {
              return value!.isEmpty ? "Please Enter A Title" : null;
            },
            textEditingController: _titlecontroller,
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            'Note',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontSize: 14.sp),
          ),
          SizedBox(
            height: 1.h,
          ),
          MyTextfield(
            hint: 'Enter Note',
            icon: Icons.ac_unit,
            showicon: false,
            maxlenght: 400,
            validator: (value) {
              return value!.isEmpty ? "Please Enter A Note" : null;
            },
            textEditingController: _notecontroller,
          ),
          
         
          Text(
            'Colors',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontSize: 14.sp),
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                children: List<Widget>.generate(
                    3,
                    (index) => Padding(
                          padding: EdgeInsets.only(right: 2.w),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedcolor = index;
                              });
                            },
                            child: CircleAvatar(
                                backgroundColor: colors[index],
                                child: _selectedcolor == index
                                    ? const Icon(
                                        Icons.done,
                                        color: Appcolors.white,
                                      )
                                    : null),
                          ),
                        )),
              ),
              MyButton(
                color: isEditMote ? Colors.green : Color(0xFF5B61B9),
                width: 40.w,
                title: isEditMote ? "Update Note" : 'Create Note',
                func: () {
                  _addnote();
                },
              )
            ],
          )
        ],
      ),
    );
  }

  _addnote() {
    if (_formKey.currentState!.validate()) {
      NoteModel note = NoteModel(
        title: _titlecontroller.text,
        note: _notecontroller.text,
        colorindex: _selectedcolor,
        id: '',
      );
      isEditMote
          ? FireStoreCrud().updateNote(
              docid: widget.note!.id,
              title: _titlecontroller.text,
              note: _notecontroller.text,
              colorindex: _selectedcolor,
            )
          : FireStoreCrud().addNote(note: note);

      
      
      Navigator.pop(context);
    }
  }


  Row _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left,
            size: 30.sp,
          ),
        ),
        Text(
          isEditMote ? 'Update Note' : 'Add Note',
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox()
      ],
    );
  }
}
