// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:anavrin/data/repositories/firestore_crud.dart';

class noteContainer extends StatelessWidget {
  final String id;
  final Color color;
  final String title;
  final String note;

  const noteContainer({
    Key? key,
    required this.id,
    required this.color,
    required this.title,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      onDismissed: (direction) {
        FireStoreCrud().deleteNote(docid: id);
      },
      background: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerLeft,
      ),
      child: Container(
        width: 100.w,
        height: 20.h,
        margin: EdgeInsets.symmetric(vertical: 1.h),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
            ),
            Text(
              note,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
