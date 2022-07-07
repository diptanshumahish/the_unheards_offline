import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_unheards_offline/utils/utils.dart';
import 'package:the_unheards_offline/widgets/homescreen_widgets.dart';

String finalName = "temp";
String finalArtist = "unkwown";

class HomeScreen extends StatefulWidget {
  late ArtworkType artwork;
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getData().whenComplete(() => HomeScreen());
    super.initState();
  }

  Future getData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var name = sharedPreferences.getString("songName");
    var artist = sharedPreferences.getString("artistName");
    setState(() {
      if (name == null) {
        finalName = "Not playing";
        finalArtist = "Unavailable";
      } else {
        finalName = name;
        finalArtist = artist.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackgroundColor,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(0),
                height: MediaQuery.of(context).size.height + 100,
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
                  top: 350,
                  left: 20,
                  right: 20,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Keep listening",
                                  style: TextStyle(
                                      color: AppColors.mainText, fontSize: 20)),
                              Text(
                                finalName,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: AppColors.themeColors,
                                    fontSize: 30),
                              ),
                              Text(
                                finalArtist,
                                style: TextStyle(
                                    color: AppColors.secondary, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                        const Icon(
                          CupertinoIcons.play_circle_fill,
                          color: AppColors.themeColors,
                          size: 70,
                        )
                      ],
                    ),
                  )),
              Positioned(
                  top: 450,
                  left: 10,
                  right: 10,
                  child: SizedBox(
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 2 / 1),
                      itemBuilder: (context, index) {
                        return HomeScreenWIdget(
                            songName: finalName,
                            totalSongs: 100,
                            recentlyAddedSongs: 200,
                            index: index);
                      },
                      itemCount: 4,
                    ),
                  )),
              Positioned(
                  bottom: 30,
                  left: 10,
                  right: 10,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("AI based suggestions coming soon !",
                              style: TextStyle(
                                  color: AppColors.mainText,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8)),
                          Text("Stay tuned!",
                              style: TextStyle(
                                  color: AppColors.secondary,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5))
                        ],
                      ),
                    ),
                    height: 200,
                    width: 500,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.8), BlendMode.lighten),
                          image: NetworkImage(
                            'https://images.unsplash.com/photo-1572297905000-240a65cf5b03?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
                          ),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
