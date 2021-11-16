class TimetableEntity {
  List<Timetable> timetable = [];

  TimetableEntity({required this.timetable});

  TimetableEntity.fromJson(Map<String, dynamic> json) {
    if (json['timetable'] != null) {
      json['timetable'].forEach((v) {
        timetable.add(Timetable.fromJson(v));
      });
    }
  }

  Map<String, dynamic>? toJson() {
    final data = <String, dynamic>{};
    data['timetable'] = timetable.map((v) => v.toJson()).toList();
    return data;
  }

  TimetableEntity.empty() {
    timetable = [];
  }

  @override
  String toString() => 'TimetableEntity(timetable: $timetable)';
}

class Timetable {
  String? type;
  String? uuid;
  String? title;
  String? abstract;
  Track? track;
  String? startsAt;
  int? lengthMin;
  Speaker? speaker;
  bool? accepted;
  int? favCount;
  Feedback? feedback;

  Timetable(
      {this.type,
      this.uuid,
      this.title,
      this.abstract,
      this.track,
      this.startsAt,
      this.lengthMin,
      this.speaker,
      this.accepted,
      this.favCount,
      this.feedback});

  Timetable.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    uuid = json['uuid'];
    title = json['title'];
    abstract = json['abstract'];
    track = json['track'] != null ? Track.fromJson(json['track']) : null;
    startsAt = json['starts_at'];
    lengthMin = json['length_min'];
    speaker =
        json['speaker'] != null ? Speaker.fromJson(json['speaker']) : null;
    accepted = json['accepted'];
    favCount = json['fav_count'];
    feedback =
        json['feedback'] != null ? Feedback.fromJson(json['feedback']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['uuid'] = uuid;
    data['title'] = title;
    data['abstract'] = abstract;
    data['track'] = track?.toJson();
    data['starts_at'] = startsAt;
    data['length_min'] = lengthMin;
    data['speaker'] = speaker?.toJson();
    data['accepted'] = accepted;
    data['fav_count'] = favCount;
    data['feedback'] = feedback?.toJson();
    return data;
  }

  @override
  String toString() {
    return 'Timetable(type: $type, uuid: $uuid, title: $title, abstract: $abstract, track: $track, startsAt: $startsAt, lengthMin: $lengthMin, speaker: $speaker, accepted: $accepted, favCount: $favCount, feedback: $feedback)';
  }
}

class Track {
  String? name;
  int? sort;

  Track({this.name, this.sort});

  Track.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['sort'] = sort;
    return data;
  }

  @override
  String toString() => 'Track(name: $name, sort: $sort)';
}

class Speaker {
  String? name;
  String? kana;
  String? twitter;
  String? avatarUrl;

  Speaker({this.name, this.kana, this.twitter, this.avatarUrl});

  Speaker.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    kana = json['kana'];
    twitter = json['twitter'];
    avatarUrl = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['kana'] = kana;
    data['twitter'] = twitter;
    data['avatar_url'] = avatarUrl;
    return data;
  }

  @override
  String toString() {
    return 'Speaker(name: $name, kana: $kana, twitter: $twitter, avatarUrl: $avatarUrl)';
  }
}

class Feedback {
  bool? open;

  Feedback({this.open});

  Feedback.fromJson(Map<String, dynamic> json) {
    open = json['open'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['open'] = open;
    return data;
  }

  @override
  String toString() => 'Feedback(open: $open)';
}
