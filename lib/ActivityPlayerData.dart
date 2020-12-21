// To parse this JSON data, do
//
//     final activityPlayerData = activityPlayerDataFromJson(jsonString);

import 'dart:convert';

ActivityPlayerData activityPlayerDataFromJson(String str) => ActivityPlayerData.fromJson(json.decode(str));

String activityPlayerDataToJson(ActivityPlayerData data) => json.encode(data.toJson());

class ActivityPlayerData {
  ActivityPlayerData({
    this.id,
    this.title,
    this.description,
    this.type,
    this.contentVersion,
    this.duration,
    this.updated,
    this.image,
    this.course,
    this.courseType,
    this.position,
    this.level,
    this.exercises,
  });

  String id;
  String title;
  String description;
  String type;
  String contentVersion;
  int duration;
  int updated;
  String image;
  List<dynamic> course;
  List<String> courseType;
  int position;
  String level;
  List<Exercise> exercises;

  factory ActivityPlayerData.fromJson(Map<String, dynamic> json) => ActivityPlayerData(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    type: json["type"],
    contentVersion: json["content_version"],
    duration: json["duration"],
    updated: json["updated"],
    image: json["image"],
    course: List<dynamic>.from(json["course"].map((x) => x)),
    courseType: List<String>.from(json["course_type"].map((x) => x)),
    position: json["position"],
    level: json["level"],
    exercises: List<Exercise>.from(json["exercises"].map((x) => Exercise.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "type": type,
    "content_version": contentVersion,
    "duration": duration,
    "updated": updated,
    "image": image,
    "course": List<dynamic>.from(course.map((x) => x)),
    "course_type": List<dynamic>.from(courseType.map((x) => x)),
    "position": position,
    "level": level,
    "exercises": List<dynamic>.from(exercises.map((x) => x.toJson())),
  };
}

class Exercise {
  Exercise({
    this.id,
    this.title,
    this.type,
    this.created,
    this.updated,
    this.subtitle,
    this.image,
    this.help,
    this.config,
    this.scorable,
    this.defaultScore,
    this.htmlContent,
    this.video,
    this.text,
  });

  String id;
  String title;
  String type;
  int created;
  int updated;
  String subtitle;
  String image;
  dynamic help;
  dynamic config;
  bool scorable;
  List<DefaultScore> defaultScore;
  String htmlContent;
  Video video;
  String text;

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
    id: json["id"],
    title: json["title"],
    type: json["type"],
    created: json["created"],
    updated: json["updated"],
    subtitle: json["subtitle"],
    image: json["image"] == null ? null : json["image"],
    help: json["help"],
    config: json["config"],
    scorable: json["scorable"] == null ? null : json["scorable"],
    defaultScore: json["defaultScore"] == null ? null : List<DefaultScore>.from(json["defaultScore"].map((x) => DefaultScore.fromJson(x))),
    htmlContent: json["htmlContent"] == null ? null : json["htmlContent"],
    video: json["video"] == null ? null : Video.fromJson(json["video"]),
    text: json["text"] == null ? null : json["text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "type": type,
    "created": created,
    "updated": updated,
    "subtitle": subtitle,
    "image": image == null ? null : image,
    "help": help,
    "config": config,
    "scorable": scorable == null ? null : scorable,
    "defaultScore": defaultScore == null ? null : List<dynamic>.from(defaultScore.map((x) => x.toJson())),
    "htmlContent": htmlContent == null ? null : htmlContent,
    "video": video == null ? null : video.toJson(),
    "text": text == null ? null : text,
  };
}

class ConfigElement {
  ConfigElement({
    this.title,
    this.description,
    this.color,
    this.position,
  });

  String title;
  String description;
  String color;
  int position;

  factory ConfigElement.fromJson(Map<String, dynamic> json) => ConfigElement(
    title: json["title"],
    description: json["description"],
    color: json["color"],
    position: json["position"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "color": color,
    "position": position,
  };
}

class PurpleConfig {
  PurpleConfig({
    this.scoring,
    this.items,
    this.content,
    this.words,
    this.wordsOrder,
    this.word,
    this.audio,
    this.definition,
    this.subtitleaudio,
  });

  dynamic scoring;
  List<ConfigItem> items;
  String content;
  dynamic words;
  List<dynamic> wordsOrder;
  String word;
  List<Audio> audio;
  String definition;
  String subtitleaudio;

  factory PurpleConfig.fromJson(Map<String, dynamic> json) => PurpleConfig(
    scoring: json["scoring"],
    items: json["items"] == null ? null : List<ConfigItem>.from(json["items"].map((x) => ConfigItem.fromJson(x))),
    content: json["content"] == null ? null : json["content"],
    words: json["words"],
    wordsOrder: json["wordsOrder"] == null ? null : List<dynamic>.from(json["wordsOrder"].map((x) => x)),
    word: json["word"] == null ? null : json["word"],
    audio: json["audio"] == null ? null : List<Audio>.from(json["audio"].map((x) => Audio.fromJson(x))),
    definition: json["definition"] == null ? null : json["definition"],
    subtitleaudio: json["subtitleaudio"] == null ? null : json["subtitleaudio"],
  );

  Map<String, dynamic> toJson() => {
    "scoring": scoring,
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
    "content": content == null ? null : content,
    "words": words,
    "wordsOrder": wordsOrder == null ? null : List<dynamic>.from(wordsOrder.map((x) => x)),
    "word": word == null ? null : word,
    "audio": audio == null ? null : List<dynamic>.from(audio.map((x) => x.toJson())),
    "definition": definition == null ? null : definition,
    "subtitleaudio": subtitleaudio == null ? null : subtitleaudio,
  };
}

class Audio {
  Audio({
    this.voice,
    this.language,
    this.file,
  });

  Voice voice;
  Language language;
  String file;

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
    voice: voiceValues.map[json["voice"]],
    language: languageValues.map[json["language"]],
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "voice": voiceValues.reverse[voice],
    "language": languageValues.reverse[language],
    "file": file,
  };
}

enum Language { EN_US, EN_GB }

final languageValues = EnumValues({
  "en-GB": Language.EN_GB,
  "en-US": Language.EN_US
});

enum Voice { MALE, FEMALE }

final voiceValues = EnumValues({
  "female": Voice.FEMALE,
  "male": Voice.MALE
});

class ConfigItem {
  ConfigItem({
    this.question,
    this.answers,
    this.correct,
    this.label,
    this.hint,
    this.scoring,
    this.itemId,
    this.title,
    this.items,
    this.defaultHint,
    this.placeholder,
    this.options,
  });

  String question;
  List<Answer> answers;
  bool correct;
  String label;
  String hint;
  List<DefaultScore> scoring;
  int itemId;
  String title;
  List<ItemItem> items;
  String defaultHint;
  String placeholder;
  List<Option> options;

  factory ConfigItem.fromJson(Map<String, dynamic> json) => ConfigItem(
    question: json["question"] == null ? null : json["question"],
    answers: json["answers"] == null ? null : List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
    correct: json["correct"] == null ? null : json["correct"],
    label: json["label"] == null ? null : json["label"],
    hint: json["hint"] == null ? null : json["hint"],
    scoring: json["scoring"] == null ? null : List<DefaultScore>.from(json["scoring"].map((x) => DefaultScore.fromJson(x))),
    itemId: json["itemId"] == null ? null : json["itemId"],
    title: json["title"] == null ? null : json["title"],
    items: json["items"] == null ? null : List<ItemItem>.from(json["items"].map((x) => ItemItem.fromJson(x))),
    defaultHint: json["defaultHint"] == null ? null : json["defaultHint"],
    placeholder: json["placeholder"] == null ? null : json["placeholder"],
    options: json["options"] == null ? null : List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "question": question == null ? null : question,
    "answers": answers == null ? null : List<dynamic>.from(answers.map((x) => x.toJson())),
    "correct": correct == null ? null : correct,
    "label": label == null ? null : label,
    "hint": hint == null ? null : hint,
    "scoring": scoring == null ? null : List<dynamic>.from(scoring.map((x) => x.toJson())),
    "itemId": itemId == null ? null : itemId,
    "title": title == null ? null : title,
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
    "defaultHint": defaultHint == null ? null : defaultHint,
    "placeholder": placeholder == null ? null : placeholder,
    "options": options == null ? null : List<dynamic>.from(options.map((x) => x.toJson())),
  };
}

class Answer {
  Answer({
    this.correct,
    this.label,
    this.hint,
    this.scoring,
  });

  bool correct;
  dynamic label;
  String hint;
  List<DefaultScore> scoring;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    correct: json["correct"],
    label: json["label"],
    hint: json["hint"],
    scoring: json["scoring"] == null ? null : List<DefaultScore>.from(json["scoring"].map((x) => DefaultScore.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "correct": correct,
    "label": label,
    "hint": hint,
    "scoring": scoring == null ? null : List<dynamic>.from(scoring.map((x) => x.toJson())),
  };
}

class LabelClass {
  LabelClass({
    this.image,
  });

  String image;

  factory LabelClass.fromJson(Map<String, dynamic> json) => LabelClass(
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
  };
}

class DefaultScore {
  DefaultScore({
    this.competencyCategory,
    this.competency,
    this.points,
  });

  CompetencyCategory competencyCategory;
  Competency competency;
  int points;

  factory DefaultScore.fromJson(Map<String, dynamic> json) => DefaultScore(
    competencyCategory: CompetencyCategory.fromJson(json["competency_category"]),
    competency: competencyValues.map[json["competency"]],
    points: json["points"],
  );

  Map<String, dynamic> toJson() => {
    "competency_category": competencyCategory.toJson(),
    "competency": competencyValues.reverse[competency],
    "points": points,
  };
}

enum Competency { TALKING_ABOUT_TRANSPORT, SAYING_HOW_OFTEN_YOU_DO_SOMETHING, DISCUSSING_TICKETS }

final competencyValues = EnumValues({
  "Discussing tickets": Competency.DISCUSSING_TICKETS,
  "Saying how often you do something": Competency.SAYING_HOW_OFTEN_YOU_DO_SOMETHING,
  "Talking about transport": Competency.TALKING_ABOUT_TRANSPORT
});

class CompetencyCategory {
  CompetencyCategory({
    this.title,
    this.id,
  });

  Title title;
  String id;

  factory CompetencyCategory.fromJson(Map<String, dynamic> json) => CompetencyCategory(
    title: titleValues.map[json["title"]],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "title": titleValues.reverse[title],
    "id": id,
  };
}

enum Title { SKILLS_BEGINNER_GETTING_AROUND }

final titleValues = EnumValues({
  "Skills (Beginner) - Getting Around": Title.SKILLS_BEGINNER_GETTING_AROUND
});

class ItemItem {
  ItemItem({
    this.title,
    this.scoring,
    this.category,
  });

  String title;
  List<DefaultScore> scoring;
  bool category;

  factory ItemItem.fromJson(Map<String, dynamic> json) => ItemItem(
    title: json["title"],
    scoring: List<DefaultScore>.from(json["scoring"].map((x) => DefaultScore.fromJson(x))),
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "scoring": List<dynamic>.from(scoring.map((x) => x.toJson())),
    "category": category,
  };
}

class Option {
  Option({
    this.correct,
    this.label,
    this.hint,
    this.scoring,
  });

  bool correct;
  LabelEnum label;
  String hint;
  List<DefaultScore> scoring;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    correct: json["correct"],
    label: labelEnumValues.map[json["label"]],
    hint: json["hint"],
    scoring: json["scoring"] == null ? null : List<DefaultScore>.from(json["scoring"].map((x) => DefaultScore.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "correct": correct,
    "label": labelEnumValues.reverse[label],
    "hint": hint,
    "scoring": scoring == null ? null : List<dynamic>.from(scoring.map((x) => x.toJson())),
  };
}

enum LabelEnum { OFTEN, SOMETIMES, NEVER }

final labelEnumValues = EnumValues({
  "never": LabelEnum.NEVER,
  "often": LabelEnum.OFTEN,
  "sometimes": LabelEnum.SOMETIMES
});

class ScoringElement {
  ScoringElement({
    this.ranges,
    this.competency,
  });

  List<Range> ranges;
  String competency;

  factory ScoringElement.fromJson(Map<String, dynamic> json) => ScoringElement(
    ranges: List<Range>.from(json["ranges"].map((x) => Range.fromJson(x))),
    competency: json["competency"],
  );

  Map<String, dynamic> toJson() => {
    "ranges": List<dynamic>.from(ranges.map((x) => x.toJson())),
    "competency": competency,
  };
}

class Range {
  Range({
    this.from,
    this.to,
    this.msg,
    this.points,
  });

  int from;
  int to;
  String msg;
  int points;

  factory Range.fromJson(Map<String, dynamic> json) => Range(
    from: json["from"],
    to: json["to"],
    msg: json["msg"],
    points: json["points"] == null ? null : json["points"],
  );

  Map<String, dynamic> toJson() => {
    "from": from,
    "to": to,
    "msg": msg,
    "points": points == null ? null : points,
  };
}

class PurpleScoring {
  PurpleScoring({
    this.ranges,
  });

  List<Range> ranges;

  factory PurpleScoring.fromJson(Map<String, dynamic> json) => PurpleScoring(
    ranges: List<Range>.from(json["ranges"].map((x) => Range.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ranges": List<dynamic>.from(ranges.map((x) => x.toJson())),
  };
}

class Video {
  Video({
    this.file,
    this.videoId,
    this.type,
  });

  String file;
  String videoId;
  String type;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    file: json["file"],
    videoId: json["video_id"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "file": file,
    "video_id": videoId,
    "type": type,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
