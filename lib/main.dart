import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yozu_ai/screens/dashboard.dart';
import 'package:yozu_ai/screens/authentication/loginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var uid = prefs.getString('uid');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  print(uid);
  runApp(
    MaterialApp(
      key: _formKey,
    title: 'Yozu ai',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: YozuAppTheme.theme,
    ),
    home: uid == null
        ? Login()
        : Dashboard(uid: uid,),
  ));
}

class MyPainter extends CustomPainter {
  final double radius;

  MyPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
          colors: [Color(0xffFD5E3D), Color(0xffC43990)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight)
          .createShader(Rect.fromCircle(
        center: Offset(0, 0),
        radius: radius,
      ));

    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class YozuAppTheme {
  YozuAppTheme._();
  static const MaterialColor theme = MaterialColor(
    0xFF5252A4,
    <int, Color>{
      50: const Color(0xFF0E7AC7),
      100: const Color(0xFF0E7AC7),
      200: const Color(0xFF0E7AC7),
      300: const Color(0xFF0E7AC7),
      400: const Color(0xFF0E7AC7),
      500: const Color(0xFF0E7AC7),
      600: const Color(0xFF0E7AC7),
      700: const Color(0xFF0E7AC7),
      800: const Color(0xFF0E7AC7),
      900: const Color(0xFF0E7AC7),
    },
  );
}

class BluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    paint.color = Colors.lightBlueAccent;

    final Rect rect = Rect.fromLTWH(0, 0, size.width * 0.25, size.height);

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class DieCuttingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    paint.color = Colors.white;
    paint.strokeWidth = 20;
    paint.style = PaintingStyle.fill;

    var x = size.height / 6;

    var path = Path();
    path.moveTo(0, -2 * x);

    for (var i = 0; i < 5; i++) {
      path.relativeLineTo(x, x);
      path.relativeLineTo(-x, x);
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
