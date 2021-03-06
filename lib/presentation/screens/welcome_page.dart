import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:anavrin/bloc/auth/authentication_cubit.dart';
import 'package:anavrin/bloc/connectivity/connectivity_cubit.dart';
import 'package:anavrin/presentation/widgets/mybutton.dart';
import 'package:anavrin/presentation/widgets/myindicator.dart';
import 'package:anavrin/shared/constants/assets_path.dart';
import 'package:anavrin/shared/constants/strings.dart';
import 'package:anavrin/shared/styles/colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationCubit authcubit = BlocProvider.of(context);
    ConnectivityCubit connectivitycubit = BlocProvider.of(context);
    return Scaffold(
      backgroundColor: Appcolors.white,
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccessState) {
            Navigator.pushReplacementNamed(context, homepage);
          }
        },
        builder: (context, state) {
          if (state is AuthenticationLoadingState) {
            return const MyCircularIndicator();
          }

          if (state is! AuthenticationSuccessState) {
            return SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BounceInDown(
                      duration: const Duration(milliseconds: 1500),
                      child: Image.asset(
                        MyAssets.welcomesketch,
                        height: 200,
                        width: 200,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      'Hello !',
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          ?.copyWith(letterSpacing: 3),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      'Welcome to ANAVRIN',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            letterSpacing: 3,
                            fontSize: 10.sp,
                            wordSpacing: 2,
                          ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    MyButton(
                      color: Color(0xFF5B61B9),
                      width: 80.w,
                      title: 'Login',
                      func: () {
                        Navigator.pushNamed(context, loginpage);
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    MyButton(
                      color: Color(0xFF5B61B9),
                      width: 80.w,
                      title: 'Sign Up',
                      func: () {
                        Navigator.pushNamed(context, signuppage);
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    _myOutlinedButton(context, authcubit, connectivitycubit),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Container _myOutlinedButton(BuildContext context, AuthenticationCubit cubit,
      ConnectivityCubit connectivityCubit) {
    return Container(
      width: 80.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          border: Border.all(color: Color(0xFF5B61B9), width: 2)),
      child: MaterialButton(
        onPressed: () {
          if (connectivityCubit.state is ConnectivityOnlineState) {
            cubit.signinanonym();
          } else {}
        },
        child: Center(
          child: Text(
            'Register Later',
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  fontSize: 11.sp,
                  color: Color(0xFF5B61B9),
                ),
          ),
        ),
      ),
    );
  }
}
