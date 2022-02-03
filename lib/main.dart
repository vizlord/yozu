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

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomPaint(
        painter: BluePainter(),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              appBar(context),
              content(context),
              button(),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MaterialButton(
          onPressed: () {},
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 32.0,
          ),
        ),
        SizedBox(
          width: 48,
        ),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const <Widget>[
              SizedBox(
                height: 8,
              ),
              Text(
                "SLIME MONSTER",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  letterSpacing: 14,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget content(BuildContext context) {
    return Expanded(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, top: 32, bottom: 32),
          child: Row(
            children: <Widget>[
              Container(
                width: 140,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage('assets/board1.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 32, top: 48, bottom: 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(right: 32.0),
                        child: Text(
                          "Handmade skateboard desk with original painting from Mexico",
                          style: TextStyle(
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Divider(),
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        "S I Z E",
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption
                            .copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const Text(
                        "8\" x 32\"",
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text("M A T E R I A L",
                          style: Theme
                              .of(context)
                              .textTheme
                              .caption
                              .copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          )),
                      const Text(
                        "Canadian Maple",
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(),
                      ),
                      Container(
                        width: double.infinity,
                        height: 48,
                        color: Color(0xFFF1C929),
                        alignment: Alignment.centerLeft,
                        child: CustomPaint(
                          painter: DieCuttingPainter(),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              "\$240",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget button() {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50),
          topLeft: Radius.circular(50),
        ),
      ),
      child: FlatButton(
        onPressed: () {
          print("ACA");
        },
        child: Text(
          "ADD TO CART",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            letterSpacing: 10,
          ),
        ),
      ),
    );
  }
}
