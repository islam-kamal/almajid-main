  import 'package:almajidoud/utils/file_export.dart';
  customAnimatedPushNavigation( BuildContext context , Widget screen ){
  return Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) {
        return screen ;
      },
      transitionsBuilder:
          (context, animation8, animation15, child) {
        return FadeTransition(
          opacity: animation8,
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 50),
    ),
  );
  }