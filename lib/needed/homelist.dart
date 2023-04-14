import 'package:vnr_connect/design_course/home_design_course.dart';
import 'package:flutter/widgets.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_vnr_student/home_clubs.dart';
import 'package:vnr_connect/screens/fests.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  Widget? navigateScreen;
  String imagePath;

  static List<HomeList> homeList = [
    
    
    HomeList(
      imagePath: 'assets/design_course/fests.png',
      navigateScreen: const Fests(),
    ),

    HomeList(
      imagePath: 'assets/design_course/clubs.png',
      navigateScreen: const HomeClubs(),
    ),
    HomeList(
      imagePath: 'assets/design_course/student_chapters.png',
      navigateScreen: const HomeClubs(),
    ),
  ];
}
