import 'package:flutter/material.dart';
import 'package:igv2/models/database.dart';
import 'package:igv2/models/profile_model.dart';
import 'package:igv2/models/story_api.dart';
import 'package:igv2/models/story_model.dart';
import 'package:igv2/screens/storyPage.dart';
import 'package:numeral/numeral.dart';

class InstagramProfilePage extends StatefulWidget {
  const InstagramProfilePage({Key? key}) : super(key: key);

  @override
  State<InstagramProfilePage> createState() => _InstagramProfilePageState();
}

class _InstagramProfilePageState extends State<InstagramProfilePage> {
  List<Story> stories = [];
  bool switchValue = false;
  Future<void> checkDatabase(ProfileModel info) async {
    List<ProfileDb> res = await DatabaseHelper.instance.getProfileInfo();
    for (ProfileDb i in res) {
      if (i.name == info.username) {
        setState(() {
          switchValue = i.favorite;
        });
        return;
      }
    }
    await DatabaseHelper.instance.add(ProfileDb(
        name: info.username,
        favorite: false,
        profilePicture: info.profilePicture));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      final profileInfo =
          ModalRoute.of(context)!.settings.arguments as ProfileModel;
      checkDatabase(profileInfo);

      getStory(profileInfo.username).then((value) {
        setState(() {
          stories = value!;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final MaterialStateProperty<Color?> trackColor =
        MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.red;
        }
        return null;
      },
    );
    final MaterialStateProperty<Color?> overlayColor =
        MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.amber.withOpacity(0.54);
        }
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey.shade400;
        }
        return null;
      },
    );

    final profileInfo =
        ModalRoute.of(context)!.settings.arguments as ProfileModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(profileInfo.username),
        actions: [
          BackButton(
            onPressed: () => Navigator.pushReplacementNamed(context, "/user"),
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    stories.isNotEmpty
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StoryScreen(stories: stories),
                            ),
                          )
                        : null;
                  },
                  child: Hero(
                    tag: "story",
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                            radius: 48,
                            backgroundColor: stories.isNotEmpty
                                ? Colors.red
                                : Colors.transparent),
                        CircleAvatar(
                          radius: 45,
                          backgroundImage:
                              NetworkImage(profileInfo.profilePicture),
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "${profileInfo.postsCount}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Posts',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      Numeral(profileInfo.followedBy).format(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Followers',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      Numeral(profileInfo.following).format(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Following',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              profileInfo.fullName,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              profileInfo.bio,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            const Divider(
              thickness: 0.5,
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.favorite,
                          color:
                              switchValue ? Colors.red : Colors.grey.shade400),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Favorite",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Switch(
                    // This bool value toggles the switch.
                    value: switchValue,
                    overlayColor: overlayColor,
                    trackColor: trackColor,
                    thumbColor:
                        const MaterialStatePropertyAll<Color>(Colors.black),
                    onChanged: (bool value) async {
                      await DatabaseHelper.instance.updateDatabase(ProfileDb(
                          name: profileInfo.username,
                          favorite: value,
                          profilePicture: profileInfo.profilePicture));
                      setState(() {
                        switchValue = value;
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
