// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:igv2/models/mentions_model.dart';
import 'package:video_player/video_player.dart';
import '../models/story_model.dart';
import '../models/user_model.dart';

class StoryScreen extends StatefulWidget {
  final List<Story> stories;
  const StoryScreen({super.key, required this.stories});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  VideoPlayerController? _videoPlayerController;
  late AnimationController _animationController;
  late Story firstStory = widget.stories.first;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(vsync: this);
    _loadStory(story: firstStory, animateToPage: false);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.stop();
        _animationController.reset();
        setState(() {
          if (currentIndex + 1 < widget.stories.length) {
            currentIndex += 1;
            _loadStory(story: widget.stories[currentIndex]);
          } else {
            currentIndex = 0;
            _loadStory(story: widget.stories[currentIndex]);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Story story = widget.stories[currentIndex];
    return SafeArea(
      child: Hero(
        tag: "story",
        child: Scaffold(
          backgroundColor: Colors.black,
          body: GestureDetector(
            onTapDown: (details) => _onTapDown(details, story),
            child: Stack(
              children: [
                PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    itemCount: widget.stories.length,
                    itemBuilder: ((context, index) {
                      final Story story = widget.stories[index];
                      switch (story.media) {
                        case MediaType.image:
                          return CachedNetworkImage(
                            imageUrl: story.url,
                            fit: BoxFit.cover,
                          );
                        case MediaType.video:
                          if (_videoPlayerController!.value.isInitialized) {
                            return FittedBox(
                              fit: BoxFit.cover,
                              child: SizedBox(
                                width: _videoPlayerController!.value.size.width,
                                height:
                                    _videoPlayerController!.value.size.height,
                                child: VideoPlayer(_videoPlayerController!),
                              ),
                            );
                          }
                      }
                      return const SizedBox.shrink();
                    })),
                SafeArea(
                  minimum: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: _iterateStories(widget.stories, context,
                            currentIndex, _animationController),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: UserInfo(
                          user: story.user,
                          index: currentIndex,
                          animController: _animationController,
                          vidController: _videoPlayerController,
                          stories: widget.stories,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details, Story story) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      setState(() {
        if (currentIndex - 1 >= 0) {
          currentIndex -= 1;
          _loadStory(story: widget.stories[currentIndex]);
        }
      });
    } else if (dx > 2 * screenWidth / 3) {
      setState(() {
        if (currentIndex + 1 < widget.stories.length) {
          currentIndex += 1;
          _loadStory(story: widget.stories[currentIndex]);
        } else {
          currentIndex = 0;
          _loadStory(story: widget.stories[currentIndex]);
        }
      });
    } else {
      if (story.media == MediaType.video) {
        _videoPlayerController!.value.isPlaying
            ? _videoPlayerController!.pause()
            : _videoPlayerController!.play();
        _animationController.isAnimating
            ? _animationController.stop()
            : _animationController.forward();
      } else {
        // _videoPlayerController!.pause();
        _animationController.isAnimating
            ? _animationController.stop()
            : _animationController.forward();
      }
    }
  }

  void _loadStory({Story? story, bool animateToPage = true}) {
    _animationController.stop();
    _animationController.reset();
    switch (story!.media) {
      case MediaType.image:
        if (_videoPlayerController != null &&
            _videoPlayerController!.value.isInitialized) {
          _animationController.duration =
              _videoPlayerController!.value.duration;
          _videoPlayerController!.dispose();
        }
        _animationController.duration = story.duration;
        _animationController.forward();
        break;
      case MediaType.video:
        _videoPlayerController = null;
        _videoPlayerController?.dispose();
        _videoPlayerController = VideoPlayerController.network(story.url)
          ..initialize().then((_) {
            setState(() {});
            if (_videoPlayerController!.value.isInitialized) {
              _animationController.duration =
                  _videoPlayerController!.value.duration;
              _videoPlayerController!.play();
              _animationController.forward();
            }
          });
        break;
    }
    if (animateToPage) {
      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }
}

List<Widget> _iterateStories(List<Story> stories, BuildContext context,
    int currentIndex, AnimationController anim) {
  return stories
      .asMap()
      .map((i, e) {
        return MapEntry(
            i,
            AnimatedBar(
                animController: anim, position: i, currentIndex: currentIndex));
      })
      .values
      .toList();
}

class AnimatedBar extends StatelessWidget {
  final AnimationController animController;
  final int position;
  final int currentIndex;

  const AnimatedBar({
    super.key,
    required this.animController,
    required this.position,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: <Widget>[
                _buildContainer(
                  double.infinity,
                  position < currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
                position == currentIndex
                    ? AnimatedBuilder(
                        animation: animController,
                        builder: (context, child) {
                          return _buildContainer(
                            constraints.maxWidth * animController.value,
                            Colors.white,
                          );
                        },
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 3.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black26,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}

class UserInfo extends StatefulWidget {
  final User user;
  final int index;
  final AnimationController animController;
  final VideoPlayerController? vidController;
  final List<Story> stories;

  const UserInfo({
    super.key,
    required this.user,
    required this.index,
    required this.animController,
    required this.vidController,
    required this.stories,
  });

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    void showSettingPanel() {
      widget.animController.stop();
      widget.stories[widget.index].media == MediaType.video
          ? widget.vidController!.pause()
          : null;
      bool progressVal = false;
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(builder: ((context, setState) {
              return Column(
                children: [
                  progressVal
                      ? const CircularProgressIndicator(
                          strokeWidth: 4,
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              progressVal = true;
                            });
                            FileDownloader.downloadFile(
                              url: widget.stories[widget.index].url,
                              onDownloadCompleted: (path) {
                                setState(() {
                                  progressVal = false;
                                });
                              },
                            );
                          },
                          icon: const Icon(Icons.download)),
                  Flexible(
                    child: ListView(
                      children: [
                        for (Mentions i
                            in widget.stories[widget.index].mentions) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Card(
                              margin: const EdgeInsets.fromLTRB(20, 6, 20, 0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  foregroundImage: CachedNetworkImageProvider(
                                      i.mentionedPic),
                                  radius: 25,
                                  backgroundColor: Colors.brown[100],
                                ),
                                title: Text(i.mentionedUser),
                                subtitle: Text(i.mentionedName),
                              ),
                            ),
                          )
                        ]
                      ],
                    ),
                  ),
                ],
              );
            }));
          }).whenComplete(() {
        widget.animController.forward();
        widget.stories[widget.index].media == MediaType.video
            ? widget.vidController!.play()
            : null;
      });
    }

    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.grey[300],
          backgroundImage: CachedNetworkImageProvider(
            widget.user.profileImageUrl,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    widget.user.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.stories[widget.index].date.hour < 12
                        ? "${widget.stories[widget.index].date.hour}:${widget.stories[widget.index].date.minute} AM"
                        : "${widget.stories[widget.index].date.hour - 12}:${widget.stories[widget.index].date.minute} PM",
                    // "${stories[index].date.hour}:${stories[index].date.minute}",
                    style: TextStyle(
                      color: Colors.grey[50],
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            widget.animController.dispose();
            if (widget.vidController != null) {
              widget.vidController!.dispose();
            }
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close_outlined),
          color: Colors.white,
        ),
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            widget.stories[widget.index].mentions.isNotEmpty
                ? const Icon(
                    Icons.circle_rounded,
                    color: Colors.green,
                    size: 30,
                  )
                : const Icon(Icons.circle_rounded, color: Colors.transparent),
            IconButton(
              icon:
                  const Icon(Icons.more_vert, size: 30.0, color: Colors.white),
              onPressed: () => showSettingPanel(),
            )
          ],
        ),
      ],
    );
  }
}
