import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huaizhidai530562kit607a4/studentClassDart.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class StudentDetails extends StatefulWidget {
  final String indexId;

  const StudentDetails({Key key, this.indexId}) : super(key: key);

  @override
  _StudentDetailsState createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final familyNameController = TextEditingController();
  final idController = TextEditingController();


  
  _getFromGallery()async{
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 100,
      maxHeight: 100,
    );
    var file11 = File(pickedFile.path);
    try {
      await FirebaseStorage.instance.ref('uploads/here.png').putFile(file11);
    }on FirebaseException catch (e){
      print("error??????");
      print(e);
    }
    
  }






  @override
  Widget build(BuildContext context) {
   // var students = Provider.of<StudentModel>(context, listen: false).items;

    var oneStudent = Provider.of<StudentModel>(context, listen: false).get(widget.indexId);
    var adding = oneStudent == null ;
    int a2;
    int a3;
    int a4;
    int a5;
    int a6;
    int a7;
    int a8;
    int a9;
    int a10;
    int a11;
    int a12;
    int sum;
    int summary;


    if (!adding)
    {
      firstNameController.text = oneStudent.firstName;
      familyNameController.text = oneStudent.familyName;
      idController.text = oneStudent.id;
       a2 = oneStudent.w2 ?? 0;
       a3 = oneStudent.w3 ?? 0;
       a4 = oneStudent.w4 ?? 0;
       a5 = oneStudent.w5 ?? 0;
       a6 = oneStudent.w6 ?? 0;
       a7 = oneStudent.w7 ?? 0;
       a8 = oneStudent.w8 ?? 0;
       a9 = oneStudent.w9 ?? 0;
       a10 = oneStudent.w10 ?? 0;
       a11 = oneStudent.w11 ?? 0;
       a12 = oneStudent.w12 ?? 0;
       sum = a2 + a3 + a4 + a5 + a6 + a7 + a8 + a9 + a10 + a11 + a12;
       summary = sum ~/ 11;
    }
    //return Text(widget.indexId + "   " + students.length.toString());
    





    return Scaffold(
      appBar: AppBar(
        title: Text(adding ? "Add a new student": "Student details" ),
        actions: [

          if(!adding)
            IconButton(icon: const Icon(Icons.delete_forever), onPressed: (){
              showCupertinoDialog(context: context, builder:(_) => CupertinoAlertDialog(
                title: Text("Warning!") ,
                content: Text("Do you want to remove" + oneStudent.firstName + " " +
                    oneStudent.familyName + " forever?"),
                actions: [
                  CupertinoButton(child: Text("Confirm"), onPressed:
                  (){
                    showCupertinoDialog(context: context, builder: (_) =>
                    CupertinoAlertDialog(
                      title: Text("WARNING!!!"),
                      content: Text("If you now choose CONFIRM, this student "
                          "will be removed forever and cannot be undo!"),
                      actions: [
                        CupertinoButton(child: Text("Confirm"), onPressed:
                        (){
                          Provider.of<StudentModel>(context, listen: false).delete(oneStudent.iid);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                        ),
                        CupertinoButton(child: Text("Cancel"), onPressed: (){
                          Navigator.pop(context);
                          Navigator.pop(context);
                        })
                      ],
                    ));
                  }
                  ),
                  CupertinoButton(child: Text("Cancel"), onPressed: (){
                    Navigator.pop(context);
                  })
                ],
              ));
            }),
          if(!adding)
            IconButton(icon: const Icon(Icons.help), onPressed: () => {
              showCupertinoDialog(context: context,
                  builder: (_) => CupertinoAlertDialog(
                    title: Text("HELP"),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("1. Have no time to design vivid help modal boxes as my iOS app. ╮(╯_╰)╭ ."),
                        Text("2. This page shows a chosen student's detail."),
                        Text("3. You can edit the student here."),
                        Text("4. On the right top, there are remove button, share button, "
                            "and camera button."),
                        Text("5. The SHARE function has a subject (who's marks) and a "
                            "content (including names, ID, and marks.). When you "
                            "share by mail, you can see the entire contents of subject and content.")
                      ],
                    ),
                    actions: [
                      CupertinoButton(child: Text("OK"), onPressed: () => {Navigator.pop(context)})
                    ],
                  )
              )
            }),

          if(!adding)
            IconButton(icon: const Icon(Icons.ios_share), onPressed: (){
            Share.share("Student Name: " + oneStudent.firstName + oneStudent.familyName +
                ". Student ID: " + oneStudent.id + ". Week 2: $a2; Week 3: $a3;"
                "Week 4: $a4; Week 5: $a5; Week 6: $a6; Week 7: $a7; Week 8: $a8;"
                "Week 9: $a9; Week 10: $a10; Week 11: $a11; Week 12: $a12; ",
                subject: "Marks of " + oneStudent.firstName + " " + oneStudent.familyName);
          }),
          if(!adding)
          IconButton(
              icon: const Icon(Icons.camera_alt_outlined),
              onPressed: () async {
                print("button onpressed?");

                final cameras = await availableCameras();
                final firstCamera = cameras.first;
                var picture = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => TakePictureScreen(
                  camera:firstCamera
                )));

              }),
          if(!adding)
            IconButton(icon: const Icon(Icons.photo_album), onPressed: _getFromGallery),
          IconButton(icon: const Icon(Icons.question_answer), onPressed: () => {
            showCupertinoDialog(context: context,
                builder: (_) => CupertinoAlertDialog(
                  title: Text("A useless button"),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Just because when using web emulator, the DEBUG flag will block the first button on the right. . . "
                          "So this was put in a place to prevent important buttons from being blocked ╮(╯_╰)╭ ."),

                    ],
                  ),
                  actions: [
                    CupertinoButton(child: Text("OK"), onPressed: () => {Navigator.pop(context)})
                  ],
                )
            )
          })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Choose student ID ${widget.indexId}"),
                Form(
                  key: _formKey,
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                       
                        TextFormField(
                          decoration: InputDecoration(labelText: "First Name"),
                          controller: firstNameController,
                          autofocus: true,
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Family Name"),
                          controller: familyNameController,
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Student ID"),
                          controller: idController,
                        ),

                        if(!adding)
                          if(oneStudent.image!=null )
                          Image.network(
                           oneStudent.image,
                         loadingBuilder: (context, child,progress){
                             return progress == null? child : LinearProgressIndicator();
                         },
                         width: 100,
                         height: 150,
                         fit:BoxFit.contain,
                       ),
                       
                       // FutureBuilder(
                       //   future: imageFromStorage(oneStudent.iid),
                       //     builder: (context, snapshot){
                       //     if(snapshot.hasData == false){
                       //       return CircularProgressIndicator();
                       //     }
                       //     var downloadUrl = snapshot.data;
                       //     return Image.network(downloadUrl);
                       //     }
                       // ),





                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ElevatedButton.icon(onPressed: (){
                            if(_formKey.currentState.validate())
                              {
                                var a = firstNameController.text;
                                var b = familyNameController.text;
                                var c = idController.text;
                                final checkNumber = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
                                final checkLetter = RegExp(r'^[a-zA-Z]+$');
                                if(checkLetter.hasMatch(a) == false || checkLetter.hasMatch(b) == false
                                || checkNumber.hasMatch(c) == false){
                                  //name area letters only and id numbers only
                                  showCupertinoDialog(context: context,
                                      builder: (_) => CupertinoAlertDialog(
                                        title: Text("Wrong input!"),
                                        content: Text("The name can only be letters, and the ID can only be numbers!!"),
                                        actions: [
                                          CupertinoButton(child: Text("OK"), onPressed: (){
                                            Navigator.pop(context);
                                          })
                                        ],
                                      ) );
                                }else {
                                  if (adding)
                                  {
                                    oneStudent = StudentClass();
                                  }


                                  oneStudent.firstName = firstNameController.text;
                                  oneStudent.familyName = familyNameController.text;
                                  oneStudent.id = idController.text;
                                  oneStudent.iid = idController.text;
                                  if(adding)
                                    Provider.of<StudentModel>(context, listen: false).add(oneStudent);
                                  else
                                    Provider.of<StudentModel>(context, listen: false).update(widget.indexId, oneStudent);
                                  //update model

                                  Provider.of<StudentModel>(context, listen:false).notifyListeners();
                                  //return to previous page
                                  Navigator.pop(context);
                                }



                              }
                          },
                              icon: Icon(Icons.save),
                              label: Text("Save Edit")),
                        ),
                        if(!adding)
                        CupertinoButton(child: Text("Marks of every week:")),

                        if(!adding)
                        Table(
                          children: <TableRow>[
                            TableRow(
                              children: <Widget>[
                                TableCell(child: Text("Week 02: " +a2.toString())),
                                TableCell(child: Text("Week 03: " +a3.toString())),
                                TableCell(child: Text("Week 04: " +a4.toString())),
                                TableCell(child: Text("Week 05: " +a5.toString())),

                              ]
                            ),
                            TableRow(
                              children: <Widget>[
                                TableCell(child: Text("Week 06: " +a6.toString())),
                                TableCell(child: Text("Week 07: " +a7.toString())),
                                TableCell(child: Text("Week 08: " +a8.toString())),
                                TableCell(child: Text("Week 09: " +a9.toString())),

                              ]
                            ),
                            TableRow(
                              children: <Widget>[
                                TableCell(child: Text("Week 10: " +a10.toString())),
                                TableCell(child: Text("Week 11: " +a11.toString())),
                                TableCell(child: Text("Week 12: " +a12.toString())),
                                TableCell(child: Text("")),
                              ]
                            )

                          ],
                        ),
                        if(!adding)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Summary: " + summary.toString()),
                        )
                      ],
                    ),

                  ),

                ),

              ],
            ),


      ),

    );
  }

  imageFromStorage(String iid)async {
    print("do this?");
    try{
      print("step first");
      final ref = await FirebaseStorage.instance.ref("/100000").listAll();
      //var url = await ref.getDownloadURL();
      print("step here");
      ref.items.forEach((Reference ref) {
        print('file here $ref'  );
      });
      print("front e");
    }on FirebaseException catch(e){
      print(e);
      print("after e");

    }




  }



}



class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;
  const TakePictureScreen({Key key, @required this.camera}) : super(key: key);

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  @override
  Widget build(BuildContext context) {

    print("state class front of futurebuilder");
    FutureBuilder<void>(
      future: _initializeControllerFuture,
        builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return CameraPreview(_controller);
        }
        else{
          return Center(child: CircularProgressIndicator(),);
        }
        },
    );
    FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: ()async{
          try{
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            print(image?.path);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DisplayPictureScreen(
                      imagePath: image?.path,
                    )

                )
            );
          }catch(e){
            print(e);
          }


        }

    );

  }

  void initState(){
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display images'),),
      body: Image.file(File(imagePath)),
    );
  }
}



