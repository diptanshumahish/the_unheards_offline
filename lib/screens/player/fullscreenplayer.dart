import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_unheards_offline/utils/utils.dart';

class FullScreenPlayer extends StatefulWidget {
  const FullScreenPlayer({Key? key}) : super(key: key);

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key("dismissible"),
      onDismissed: (_) => Navigator.of(context).pop(),
      direction: DismissDirection.down,
      resizeDuration: Duration(milliseconds: 200),
      child: Scaffold(
        backgroundColor: AppColors.mainBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: Text("Now Playing"),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://m.media-amazon.com/images/I/71zf0DtXOtL._SL1200_.jpg'))),
                      )
                    ],
                  ),
                  //icons on the right side
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(CupertinoIcons.shuffle),
                        color: AppColors.themeColors,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(CupertinoIcons.graph_square),
                        color: AppColors.themeColors,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(CupertinoIcons.repeat),
                        color: AppColors.themeColors,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(CupertinoIcons.search),
                        color: AppColors.themeColors,
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "The Golden Hour",
                    style: TextStyle(color: AppColors.mainText, fontSize: 30),
                  ),
                  Text(
                    "Kygo",
                    style: TextStyle(color: AppColors.secondary, fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    CupertinoIcons.backward_end_fill,
                    color: AppColors.secondary,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(CupertinoIcons.play_circle_fill,
                      color: AppColors.mainText, size: 30),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(CupertinoIcons.forward_end_fill,
                      color: AppColors.secondary, size: 30),
                  onPressed: () {},
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
