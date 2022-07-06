import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_unheards_offline/utils/utils.dart';
import 'package:the_unheards_offline/widgets/musicscreen_widgets.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () => Navigator.pushNamed(context, "/"),
              icon: const Icon(CupertinoIcons.back)),
          centerTitle: true,
          backgroundColor: AppColors.transparent,
          title: const Text("Explore")),
      backgroundColor: AppColors.mainBackgroundColor,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 5 / 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return MusicScreenTop(
                    index: index,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Coming Soon",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: AppColors.secondary),
                      ),
                      Text(
                        "The Unheards Streaming App",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: AppColors.mainText),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Stay tuned ;)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColors.themeColors),
                      )
                    ],
                  ),
                ),
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height / 1.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.themeColors.withOpacity(0.3)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
