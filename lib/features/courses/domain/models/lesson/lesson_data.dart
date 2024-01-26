/// _id : "65a639ba918aad8a3560a98d"
/// chapterId : [{"_id":"65a6384e918aad8a3560a98b","title":"3D Design"}]
/// createdAt : "2024-01-16T08:09:30.845Z"
/// path : [{"fileName":"Talent Insider - Learning.webm","url":"https://api.kontenbase.com/upload/file/storage/65a0e330fac3f5febba7f7f8/Talent Insider - Learning-NGoOAHnz.webm"}]
/// title : "Pengenalan Blender"

class LessonData {
  LessonData({
      String? id, 
      List<ChapterId>? chapterId, 
      String? createdAt, 
      List<Path>? path, 
      String? title,}){
    _id = id;
    _chapterId = chapterId;
    _createdAt = createdAt;
    _path = path;
    _title = title;
}

  LessonData.fromJson(dynamic json) {
    _id = json['_id'];
    if (json['chapterId'] != null) {
      _chapterId = [];
      json['chapterId'].forEach((v) {
        _chapterId?.add(ChapterId.fromJson(v));
      });
    }
    _createdAt = json['createdAt'];
    if (json['path'] != null) {
      _path = [];
      json['path'].forEach((v) {
        _path?.add(Path.fromJson(v));
      });
    }
    _title = json['title'];
  }
  String? _id;
  List<ChapterId>? _chapterId;
  String? _createdAt;
  List<Path>? _path;
  String? _title;
LessonData copyWith({  String? id,
  List<ChapterId>? chapterId,
  String? createdAt,
  List<Path>? path,
  String? title,
}) => LessonData(  id: id ?? _id,
  chapterId: chapterId ?? _chapterId,
  createdAt: createdAt ?? _createdAt,
  path: path ?? _path,
  title: title ?? _title,
);
  String? get id => _id;
  List<ChapterId>? get chapterId => _chapterId;
  String? get createdAt => _createdAt;
  List<Path>? get path => _path;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_chapterId != null) {
      map['chapterId'] = _chapterId?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = _createdAt;
    if (_path != null) {
      map['path'] = _path?.map((v) => v.toJson()).toList();
    }
    map['title'] = _title;
    return map;
  }

}

/// fileName : "Talent Insider - Learning.webm"
/// url : "https://api.kontenbase.com/upload/file/storage/65a0e330fac3f5febba7f7f8/Talent Insider - Learning-NGoOAHnz.webm"

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

/// _id : "65a6384e918aad8a3560a98b"
/// title : "3D Design"

class ChapterId {
  ChapterId({
      String? id, 
      String? title,}){
    _id = id;
    _title = title;
}

  ChapterId.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
  }
  String? _id;
  String? _title;
ChapterId copyWith({  String? id,
  String? title,
}) => ChapterId(  id: id ?? _id,
  title: title ?? _title,
);
  String? get id => _id;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    return map;
  }

}