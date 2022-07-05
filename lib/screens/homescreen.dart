import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:the_unheards_offline/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackgroundColor,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(0),
                height: 400,
              ),
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.mainBackgroundColor,
                      AppColors.transparent
                    ],
                  ).createShader(const Rect.fromLTRB(0, 0, 0, 350));
                },
                blendMode: BlendMode.dstIn,
                child: Image.network(
                  'https://images.unsplash.com/photo-1550686041-366ad85a1355?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              RotatedBox(
                quarterTurns: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    "THE UNHEARDS.",
                    style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w900,
                        color: AppColors.mainText.withOpacity(0.15),
                        letterSpacing: 2),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
