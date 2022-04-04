import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huaizhidai530562kit607a4/schemeClass.dart';
import 'package:huaizhidai530562kit607a4/studentClassDart.dart';
import 'package:huaizhidai530562kit607a4/weekly.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return FullScreenText(
            text: "something wrong",
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(providers:
          [
              ChangeNotifierProvider( create: (context) => StudentModel(),),
              ChangeNotifierProvider( create: (context) => SchemeModel(),),

          ],
            child: MaterialApp(
              title: 'Havier Huaizhi Dai',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: MyHomePage(title: 'List Tutorial'),
            ),
          );
        }
        return FullScreenText(
          text: "loading",
        );
      },
    );
  }
}

//  real  weekly page
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // return buildScaffold(context);
    return Consumer<SchemeModel>(builder: buildScaffold);
  }

  Scaffold buildScaffold(BuildContext context, SchemeModel schemeModel, _) {
    if (schemeModel.schemeItems.length == 0) {
      print("nothing in database");
      return Scaffold();
    } else
      return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            IconButton(icon: const Icon(Icons.help), onPressed: () => {
              showCupertinoDialog(context: context,
                  builder: (_) => CupertinoAlertDialog(
                    title: Text("HELP"),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("1. Have no time to design vivid help modal boxes as my iOS app. ╮(╯_╰)╭ ."),
                        Text("2. This page shows weeks and their marking type."),
                        Text("3. You can click Week XX to turn weekly page."),
                        Text("4. You can click marking types to change the marking scheme."),
                      ],
                    ),
                    actions: [
                      CupertinoButton(child: Text("OK"), onPressed: () => {Navigator.pop(context)})
                    ],
                  )
                  )
            }),
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
            }),

          ],
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  WeekButton(week: "Week 02", wk: "w2", scheme: schemeModel.schemeItems[0].type, schemeNumber: schemeModel.schemeItems[0].number, ),
                  WeekButton(week: "Week 03", wk: "w3", scheme: schemeModel.schemeItems[1].type, schemeNumber: schemeModel.schemeItems[1].number,),
                  WeekButton(week: "Week 04", wk: "w4", scheme: schemeModel.schemeItems[2].type, schemeNumber: schemeModel.schemeItems[2].number,),
                  WeekButton(week: "Week 05", wk: "w5", scheme: schemeModel.schemeItems[3].type, schemeNumber: schemeModel.schemeItems[3].number,),
                  WeekButton(week: "Week 06", wk: "w6", scheme: schemeModel.schemeItems[4].type, schemeNumber: schemeModel.schemeItems[4].number,),
                  WeekButton(week: "Week 07", wk: "w7", scheme: schemeModel.schemeItems[5].type, schemeNumber: schemeModel.schemeItems[5].number,),
                  WeekButton(week: "Week 08", wk: "w8", scheme: schemeModel.schemeItems[6].type, schemeNumber: schemeModel.schemeItems[6].number,),
                  WeekButton(week: "Week 09", wk: "w9", scheme: schemeModel.schemeItems[7].type, schemeNumber: schemeModel.schemeItems[7].number,),
                  WeekButton(week: "Week 10", wk: "w10", scheme: schemeModel.schemeItems[8].type, schemeNumber: schemeModel.schemeItems[8].number,),
                  WeekButton(week: "Week 11", wk: "w11", scheme: schemeModel.schemeItems[9].type, schemeNumber: schemeModel.schemeItems[9].number,),
                  WeekButton(week: "Week 12", wk: "w12", scheme: schemeModel.schemeItems[10].type, schemeNumber: schemeModel.schemeItems[10].number,),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () => showCupertinoDialog(
                          context: context,
                          builder: (_) => changeSchemeAlert(schemeModel.schemeItems[0].type, "Week 2", schemeModel.schemeItems[0], context),
                        ),
                        child: Text(schemeModel.schemeItems[0].type)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () => showCupertinoDialog(
                          context: context,
                          builder: (_) => changeSchemeAlert(schemeModel.schemeItems[1].type, "Week 3", schemeModel.schemeItems[1], context),
                        ),
                        child: Text(schemeModel.schemeItems[1].type)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () => showCupertinoDialog(
                          context: context,
                          builder: (_) => changeSchemeAlert(schemeModel.schemeItems[2].type, "Week 4", schemeModel.schemeItems[2], context),
                        ),
                        child: Text(schemeModel.schemeItems[2].type)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () => showCupertinoDialog(
                          context: context,
                          builder: (_) => changeSchemeAlert(schemeModel.schemeItems[3].type, "Week 5", schemeModel.schemeItems[3], context),
                        ),
                        child: Text(schemeModel.schemeItems[3].type)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () => showCupertinoDialog(
                          context: context,
                          builder: (_) => changeSchemeAlert(schemeModel.schemeItems[4].type, "Week 6", schemeModel.schemeItems[4], context),
                        ),
                        child: Text(schemeModel.schemeItems[4].type)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () => showCupertinoDialog(
                          context: context,
                          builder: (_) => changeSchemeAlert(schemeModel.schemeItems[5].type, "Week 7", schemeModel.schemeItems[5], context),
                        ),
                        child: Text(schemeModel.schemeItems[5].type)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () => showCupertinoDialog(
                          context: context,
                          builder: (_) => changeSchemeAlert(schemeModel.schemeItems[6].type, "Week 8", schemeModel.schemeItems[6], context),
                        ),
                        child: Text(schemeModel.schemeItems[6].type)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () => showCupertinoDialog(
                          context: context,
                          builder: (_) => changeSchemeAlert(schemeModel.schemeItems[7].type, "Week 9", schemeModel.schemeItems[7], context),
                        ),
                        child: Text(schemeModel.schemeItems[7].type)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () => showCupertinoDialog(
                          context: context,
                          builder: (_) => changeSchemeAlert(schemeModel.schemeItems[8].type, "Week 10", schemeModel.schemeItems[8], context),
                        ),
                        child: Text(schemeModel.schemeItems[8].type)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () => showCupertinoDialog(
                          context: context,
                          builder: (_) => changeSchemeAlert(schemeModel.schemeItems[9].type, "Week 11", schemeModel.schemeItems[9], context),
                        ),
                        child: Text(schemeModel.schemeItems[9].type)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () => showCupertinoDialog(
                          context: context,
                          builder: (_) => changeSchemeAlert(schemeModel.schemeItems[10].type, "Week 12", schemeModel.schemeItems[10], context),
                        ),
                        child: Text(schemeModel.schemeItems[10].type)),
                  ),


                ],
              )
            ],
          ),
        ),
      );
  }
}



CupertinoAlertDialog changeSchemeAlert(String currentSchemeType, String currentWeek, SchemeClass schemeClass, BuildContext context){

  final _totalScoreFormKey = GlobalKey<FormState>();
  final totalScoreInputController = TextEditingController();

  return CupertinoAlertDialog(
    title: Text("Change Marking scheme from $currentSchemeType to:"),
    content: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CupertinoButton(
            child: Text("Checkbox"),
            onPressed: (){
              updateScheme( schemeClass,currentWeek, "Checkbox",0,context);
              Navigator.pop(context);
            }
        ),
        CupertinoButton(
            child: Text("Grade(HD~NN)"),
            onPressed: (){
              updateScheme( schemeClass,currentWeek, "Grade(HD/DN/CR/PP/NN)",0,context);
              Navigator.pop(context);
            }
        ),
        CupertinoButton(
            child: Text("Grade(A~F)"),
            onPressed: (){
              updateScheme( schemeClass,currentWeek, "Grade (A/B/C/D/F)",0,context);
              Navigator.pop(context);
            }
        ),
        CupertinoButton(
            child: Text("Multi-Checkbox"),////////////////////////////////////////////////////button multi checkbox 4
            onPressed: (){
              showCupertinoDialog(
                context: context,
                builder: (_) => CupertinoAlertDialog(
                  title: Text("Please choose the number of checkboxes (2 ~ 5)"),
                  content:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoButton(child: Text("     2 Checkboxes     "),
                          onPressed: (){
                        updateScheme(schemeClass, currentWeek, "Multi-Checkbox",2, context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                          }
                      ),
                      CupertinoButton(child: Text("     3 Checkboxes    "),
                          onPressed: (){
                            updateScheme(schemeClass, currentWeek, "Multi-Checkbox",3, context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                      ),
                      CupertinoButton(child: Text("     4 Checkboxes     "),
                          onPressed: (){
                            updateScheme(schemeClass, currentWeek, "Multi-Checkbox",4, context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                      ),
                      CupertinoButton(child: Text("     5 Checkboxes     "),
                          onPressed: (){
                            updateScheme(schemeClass, currentWeek, "Multi-Checkbox",5, context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                      ),
                    ],
                  ) ,
                  actions: [
                    CupertinoButton(
                        onPressed: () {
                          Navigator.pop(context);

                        },
                        child: Text("Cancel")
                    ),
                  ],
                ),
              );
            }
        ),
        CupertinoButton(
            child: Text("Score"),
            onPressed: (){
              showCupertinoDialog(
                  context: context,
                  builder: (_) => CupertinoAlertDialog(
                    title: Text("Please type in the total score (2 ~ 100):"),
                    content: Material(
                    child: Form(
                    key: _totalScoreFormKey,
                    child: TextFormField(
                      decoration:
                      InputDecoration(labelText: "total score (2 ~ 100):"),
                      controller: totalScoreInputController,
                      autofocus: true,
                    ),
                  ),
              ),
                    actions: [
                      CupertinoButton(child: Text("Cancel"),
                          onPressed:(){
                        Navigator.pop(context);
                          } ),
                      CupertinoButton(
                          child: Text("Confirm"),
                          onPressed: (){
                            if (verifyTotalScoreInput(totalScoreInputController.text) == 0)  //all good
                            {
                              var scoreA = int.parse(totalScoreInputController.text);
                              updateScheme(schemeClass, currentWeek, "Score", scoreA, context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                            else if (verifyTotalScoreInput(totalScoreInputController.text) == 1)//not only number
                                {
                              showCupertinoDialog(
                                context: context,
                                builder: (_) => CupertinoAlertDialog(
                                  title: Text("ERROR!"),
                                  content: Text(
                                      "NUMBER ONLY!"),
                                  actions: [
                                    CupertinoButton(
                                        child: Text("OK"),
                                        onPressed: () => {
                                          Navigator.pop(context),
                                        }),
                                  ],
                                ),
                              );
                            }
                            else if (verifyTotalScoreInput(totalScoreInputController.text) == 2)//cannot be empty
                                {
                              showCupertinoDialog(
                                context: context,
                                builder: (_) => CupertinoAlertDialog(
                                  title: Text("ERROR!"),
                                  content: Text(
                                      "cannot be empty!"),
                                  actions: [
                                    CupertinoButton(
                                        child: Text("OK"),
                                        onPressed: () => {
                                          Navigator.pop(context),
                                        }),
                                  ],
                                ),
                              );
                            }else if(verifyTotalScoreInput(totalScoreInputController.text) == 10){
                              showCupertinoDialog(
                                context: context,
                                builder: (_) => CupertinoAlertDialog(
                                  title: Text("ERROR!"),
                                  content: Text(
                                      "must be inside 2 ~ 100 !"),
                                  actions: [
                                    CupertinoButton(
                                        child: Text("OK"),
                                        onPressed: () => {
                                          Navigator.pop(context),
                                        }),
                                  ],
                                ),
                              );
                            }
                          }),
                    ],
                  )
              );
            }
        ),
      ],
    ),
    actions: [
      CupertinoButton(
          onPressed: () => Navigator.pop(context), child: Text("Cancel")),
    ],
  );
}

int verifyTotalScoreInput(String totalScoreInput) {
  final checkString = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
  if (totalScoreInput == "") {
    return 2;
  }else if(checkString.hasMatch(totalScoreInput)){
    int check = int.parse(totalScoreInput);
    if(check >= 2 && check <= 100){
      print("check is: "+ check.toString());
      return 0;
    }else{
      print("check is: "+ check.toString());
      return 10;
    }

  }else if(checkString.hasMatch(totalScoreInput) == false){
    return 1;
  }else{
    return 100;
  }
}

void updateScheme(SchemeClass schemeClass, String wk, String newScheme, int number, BuildContext context){
  schemeClass.type = newScheme;
  schemeClass.number = number;
  Provider.of<SchemeModel>(context, listen: false).update(wk, schemeClass);
}




class WeekButton extends StatelessWidget {
  const WeekButton({
    Key key, this.week, this.wk, this.scheme, this.schemeNumber,
  }) : super(key: key);
  final String week;
  final String wk;
  final String scheme;
  final int schemeNumber;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        child: Text(week),
        onPressed: () => {print(wk),
        Navigator.push(context, MaterialPageRoute(builder: (context) {return WeeklyPage(weekNumber: wk, passScheme: scheme, schemeNumber: schemeNumber,);} ))
        },
      ),
    );
  }
}

class FullScreenText extends StatelessWidget {
  final String text;

  const FullScreenText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Column(children: [Expanded(child: Center(child: Text(text)))]));
  }
}


