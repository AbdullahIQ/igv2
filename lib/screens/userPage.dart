import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:igv2/loading.dart';
import 'package:igv2/models/database.dart';
import 'package:igv2/models/log_out.dart';
import 'package:igv2/models/profile_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});
  @override
  State<UserPage> createState() => _UserPageState();
}

void clearPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

Future<String?> getPrefs() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("username");
}

class _UserPageState extends State<UserPage> {
  TextEditingController userTarget = TextEditingController();

  bool loading = false;

  void navigateToProfile(String name) {
    super.didChangeDependencies();
    setState(() {
      loading = true;
    });
    getprofile(name).then((value) {
      Navigator.pushReplacementNamed(context, "/profile", arguments: value);
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.blue[400],
              elevation: 0.0,
              title: FutureBuilder(
                future: getPrefs(),
                builder: (context, snapshot) => snapshot.hasData
                    ? Text(snapshot.data!)
                    : const Text("user"),
              ),
              actions: [
                ElevatedButton.icon(
                  label: const Text("Log Out"),
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    await logOut()
                        ? {
                            loading = false,
                            clearPrefs(),
                            Navigator.pushReplacementNamed(context, "/login"),
                          }
                        : setState(() {
                            loading = false;
                          });
                  },
                  icon: const Icon(Icons.logout),
                )
              ],
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 100, // set a fixed height for the ListView.builder
                    child: FutureBuilder(
                      future: DatabaseHelper.instance.getProfileInfo(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<ProfileDb>> snapshot) {
                        // DatabaseHelper.instance.deleteDatabase();
                        bool containsFavorite = snapshot.hasData
                            ? snapshot.data!
                                .map((e) => e.favorite)
                                .toList()
                                .contains(true)
                            : false;
                        if (!snapshot.hasData ||
                            snapshot.data!.isEmpty ||
                            !containsFavorite) {
                          return ListView.builder(
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width:
                                    80, // set the fixed width for each story item
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(3),
                                      child: CircleAvatar(
                                        radius:
                                            30, // set the radius of the avatar
                                        backgroundColor: Colors.grey
                                            .shade400, // set the avatar image
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis
                                .horizontal, // set the horizontal scroll direction
                            itemCount: snapshot.data!
                                .length, // set the number of stories to display
                            itemBuilder: (BuildContext cont, int index) {
                              return snapshot.data![index].favorite
                                  ? GestureDetector(
                                      onTap: () {
                                        navigateToProfile(
                                            snapshot.data![index].name);
                                        // Navigator.pushNamed(context, "/profile");
                                      },
                                      child: SizedBox(
                                        width:
                                            80, // set the fixed width for each story item
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(3),
                                              child: CircleAvatar(
                                                radius:
                                                    30, // set the radius of the avatar
                                                backgroundImage:
                                                    CachedNetworkImageProvider(
                                                        snapshot.data![index]
                                                            .profilePicture), // set the avatar image
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                snapshot.data![index].name,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : null;
                            },
                          );
                        }
                      },
                    ),
                  ),
                  const Divider(
                    thickness: 0.5,
                    height: 0,
                  ),
                  TextField(
                    controller: userTarget,
                    decoration: const InputDecoration(
                        hintText: "Enter target username"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      navigateToProfile(userTarget.text);
                      // Navigator.pushNamed(context, "/profile");
                    },
                    child: const Text("Search profile"),
                  )
                ],
              ),
            ),
          );
  }
}
