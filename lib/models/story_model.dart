import 'package:igv2/models/user_model.dart';

import 'mentions_model.dart';

enum MediaType {
  image,
  video,
}

class Story {
  final String url;
  final MediaType media;
  final Duration duration;
  final User user;
  final DateTime date;
  final List<Mentions> mentions;

  const Story(
      {required this.url,
      required this.media,
      required this.duration,
      required this.user,
      required this.date,
      required this.mentions});
}
