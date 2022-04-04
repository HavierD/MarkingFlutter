import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentClass
{
  String firstName;
  String familyName;
  String id;
  String iid;
  int w2;
  int w3;
  int w4;
  int w5;
  int w6;
  int w7;
  int w8;
  int w9;
  int w10;
  int w11;
  int w12;
  String image;

  StudentClass({
    this.firstName,
    this.familyName,
    this.id,
    this.iid,
    this.w2,
    this.w3,
    this.w4,
    this.w5,
    this.w6,
    this.w7,
    this.w8,
    this.w9,
    this.w10,
    this.w11,
    this.w12,

    this.image });

  StudentClass.fromJson(Map<String, dynamic> json)
      :
        firstName = json['firstName'],
        familyName = json['familyName'],
        id = json['id'],
        iid = json['iid'],
        w2 = json['w2'],
        w3 = json['w3'],
        w4 = json['w4'],
        w5 = json['w5'],
        w6 = json['w6'],
        w7 = json['w7'],
        w8 = json['w8'],
        w9 = json['w9'],
        w10 = json['w10'],
        w11 = json['w11'],
        w12 = json['w12'],
        image = json['image'];

  Map<String, dynamic> toJson() =>
      {
        'firstName' : firstName,
        'familyName' : familyName,
        'id' : id,
        'iid' : iid,
        'w2' : w2,
        'w3' : w3,
        'w4' : w4,
        'w5' : w5,
        'w6' : w6,
        'w7' : w7,
        'w8' : w8,
        'w9' : w9,
        'w10' : w10,
        'w11' : w11,
        'w12' : w12,
        'image' : image,
      };

}
class StudentModel extends ChangeNotifier {
  final List<StudentClass> items = [];
  CollectionReference studentsCollection = FirebaseFirestore.instance.collection('students');
   bool loading = false;
  StudentModel()
  {
    fetch();
  }

  void add(StudentClass item) async
  {
    loading = true;
    notifyListeners();
    //await studentsCollection.add(item.toJson());
    await studentsCollection.doc(item.id).set(item.toJson());
    await fetch();
  }

  void update(String iid, StudentClass item) async
  {
    loading = true;
    notifyListeners();
    await studentsCollection.doc(iid).set(item.toJson());
    await fetch();
  }

  void delete(String iid) async
  {
    loading = true;
    notifyListeners();
    await studentsCollection.doc(iid).delete();
    await fetch();
  }

  void removeAll() {
    items.clear();
    notifyListeners();
  }
  void fetch() async
  {
    // images
    // var imageId = student1.iid;
    // final ref = FirebaseStorage.instance.ref().child("/$imageId/$imageId");
    // var url = await ref.getDownloadURL();
    items.clear();
    loading = true;
    notifyListeners();
    var querySnapshot = await studentsCollection.orderBy("id").get();
    querySnapshot.docs.forEach((doc) {
      var student1 = StudentClass.fromJson(doc.data());
      student1.iid = doc.id;

      items.add(student1);
    });
    loading = false;
    notifyListeners();
  }
  StudentClass get(String iid){
    if (iid == null) return null;
    return items.firstWhere((student) => student.iid == iid);
  }
  void refresh(){
    notifyListeners();
  }
}
