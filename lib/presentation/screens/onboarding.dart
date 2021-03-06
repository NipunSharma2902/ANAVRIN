import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:anavrin/bloc/onboarding/onboarding_cubit.dart';
import 'package:anavrin/presentation/widgets/circular_button.dart';
import 'package:anavrin/presentation/widgets/custom_dots.dart';
import 'package:anavrin/presentation/widgets/mybutton.dart';
import 'package:anavrin/presentation/widgets/mycustompainter.dart';
import 'package:anavrin/presentation/widgets/onboarding_item.dart';
import 'package:anavrin/shared/constants/consts_variables.dart';
import 'package:anavrin/shared/constants/strings.dart';
import 'package:anavrin/shared/styles/colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5B61B9),
      body: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {},
        builder: (context, state) {
          OnboardingCubit cubit = BlocProvider.of(context);
          return SafeArea(
              child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                      width: 100.w,
                      height: 92.h,
                      color: Color(0xFF5B61B9),
                      ),
                  SizedBox(
                    width: 100.w,
                    height: 88.h,
                    child: CustomPaint(
                      painter: const MycustomPainter(color: Appcolors.white),
                      child: SizedBox(
                        width: 80.w,
                        height: 50.h,
                        child: PageView.builder(
                          itemCount: onboardinglist.length,
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          itemBuilder: ((context, index) {
                            return OnBoardingItem(
                              index: index,
                              image: onboardinglist[index].img,
                              title: onboardinglist[index].title,
                              description: onboardinglist[index].description,
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                  cubit.curruntindext != onboardinglist.length - 1
                      ? Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: MyButton(
                                color: Color(0xFF5B61B9),
                                width: 19.w,
                                title: 'Skip',
                                func: () {
                                  _pageController.animateToPage(
                                      onboardinglist.length - 1,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeOut);
                                  cubit.curruntindext <
                                          onboardinglist.length - 1
                                      ? cubit.skipindex()
                                      : null;
                                }),
                          ))
                      : Container(),
                  Positioned(
                    bottom: 9.h,
                    child: CircularButton(
                        color: Appcolors.pink.withOpacity(0.6),
                        width: 30.w,
                        icon: Icons.arrow_right_alt_sharp,
                        condition:
                            cubit.curruntindext != onboardinglist.length - 1,
                        func: () {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                          if (cubit.curruntindext < onboardinglist.length - 1) {
                            cubit.changeindex();
                          } else {
                            Navigator.pushReplacementNamed(
                                context, welcomepage);
                            cubit.savepref('seen');
                          }
                        }),
                  ),
                ],
              ),
            ],
          ));
        },
      ),
    );
  }
}
