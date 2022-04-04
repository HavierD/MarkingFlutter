import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SchemeClass
{
  String type;
  int number;
  int order;

  SchemeClass({this.type, this.number, this.order});
  SchemeClass.fromJson(Map<String, dynamic> json)
  :
        type = json['type'],
        number = json['number'],
        order = json['order'];
  Map<String, dynamic> toJson() =>
      {
        'type': type,
        'number': number,
        'order': order,
      };
}

class SchemeModel extends ChangeNotifier{
  final List<SchemeClass> schemeItems = [];
  CollectionReference schemeCollection = FirebaseFirestore.instance.collection('scheme');
  bool loadingScheme = false;
  SchemeModel(){
    getScheme();
  }
  
  void getScheme() async
  {
    schemeItems.clear();
    loadingScheme = true;
    notifyListeners();
    var querySnapshotScheme = await schemeCollection.orderBy('order').get();
    querySnapshotScheme.docs.forEach((doc) {
      var oneScheme = SchemeClass.fromJson(doc.data());
      schemeItems.add(oneScheme);
    });
    loadingScheme = false;
    notifyListeners();
  }

  void update(String weekDoc, SchemeClass item) async
  {
    loadingScheme = true;
    notifyListeners();
    await schemeCollection.doc(weekDoc).set(item.toJson());
    await getScheme();
  }


  SchemeClass get(int orderNo){
    return schemeItems.firstWhere((scheme) => scheme.order == orderNo);
  }

  
}