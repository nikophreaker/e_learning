/// _id : "65a63753918aad8a3560a98a"
/// author : "Diego"
/// category : "Design"
/// chapter : [{"_id":"65a6384e918aad8a3560a98b","title":"3D Design"},{"_id":"65a638ca918aad8a3560a98c","title":"3D Design to UI"},{"_id":"65a73c52918aad8a3560a9d5","title":"Non sunt omnis ut q"},{"_id":"65a73c5a918aad8a3560a9d6","title":"Nostrum mollitia ea "},{"_id":"65a73c61918aad8a3560a9d7","title":"Voluptatem Quis ut "},{"_id":"65a73c68918aad8a3560a9d8","title":"Error amet in qui u"},{"_id":"65a73c6e918aad8a3560a9d9","title":"Libero labore aute i"},{"_id":"65a73c74918aad8a3560a9da","title":"Sequi ea ipsa imped"},{"_id":"65a73c7b918aad8a3560a9db","title":"Sint adipisci explic"},{"_id":"65a73c84918aad8a3560a9dc","title":"Ea doloribus eius re"}]
/// createdAt : "2024-01-16T07:59:15.349Z"
/// path : [{"fileName":"Talent Insider - Learning.webm","url":"https://api.kontenbase.com/upload/file/storage/65a0e330fac3f5febba7f7f8/Talent Insider - Learning-vCegQNCX.webm"}]
/// title : "Blender: Design 3D Illustration"

class CourseData {
  CourseData({
      String? id, 
      String? author, 
      String? category, 
      List<Chapter>? chapter, 
      String? createdAt, 
      List<Path>? path, 
      String? title,}){
    _id = id;
    _author = author;
    _category = category;
    _chapter = chapter;
    _createdAt = createdAt;
    _path = path;
    _title = title;
}

  CourseData.fromJson(dynamic json) {
    _id = json['_id'];
    _author = json['author'];
    _category = json['category'];
    if (json['chapter'] != null) {
      _chapter = [];
      json['chapter'].forEach((v) {
        _chapter?.add(Chapter.fromJson(v));
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
  String? _author;
  String? _category;
  List<Chapter>? _chapter;
  String? _createdAt;
  List<Path>? _path;
  String? _title;
CourseData copyWith({  String? id,
  String? author,
  String? category,
  List<Chapter>? chapter,
  String? createdAt,
  List<Path>? path,
  String? title,
}) => CourseData(  id: id ?? _id,
  author: author ?? _author,
  category: category ?? _category,
  chapter: chapter ?? _chapter,
  createdAt: createdAt ?? _createdAt,
  path: path ?? _path,
  title: title ?? _title,
);
  String? get id => _id;
  String? get author => _author;
  String? get category => _category;
  List<Chapter>? get chapter => _chapter;
  String? get createdAt => _createdAt;
  List<Path>? get path => _path;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['author'] = _author;
    map['category'] = _category;
    if (_chapter != null) {
      map['chapter'] = _chapter?.map((v) => v.toJson()).toList();
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
/// url : "https://api.kontenbase.com/upload/file/storage/65a0e330fac3f5febba7f7f8/Talent Insider - Learning-vCegQNCX.webm"

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

class Chapter {
  Chapter({
      String? id, 
      String? title,}){
    _id = id;
    _title = title;
}

  Chapter.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
  }
  String? _id;
  String? _title;
Chapter copyWith({  String? id,
  String? title,
}) => Chapter(  id: id ?? _id,
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