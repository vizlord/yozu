import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yozu_ai/screens/dashboard.dart';
import '../../main.dart';
import 'loginScreen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
final TextEditingController _name1Controller = TextEditingController();
final TextEditingController _name2Controller = TextEditingController();
final TextEditingController _addresscontroler = TextEditingController();


class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {

  AnimationController controller1;
  AnimationController controller2;
  Animation<double> animation1;
  Animation<double> animation2;
  Animation<double> animation3;
  Animation<double> animation4;
  ProgressDialog pr;
  var image;
  StorageReference storageReference = FirebaseStorage.instance.ref();
  final databaseReference = Firestore.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
    AssetImage assetImage2 = AssetImage("assets/images/adduser.png");
    Image imagex = Image(
      image: assetImage2,
      height: 100,
      width: 100,
    );
    pr = new ProgressDialog(context);
    pr.style(
        message: 'Signing User...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600));

    final height = MediaQuery.of(context).size.height;

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _formKey,
      backgroundColor: Color(0xffccd5e3),
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

                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: height * .15),
                              _title(),
                              const SizedBox(
                                height: 50,
                              ),
                              Container(
                                //margin: EdgeInsets.only(top: 80),
                                height: 100,
                                width: 100,
                                child: GestureDetector(
                                    onTap: () {
                                      getImage(ImgSource.Both, context);
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      child:
                                      image != null ? Image.file(image) : imagex,
                                    )),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              _emailPasswordWidget(),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                  onTap: () {

                                    HapticFeedback.lightImpact();
                                    _register(image);

                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(const Radius.circular(5)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: Colors.grey.shade200,
                                              offset: Offset(2, 4),
                                              blurRadius: 5,
                                              spreadRadius: 2)
                                        ],
                                        gradient: const LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                             // Color(0xffcb71a8),
                                              Color(0xffe1e9ef),
                                              Color(0xffe1e9ef)
                                            ])),
                                    child: const Text(
                                      'Register Now',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black45,
                                          fontFamily: "Roboto"),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 30),
                              _loginAccountLabel(),
                            ],
                          ),
                        ),
                      ),
                      Positioned(top: 10, left: 0, child: _backButton()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _register(var images) async {
    await pr.show();
    pr = ProgressDialog(context,
        type: ProgressDialogType.Download,
        isDismissible: false,
        showLogs: false);
    var gmail = _emailController.text;
    var pass = _passwordController.text;
    var name1 = _name1Controller.text;
    var name2 = _name2Controller.text;
    var address = _addresscontroler.text;
    var phone = _phoneController.text;
    if (gmail != "" &&
        pass != "" &&
        name1 != "" &&
        name2 != "" &&
        images != null &&
        address != "" &&
        phone != "" &&
        phone.length == 10 &&
        pass.length >= 6) {
      try {
        final user = (await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ))
            .user;

        if (user != null) {
          Fluttertoast.showToast(
            msg: "Registered successfully",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
          );

          databaseReference
              .collection(user.uid)
              .document("PersonalInfo")
              .setData({
            'email': gmail,
            'password': pass,
            "phone": phone,
            "name1": name1,
            "name2": name2,
            "address": address,
            "profilePic": ""
          });
          databaseReference
              .collection(user.uid)
              .document("Posts")
              .collection("Postx")
              .document("zzzzz")
              .setData({
            'length': 0,
          });
          try {
            //CreateRefernce to path.
            StorageReference ref = storageReference.child("userProfilePic/");
            //StorageUpload task is used to put the data you want in storage
            //Make sure to get the image first before calling this method otherwise _image will be null.
            await pr.show();
            StorageUploadTask storageUploadTask =
            ref.child(user.uid).putFile(images);

            if (storageUploadTask.isSuccessful ||
                storageUploadTask.isComplete) {
              final String url = await ref.getDownloadURL();
              //  print("The download URL is " + url);
            } else if (storageUploadTask.isInProgress) {
              storageUploadTask.events.listen((event) {
                double percentage = 100 *
                    (event.snapshot.bytesTransferred.toDouble() /
                        event.snapshot.totalByteCount.toDouble());

                //  print("THe percentage " + percentage.toString());
                pr = ProgressDialog(context,
                    type: ProgressDialogType.Download,
                    isDismissible: false,
                    showLogs: true);
              });

              StorageTaskSnapshot storageTaskSnapshot =
              await storageUploadTask.onComplete;

              var downloadUrl1 = await storageTaskSnapshot.ref.getDownloadURL();
              Firestore.instance
                  .collection(user.uid)
                  .document("PersonalInfo")
                  .updateData({
                "profilePic": downloadUrl1,
              });
              //Here you can get the download URL when the task has been completed.
              // print("Download URL " + downloadUrl1.toString());
              await pr.hide();
            } else {
              await pr.hide();

              //Catch any cases here that might come up like canceled, interrupted
            }
          } catch (e) {
            print(e.toString());
          }
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('uid', user.uid);

           await pr.hide();
          // Navigator.of(context).pop();
          // Navigator.of(context).pop();

         // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpPage(),));
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Dashboard(),
            ),
          );
        } else {
          await pr.hide();
          Fluttertoast.showToast(
              msg: "Some error occurd",
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.white,
              textColor: Colors.teal);
        }
      } catch (e) {
        await pr.hide();
        Fluttertoast.showToast(
            msg: e.toString(),
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.white,
            textColor: Colors.teal);
      }
    } else {
      await pr.hide();
      Fluttertoast.showToast(
          msg: "Missing something...",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.white,
          textColor: Colors.teal);
    }
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField1(
      String title,
      ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  fontFamily: "Roboto")),
          Container(
            height: 50,
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black26,
            ),
            margin: EdgeInsets.all(6),
            padding: EdgeInsets.only(left: 6),
            child: TextField(
              controller: _emailController,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: "Roboto",
                  fontSize: 18,
                  color: Colors.white),
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "abc@gmail.com"),
              //readOnly: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _entryField2(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  fontFamily: "Roboto")),
          Container(
            height: 50,
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black26,
            ),
            margin: EdgeInsets.all(6),
            padding: EdgeInsets.only(left: 6),
            child: TextField(
              controller: _passwordController,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: "Roboto",
                  fontSize: 18,
                  color: Colors.white),
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "a!v@23S"),
              //readOnly: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _entryField3(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  fontFamily: "Roboto")),
          Container(
            height: 50,
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black26,
            ),
            margin: EdgeInsets.all(6),
            padding: EdgeInsets.only(left: 6),
            child: TextField(
              controller: _name1Controller,

              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: "Roboto",
                  fontSize: 18,
                  color: Colors.white),
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Alek kernrl"),
              //readOnly: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _entryField4(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  fontFamily: "Roboto")),
          Container(
            height: 50,
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black26,
            ),
            margin: EdgeInsets.all(6),
            padding: EdgeInsets.only(left: 6),
            child: TextField(
              controller: _name2Controller,

              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: "Roboto",
                  fontSize: 18,
                  color: Colors.white),
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Alek kernrl"),
              //readOnly: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _entryField5(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  fontFamily: "Roboto")),
          Container(
            height: 50,
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black26,
            ),
            margin: EdgeInsets.all(6),
            padding: EdgeInsets.only(left: 6),
            child: TextField(
              controller: _phoneController,

              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: "Roboto",
                  fontSize: 18,
                  color: Colors.white),
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "10 digits"),
              //readOnly: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _entryField6(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  fontFamily: "Roboto")),
          Container(
            height: 50,
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black26,
            ),
            margin: EdgeInsets.all(6),
            padding: EdgeInsets.only(left: 6),
            child: TextField(
              controller: _addresscontroler,

              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: "Roboto",
                  fontSize: 18,
                  color: Colors.white),
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Address"),
              //readOnly: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField1("Email"),
        _entryField2("Password"),
        _entryField5(
          "Phone",
        ),
        _entryField3(
          "First Name",
        ),
        _entryField4(
          "Last Name",
        ),
        _entryField6(
          "Address",
        ),
      ],
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login(),));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xff0f4c81),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Create',
          style: GoogleFonts.portLligatSans(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          children: const [
            TextSpan(
              text: ' Account',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ]),
    );
  }

  Future getImage(ImgSource source, BuildContext context) async {
    var imagex = await ImagePickerGC.pickImage(
      context: context, source: source,
      cameraIcon: Icon(
        Icons.camera,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    setState(() {
      image = imagex;
    });
  }

}
