/// _id : "65a4b968918aad8a3560a95c"
/// artist : "Frankie"
/// createdAt : "2024-01-15T04:49:44.14Z"
/// description : "Teknik prestasi yang baik dan benar melibatkan kombinasi keterampilan, sikap, dan strategi yang memungkinkan seseorang atau sebuah tim mencapai hasil optimal dalam berbagai bidang."
/// isPremium : "yes"
/// jobTitle : "Motivator"
/// languange : "indonesia"
/// path : [{"fileName":"Things Fall Apart by Chinua Achebe Summary (Full Book in JUST 5 Minutes).mp3","url":"https://api.kontenbase.com/upload/file/storage/65a0e330fac3f5febba7f7f8/Things Fall Apart by Chinua Achebe Summary (Full Book in JUST 5 Minutes)-nqeJqtZU.mp3"}]
/// thumbnail : [{"fileName":"EmotionalIntelligence2.0.jpg","url":"https://api.kontenbase.com/upload/file/storage/65a0e330fac3f5febba7f7f8/EmotionalIntelligence2.0-UJKxtUVE.jpg"}]
/// time : 3
/// title : "Teknik prestasi yang baik dan benar"

class Audiobook {
  Audiobook({
      String? id, 
      String? artist, 
      String? createdAt, 
      String? description, 
      String? isPremium, 
      String? jobTitle, 
      String? languange, 
      List<Path>? path, 
      List<Thumbnail>? thumbnail, 
      num? time, 
      String? title,}){
    _id = id;
    _artist = artist;
    _createdAt = createdAt;
    _description = description;
    _isPremium = isPremium;
    _jobTitle = jobTitle;
    _languange = languange;
    _path = path;
    _thumbnail = thumbnail;
    _time = time;
    _title = title;
}

  Audiobook.fromJson(dynamic json) {
    _id = json['_id'];
    _artist = json['artist'];
    _createdAt = json['createdAt'];
    _description = json['description'];
    _isPremium = json['isPremium'];
    _jobTitle = json['jobTitle'];
    _languange = json['languange'];
    if (json['path'] != null) {
      _path = [];
      json['path'].forEach((v) {
        _path?.add(Path.fromJson(v));
      });
    }
    if (json['thumbnail'] != null) {
      _thumbnail = [];
      json['thumbnail'].forEach((v) {
        _thumbnail?.add(Thumbnail.fromJson(v));
      });
    }
    _time = json['time'];
    _title = json['title'];
  }
  String? _id;
  String? _artist;
  String? _createdAt;
  String? _description;
  String? _isPremium;
  String? _jobTitle;
  String? _languange;
  List<Path>? _path;
  List<Thumbnail>? _thumbnail;
  num? _time;
  String? _title;
Audiobook copyWith({  String? id,
  String? artist,
  String? createdAt,
  String? description,
  String? isPremium,
  String? jobTitle,
  String? languange,
  List<Path>? path,
  List<Thumbnail>? thumbnail,
  num? time,
  String? title,
}) => Audiobook(  id: id ?? _id,
  artist: artist ?? _artist,
  createdAt: createdAt ?? _createdAt,
  description: description ?? _description,
  isPremium: isPremium ?? _isPremium,
  jobTitle: jobTitle ?? _jobTitle,
  languange: languange ?? _languange,
  path: path ?? _path,
  thumbnail: thumbnail ?? _thumbnail,
  time: time ?? _time,
  title: title ?? _title,
);
  String? get id => _id;
  String? get artist => _artist;
  String? get createdAt => _createdAt;
  String? get description => _description;
  String? get isPremium => _isPremium;
  String? get jobTitle => _jobTitle;
  String? get languange => _languange;
  List<Path>? get path => _path;
  List<Thumbnail>? get thumbnail => _thumbnail;
  num? get time => _time;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['artist'] = _artist;
    map['createdAt'] = _createdAt;
    map['description'] = _description;
    map['isPremium'] = _isPremium;
    map['jobTitle'] = _jobTitle;
    map['languange'] = _languange;
    if (_path != null) {
      map['path'] = _path?.map((v) => v.toJson()).toList();
    }
    if (_thumbnail != null) {
      map['thumbnail'] = _thumbnail?.map((v) => v.toJson()).toList();
    }
    map['time'] = _time;
    map['title'] = _title;
    return map;
  }

}

/// fileName : "EmotionalIntelligence2.0.jpg"
/// url : "https://api.kontenbase.com/upload/file/storage/65a0e330fac3f5febba7f7f8/EmotionalIntelligence2.0-UJKxtUVE.jpg"

class Thumbnail {
  Thumbnail({
      String? fileName, 
      String? url,}){
    _fileName = fileName;
    _url = url;
}

  Thumbnail.fromJson(dynamic json) {
    _fileName = json['fileName'];
    _url = json['url'];
  }
  String? _fileName;
  String? _url;
Thumbnail copyWith({  String? fileName,
  String? url,
}) => Thumbnail(  fileName: fileName ?? _fileName,
  url: url ?? _url,
);
  String? get fileName => _fileName;
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fileName'] = _fileName;
    map['url'] = _url;
    return map;
  }

}

/// fileName : "Things Fall Apart by Chinua Achebe Summary (Full Book in JUST 5 Minutes).mp3"
/// url : "https://api.kontenbase.com/upload/file/storage/65a0e330fac3f5febba7f7f8/Things Fall Apart by Chinua Achebe Summary (Full Book in JUST 5 Minutes)-nqeJqtZU.mp3"

class Path {
  Path({
      String? fileName, 
      String? url,}){
    _fileName = fileName;
    _url = url;
}

  Path.fromJson(dynamic json) {
    _fileName = json['fileName'];
    _url = json['url'];
  }
  String? _fileName;
  String? _url;
Path copyWith({  String? fileName,
  String? url,
}) => Path(  fileName: fileName ?? _fileName,
  url: url ?? _url,
);
  String? get fileName => _fileName;
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fileName'] = _fileName;
    map['url'] = _url;
    return map;
  }

}