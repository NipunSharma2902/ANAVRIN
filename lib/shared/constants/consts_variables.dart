import 'package:flutter/material.dart';
import 'package:anavrin/data/models/onboarding_model.dart';
import 'package:anavrin/shared/constants/assets_path.dart';
import 'package:anavrin/shared/styles/colors.dart';

List<OnBoardingModel> onboardinglist = const [
  OnBoardingModel(
    img: MyAssets.onboradingone,
    title: 'Manage Your Tasks',
    description: 'Structure and plan your day with Anavrin.',
  ),
  OnBoardingModel(
    img: MyAssets.onboradingtwo,
    title: 'Reflect on Your Day',
    description: 'Journal everyday to keep inventory of your thoughts.',
  ),
  OnBoardingModel(
    img: MyAssets.onboradingthree,
    title: 'Talk to Aurora ',
    description: 'A chatbot to help with your mental health queries.',
  ),
];

const List<Color> colors = [Appcolors.blue, Appcolors.pink, Appcolors.yellow];

const List<String> profileimages = [
  MyAssets.profileicon1,
  MyAssets.profileicon2,
  MyAssets.profileicon3,
  MyAssets.profileicon4,
];

int profileimagesindex = 0;
