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
                height: 350,
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
              Positioned(
                  bottom: 30,
                  left: 20,
                  right: 20,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Keep listening",
                                style: TextStyle(
                                    color: AppColors.mainText, fontSize: 20)),
                            Text(
                              "Song name",
                              style: TextStyle(
                                  color: AppColors.themeColors, fontSize: 30),
                            ),
                            Text(
                              "Artist name",
                              style: TextStyle(
                                  color: AppColors.secondary, fontSize: 15),
                            )
                          ],
                        ),
                        Icon(
                          CupertinoIcons.play_arrow_solid,
                          color: AppColors.themeColors,
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
