/// _id : "65a6384e918aad8a3560a98b"
/// coursesId : [{"_id":"65a63753918aad8a3560a98a","title":"Blender: Design 3D Illustration"}]
/// createdAt : "2024-01-16T08:03:26.272Z"
/// lesson : [{"_id":"65a639ba918aad8a3560a98d","title":"Pengenalan Blender"},{"_id":"65a73dc6918aad8a3560a9dd","title":"Atque id eaque magni"}]
/// title : "3D Design"

class ChapterData {
  ChapterData({
      String? id, 
      List<CoursesId>? coursesId, 
      String? createdAt, 
      List<Lesson>? lesson, 
      String? title,}){
    _id = id;
    _coursesId = coursesId;
    _createdAt = createdAt;
    _lesson = lesson;
    _title = title;
}

  ChapterData.fromJson(dynamic json) {
    _id = json['_id'];
    if (json['coursesId'] != null) {
      _coursesId = [];
      json['coursesId'].forEach((v) {
        _coursesId?.add(CoursesId.fromJson(v));
      });
    }
    _createdAt = json['createdAt'];
    if (json['lesson'] != null) {
      _lesson = [];
      json['lesson'].forEach((v) {
        _lesson?.add(Lesson.fromJson(v));
      });
    }
    _title = json['title'];
  }
  String? _id;
  List<CoursesId>? _coursesId;
  String? _createdAt;
  List<Lesson>? _lesson;
  String? _title;
ChapterData copyWith({  String? id,
  List<CoursesId>? coursesId,
  String? createdAt,
  List<Lesson>? lesson,
  String? title,
}) => ChapterData(  id: id ?? _id,
  coursesId: coursesId ?? _coursesId,
  createdAt: createdAt ?? _createdAt,
  lesson: lesson ?? _lesson,
  title: title ?? _title,
);
  String? get id => _id;
  List<CoursesId>? get coursesId => _coursesId;
  String? get createdAt => _createdAt;
  List<Lesson>? get lesson => _lesson;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_coursesId != null) {
      map['coursesId'] = _coursesId?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = _createdAt;
    if (_lesson != null) {
      map['lesson'] = _lesson?.map((v) => v.toJson()).toList();
    }
    map['title'] = _title;
    return map;
  }

}

/// _id : "65a639ba918aad8a3560a98d"
/// title : "Pengenalan Blender"

class Lesson {
  Lesson({
      String? id, 
      String? title,}){
    _id = id;
    _title = title;
}

  Lesson.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
  }
  String? _id;
  String? _title;
Lesson copyWith({  String? id,
  String? title,
}) => Lesson(  id: id ?? _id,
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

/// _id : "65a63753918aad8a3560a98a"
/// title : "Blender: Design 3D Illustration"

class CoursesId {
  CoursesId({
      String? id, 
      String? title,}){
    _id = id;
    _title = title;
}

  CoursesId.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
  }
  String? _id;
  String? _title;
CoursesId copyWith({  String? id,
  String? title,
}) => CoursesId(  id: id ?? _id,
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