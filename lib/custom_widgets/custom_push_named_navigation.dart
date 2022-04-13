  import 'package:almajidoud/utils/file_export.dart';
  customPushNamedNavigation( BuildContext? context , Widget? screen ){
  return Navigator.pushReplacement(
    context!,
    PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) {
        return screen! ;
      },
      transitionsBuilder:
          (context, animation8, animation15, child) {
        return FadeTransition(
          opacity: animation8,
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 100),
    ),
  );
  }