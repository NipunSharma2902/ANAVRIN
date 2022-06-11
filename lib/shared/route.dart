import 'package:anavrin/presentation/screens/journal_content.dart';
import 'package:flutter/material.dart';
import 'package:anavrin/data/models/task_model.dart';
import 'package:anavrin/data/models/note_model.dart';
import 'package:anavrin/presentation/screens/addtask_screen.dart';
import 'package:anavrin/presentation/screens/login_page.dart';
import 'package:anavrin/presentation/screens/my_homepage.dart';
import 'package:anavrin/presentation/screens/onboarding.dart';
import 'package:anavrin/presentation/screens/signup_page.dart';
import 'package:anavrin/presentation/screens/welcome_page.dart';
import 'package:anavrin/shared/constants/strings.dart';

class AppRoute {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        {
          return MaterialPageRoute(builder: (_) => const OnboardingPage());
        }

      case welcomepage:
        {
          return MaterialPageRoute(builder: (_) => const WelcomePage());
        }

      case loginpage:
        {
          return MaterialPageRoute(builder: (_) => const LoginPage());
        }
      case signuppage:
        {
          return MaterialPageRoute(builder: (_) => const SignUpPage());
        }
      case homepage:
        {
          return MaterialPageRoute(builder: (_) => const MyHomePage());
        }
      case addtaskpage:
        {
          final task = settings.arguments as TaskModel?;
          return MaterialPageRoute(
              builder: (_) => AddTaskScreen(
                    task: task,
                  ));
        }
      case journal_cont:
      {
        final note = settings.arguments as NoteModel?;
          return MaterialPageRoute(
              builder: (_) => journal_content(  
                    note: note,
                  ));
      }
      default:
        throw 'No Page Found!!';
    }
  }
}
