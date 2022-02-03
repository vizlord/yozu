import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yozu_ai/screens/dashboard.dart';

import '../../main.dart';
import 'PasswordResetScreen.dart';
import 'createAccountScreen.dart';

class Login extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> with TickerProviderStateMixin {
  AnimationController controller1;
  AnimationController controller2;
  Animation<double> animation1;
  Animation<double> animation2;
  Animation<double> animation3;
  Animation<double> animation4;

  final FirebaseAuth _auth = FirebaseAuth.instance;
// Async function that calls getSharedPreferences
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final databaseReference = Firestore.instance;
  ProgressDialog pr;

  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 5,
      ),
    );
    animation1 = Tween<double>(begin: .1, end: .15).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });
    animation2 = Tween<double>(begin: .02, end: .04).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
      setState(() {});
    });

    controller2 = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 5,
      ),
    );
    animation3 = Tween<double>(begin: .41, end: .38).animate(CurvedAnimation(
      parent: controller2,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });
    animation4 = Tween<double>(begin: 170, end: 190).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
      setState(() {});
    });

    Timer(Duration(milliseconds: 2500), () {
      controller1.forward();
    });

    controller2.forward();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(
        message: 'Signing User...', borderRadius: 10.0, backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(), elevation: 10.0, insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600)
    );
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      key: _formKey,
      backgroundColor: Color(0xff192028),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                Positioned(
                  top: size.height * (animation2.value + .58),
                  left: size.width * .21,
                  child: CustomPaint(
                    painter: MyPainter(50),
                  ),
                ),
                Positioned(
                  top: size.height * .98,
                  left: size.width * .1,
                  child: CustomPaint(
                    painter: MyPainter(animation4.value - 30),
                  ),
                ),
                Positioned(
                  top: size.height * .5,
                  left: size.width * (animation2.value + .8),
                  child: CustomPaint(
                    painter: MyPainter(30),
                  ),
                ),
                Positioned(
                  top: size.height * animation3.value,
                  left: size.width * (animation1.value + .1),
                  child: CustomPaint(
                    painter: MyPainter(60),
                  ),
                ),
                Positioned(
                  top: size.height * .1,
                  left: size.width * .8,
                  child: CustomPaint(
                    painter: MyPainter(animation4.value),
                  ),
                ),

                Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(top: size.height * .1),
                        child: Text(
                          'YOZU',
                          style: TextStyle(
                            color: Colors.white.withOpacity(.7),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            wordSpacing: 4,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaY: 15,
                                sigmaX: 15,
                              ),
                              child: Container(
                                height: size.width / 8,
                                width: size.width / 1.2,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(right: size.width / 30),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.05),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: TextField(
                                  controller: _emailController,
                                  style: TextStyle(color: Colors.white.withOpacity(.8)),
                                  cursorColor: Colors.white,
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Colors.white.withOpacity(.7),
                                    ),
                                    border: InputBorder.none,
                                    hintMaxLines: 1,
                                    hintText: "Email",
                                    hintStyle:
                                    TextStyle(fontSize: 14, color: Colors.white.withOpacity(.5)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaY: 15,
                                sigmaX: 15,
                              ),
                              child: Container(
                                height: size.width / 8,
                                width: size.width / 1.2,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(right: size.width / 30),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.05),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: TextField(
                                  controller: _passwordController,
                                  style: TextStyle(color: Colors.white.withOpacity(.8)),
                                  cursorColor: Colors.white,
                                  obscureText: true,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Colors.white.withOpacity(.7),
                                    ),
                                    border: InputBorder.none,
                                    hintMaxLines: 1,
                                    hintText: "Password...",
                                    hintStyle:
                                    TextStyle(fontSize: 14, color: Colors.white.withOpacity(.5)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                                  child: InkWell(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: _signInWithEmailAndPassword,
                                    child: Container(
                                      height: size.width / 8,
                                      width: size.width / 2.58,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(.05),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                        "Login",
                                        style: TextStyle(color: Colors.white.withOpacity(.8)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width / 20),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                                  child: InkWell(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => PassReset(),));
                                    },
                                    child: Container(
                                      height: size.width / 8,
                                      width: size.width / 2.58,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(.05),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                        'Forgotten password!',
                                        style: TextStyle(color: Colors.white.withOpacity(.8)),
                                      ),
                                    ),
                                  ),
                                ),
                              )

                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(

                      flex: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: (){
                                  HapticFeedback.lightImpact();
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpPage(),));
                                },
                                child: Container(
                                  height: size.width / 8,
                                  width: size.width / 2,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(.05),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    'Create a new Account',
                                    style: TextStyle(color: Colors.white.withOpacity(.8)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * .05),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signInWithEmailAndPassword() async {
    DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm:ss");
    String date = dateFormat.format(DateTime.now());
    try {
      await pr.show();
      pr =  ProgressDialog(context,type: ProgressDialogType.Download, isDismissible: false, showLogs: false);
      // ignore: deprecated_member_use
      final  user = (await _auth.signInWithEmailAndPassword(email: _emailController.text.trim(),
        password: _passwordController.text.trim(),)).user;
      if (user.isEmailVerified) {
        Fluttertoast.showToast(msg: "Login successfully",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.teal,textColor: Colors.white);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('uid', user.uid);

        await pr.hide();


        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Dashboard()),);
      }
      else if(!user.isEmailVerified){
        await pr.hide();
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("OOPS!",style: TextStyle(color: Colors.white,fontSize: 20),),
                content: Text("Looks like you didn't confirm your mail yet",style: TextStyle(color: Colors.white,fontSize: 17),),
                actions: <Widget>[
                  FlatButton( onPressed: (){
                    Navigator.pop(context);
                  },
                    child: Text("Dismiss",style: TextStyle(color: Colors.white,fontSize: 17),),),
                  FlatButton(onPressed: () async {
                    Navigator.pop(context);
                    await user.sendEmailVerification();
                    Fluttertoast.showToast(msg: "Verification email send succesfully", gravity: ToastGravity.BOTTOM, toastLength: Toast.LENGTH_SHORT);
                  },child: Text("Confirm Now",style: TextStyle(color: Colors.white,fontSize: 17),),),
                ],
                elevation: 24.0,
                backgroundColor: Colors.blue,
              );
            }
        );
      }
      else {
        await pr.hide();
        // Fluttertoast.showToast(msg: "Some error occurd",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
        //     backgroundColor: Colors.teal,textColor: Colors.white);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("Error!",style: TextStyle(color: Colors.white,fontSize: 20),),
                content: Text("You credentials are incorrect. Please try again!",style: TextStyle(color: Colors.white,fontSize: 17),),
                actions: <Widget>[
                  FlatButton( onPressed: (){
                    Navigator.pop(context);
                  },
                    child: Text("Dismiss",style: TextStyle(color: Colors.white,fontSize: 17),),),

                ],
                elevation: 24.0,
                backgroundColor: Color(0xff0f4c81)   ,

              );
            }
        );

      }
    } catch (e) {
      await pr.hide();
      // Fluttertoast.showToast(msg: e.toString(),gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_LONG,
      //     backgroundColor: Colors.teal,textColor: Colors.white);
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Error!",style: TextStyle(color: Colors.white,fontSize: 20),),
              content: Text("You credentials are incorrect. Please try again!",style: TextStyle(color: Colors.white,fontSize: 17),),
              actions: <Widget>[
                FlatButton( onPressed: (){
                  Navigator.pop(context);
                },
                  child: Text("Dismiss",style: TextStyle(color: Colors.white,fontSize: 17),),),

              ],
              elevation: 24.0,
              backgroundColor: Color(0xff0f4c81)   ,

            );
          }
      );
    }

  }

}
