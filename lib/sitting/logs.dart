import 'package:flutter/foundation.dart';

class Logs {
  int? id;
  String? actionname;
  String? username;
  String? date;

  Logs({@required this.username, @required this.actionname, this.id,@required this.date});

  Map<String, dynamic> toMap() {
    return {'username': username, 'actionname': actionname , 'date' : date};
  }
}
