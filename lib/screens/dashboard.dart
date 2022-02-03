import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:yozu_ai/screens/questScreen.dart';

class Dashboard extends StatefulWidget {
  final uid;
  const Dashboard({Key key, this.title, this.uid}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin {

  List<QuestBoard> data = null;
  ScrollController _scrollController;
  AnimationController _animationController;

  double rotation = 0;
  double scrollStartAt = 0;

  Color backgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      var dx = _scrollController.offset - scrollStartAt;

      setState(() {
        rotation = dx / 50;
        if (rotation > 1) {
          rotation = 1;
        } else if (rotation < -1) {
          rotation = -1;
        }

        if (_scrollController.offset > 50) {
          backgroundColor = data.last.colors.color;
        } else {
          backgroundColor = data.first.colors.color;
        }
      });
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.addListener(() {
      setState(() {
        rotation = rotation.sign * _animationController.value;
      });
    });

    _initializeColors().then((list) {
      setState(() {
        data = list;

        backgroundColor = data.first.colors.color;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      body: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollEndNotification) {
            _animationController.reverse(from: rotation.abs());
          }
          if (notification is ScrollStartNotification) {
            scrollStartAt = _scrollController.offset;
          }

          return false;
        },
        child: ListView(
          controller: _scrollController,
          children: <Widget>[
            for (QuestBoard board in data)
              InkWell(
          onTap: () {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuestPage(),));
    },

                child: QuestItemWidget(
                  rotation: rotation,
                  title: "The Tournament Conundrum",
                  imagePath: board.imagePath,
                  colors: board.colors,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<List<QuestBoard>> _initializeColors() async {
    var images = [
      "board1.png",
      "board2.png",
      "board3.png",
      "board4.png",
      "board5.png",
      "board6.png"
    ];

    List<QuestBoard> list = [];

    for (String image in images) {
      String imagePath = "assets/$image";
      PaletteGenerator colors =
      await PaletteGenerator.fromImageProvider(AssetImage(imagePath));
      list.add(QuestBoard(imagePath, colors.dominantColor));
    }

    return list;
  }

}

class QuestBoard {
  final String imagePath;
  final PaletteColor colors;

  QuestBoard(this.imagePath, this.colors);
}

class QuestItemWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final PaletteColor colors;
  final double rotation;

  const QuestItemWidget(
      {Key key, this.rotation, this.title, this.imagePath, this.colors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(rotation);
    return Container(
      color: colors.color,
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.bodyTextColor,
                  letterSpacing: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Transform(
                transform: Matrix4.rotationY(rotation),
                alignment: FractionalOffset.center,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: colors.bodyTextColor,
                        blurRadius: 50,
                        offset: Offset(50 * rotation, 0),
                      ),
                    ]),
                    child: Image.asset(imagePath),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}