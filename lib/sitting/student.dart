import 'package:flutter/foundation.dart';

class ActionLogs {
  int? id;
  String? name;
  String? course;

  ActionLogs({@required this.name, @required this.course, this.id});

  Map<String, dynamic> toMap() {
    return {'name': name, 'course': course};
  }
}
