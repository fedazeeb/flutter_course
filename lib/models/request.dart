import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course/models/item.dart';

class Request {
  String? userid;
  DateTime? requestdate;
  double? totalprice;
  List<Item> items;
  final CollectionReference _request =
      FirebaseFirestore.instance.collection('Requests');

  Request(
      {this.requestdate, this.userid, this.totalprice, required this.items});

  Future<bool> add_request() async {
    await _request.add({
      'username': "tessst", // John Doe
      'date': requestdate, // Stokes and Sons
      'totalprice': totalprice // 42
    }).then((value) {
      print(value.id);
      for (var element in items) {
        _request.doc(value.id).collection('Selected').add({
          'name': element.name,
          'count' : element.count,
          'price': element.price! * element.count,
        });
      }
      // _request.doc(value.id).collection('votes').add({
      //   'registerDate': DateTime.now(),
      // });
    }).catchError((error) => print("Failed to add user: $error"));
    return true;
  }
}
