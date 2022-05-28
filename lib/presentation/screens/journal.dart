import 'package:anavrin/presentation/screens/journal.dart';
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

class journal extends StatefulWidget {
  journal({Key? key}) : super(key: key);

  @override
  State<journal> createState() => _journalState();
}

class _journalState extends State<journal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:MultiBlocListener( listeners: [
          BlocListener<ConnectivityCubit, ConnectivityState>(
              listener: (context, state) {
            if (state is ConnectivityOnlineState) {
              MySnackBar.error(
                  message: 'You Are Online Now ',
                  color: Colors.green,
                  context: context);
            } else {
              MySnackBar.error(
                  message: 'Please Check Your Internet Connection',
                  color: Colors.red,
                  context: context);
            }
          }),
          BlocListener<AuthenticationCubit, AuthenticationState>(
            listener: (context, state) {
              if (state is UnAuthenticationState) {
                Navigator.pushNamedAndRemoveUntil(
                    context, welcomepage, (route) => false);
              }
            },
          )
        ],
            child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticationLoadingState) {
                  return const MyCircularIndicator();
                }



      return SafeArea(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              // NotificationsHandler.createNotification();
                            },
                            child: SizedBox(
                              height: 8.h,
                              child: Image.asset(
                                profileimages[profileimagesindex],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Expanded(
                            child: Text(
                              user.displayName != null
                                  ? 'Hello ${user.displayName}'
                                  : ' Hello $username',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(fontSize: 15.sp),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _showBottomSheet(context, authenticationCubit);
                            },
                            child: Icon(
                              Icons.settings,
                              size: 25.sp,
                              color: Appcolors.black,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),



                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            DateFormat('MMMM, dd').format(currentdate),
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(fontSize: 17.sp),
                          ),
                          const Spacer(),
                          MyButton(
                            color: Colors.deepPurple,
                            width: 40.w,
                            title: '+ Add Task',
                            func: () {
                              Navigator.pushNamed(
                                context,
                                addtaskpage,
                              );
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      _buildDatePicker(context, connectivitycubit),
                      SizedBox(
                        height: 4.h,
                      ),
                      Expanded(
                          child: StreamBuilder(
                        stream: FireStoreCrud().getTasks(
                          mydate: DateFormat('yyyy-MM-dd').format(currentdate),
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

      
    );
  }
}