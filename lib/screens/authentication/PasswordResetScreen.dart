import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yozu_ai/screens/authentication/loginScreen.dart';
import '../../main.dart';
import 'Widget/bezierContainer.dart';

class PassReset extends StatefulWidget {
  @override
  _PassResetState createState() => _PassResetState();
}

class _PassResetState extends State<PassReset> with TickerProviderStateMixin {

  AnimationController controller1;
  AnimationController controller2;
  Animation<double> animation1;
  Animation<double> animation2;
  Animation<double> animation3;
  Animation<double> animation4;
  TextEditingController mail = new TextEditingController();

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                    SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Stack(
                          children: <Widget>[
                            // Positioned(
                            //     top: -MediaQuery.of(context).size.height * .15,
                            //     right: -MediaQuery.of(context).size.width * .4,
                            //     child: BezierContainer()),

                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(height: MediaQuery.of(context).size.height * .3),
                                    Container(
                                      padding: EdgeInsets.only(left: 6,top: 8),
                                      alignment: Alignment.topLeft,
                                      child: const Text("Registered Gmail:",style: TextStyle(fontSize: 20,color: Colors.white70,
                                          fontWeight: FontWeight.w600,fontFamily: "Roboto"),),
                                    ),
                                    Container(

                                      height: 50,
                                      alignment: Alignment.topLeft,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black26,

                                      ),
                                      margin: EdgeInsets.all(6),
                                      padding: EdgeInsets.only(left: 6),

                                      child:  TextField(
                                        controller: mail,
                                        style: const TextStyle(fontWeight: FontWeight.w600,fontFamily: "Roboto",fontSize: 18,color: Colors.white),
                                        decoration: const InputDecoration(border: InputBorder.none,hintText: "abc@gmail.com",hintStyle: TextStyle(color: Colors.white70)),
                                        //readOnly: true,
                                      ),
                                    ),
                                    const Text("Note: Password reset link will be send to your given GMail ",
                                      textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontFamily: "Roboto",fontWeight: FontWeight.w600,color: Colors.white70),),


                                    GestureDetector(
                                      onTap: () {
                                        HapticFeedback.lightImpact();
                                        try{
                                          if(mail.text!=""){
                                            FirebaseAuth.instance.sendPasswordResetEmail(email: mail.text.trim());
                                            Fluttertoast.showToast(msg: "Gmail sent successfully",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                                                backgroundColor: Colors.teal,textColor: Colors.white);
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login(),));

                                          }
                                        }catch(e)
                                        {
                                          Fluttertoast.showToast(msg:e.toString(),gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                                              backgroundColor: Colors.teal,textColor: Colors.white);

                                        }

                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                                            child: InkWell(

                                              highlightColor: Colors.transparent,
                                              splashColor: Colors.transparent,
                                              child: Container(
                                                height: size.width / 8,
                                                width: size.width / 2,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.white.withOpacity(.05),
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                child: Text(
                                                  'send',
                                                  style: TextStyle(color: Colors.white.withOpacity(.8)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                    ),

                                  ],
                                ),

                              ),
                            ),

                            Positioned(top: 10, left: 0, child: _backButton()),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: const Icon(Icons.keyboard_arrow_left, color: Colors.white),
            ),
            const Text('Back',
                style: TextStyle( color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

}


