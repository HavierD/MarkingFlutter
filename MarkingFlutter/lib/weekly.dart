import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huaizhidai530562kit607a4/studentClassDart.dart';
import 'package:huaizhidai530562kit607a4/student_detail.dart';
import 'package:provider/provider.dart';



class WeeklyPage extends StatefulWidget {
  final String weekNumber;
  final String passScheme;
  final int schemeNumber;

  const WeeklyPage({
    Key key,
    this.weekNumber,
    this.passScheme,
    this.schemeNumber,
  }) : super(key: key);

  @override
  _WeeklyPageState createState() => _WeeklyPageState();
}

class _WeeklyPageState extends State<WeeklyPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StudentModel>(
      builder: buildScaffoldStudentList,
    );
  }

  Scaffold buildScaffoldStudentList(
      BuildContext context, StudentModel studentModel, _) {


    bool filterBool = false;

    if (studentModel.items.length == 0) {
      return Scaffold();
    } else {

      //summary part
      var sum = 0;
      int summary = 0;
      var a = studentModel.items;
      int sum2 = 0;
      int sum3 = 0;
      int sum4 = 0;
      int sum5 = 0;
      int sum6 = 0;
      int sum7 = 0;
      int sum8 = 0;
      int sum9 = 0;
      int sum10 = 0;
      int sum11 = 0;
      int sum12 = 0;

      var total = studentModel.items.length;
      for(var one in studentModel.items){
        sum2 += one.w2 ?? 0;
        sum3 += one.w3 ?? 0;
        sum4 += one.w4 ?? 0;
        sum5 += one.w5 ?? 0;
        sum6 += one.w6 ?? 0;
        sum7 += one.w7 ?? 0;
        sum8 += one.w8 ?? 0;
        sum9 += one.w9 ?? 0;
        sum10 += one.w10 ?? 0;
        sum11 += one.w11 ?? 0;
        sum12 += one.w12 ?? 0;
      }

      switch(widget.weekNumber){
        case "w2":
          sum = sum2;
          break;
        case "w3":
          sum = sum3;
          break;
        case "w4":
          sum = sum4;
          break;
        case "w5":
          sum = sum5;
          break;
        case "w6":
          sum = sum6;
          break;
        case "w7":
          sum = sum7;
          break;
        case "w8":
          sum = sum8;
          break;
        case "w9":
          sum = sum9;
          break;
        case "w10":
          sum = sum10;
          break;
        case "w11":
          sum = sum11;
          break;
        case "w12":
          sum = sum12;
          break;
        default:
          print("");
      }

      summary = sum ~/ total;

      //filter part
      final _FilterFormKey = GlobalKey<FormState>();
      final filterController = TextEditingController();
      List<StudentClass> filterModel = studentModel.items;




      return Scaffold(
        appBar: AppBar(
          title: Text(changeWkToWeek(widget.weekNumber)),
          actions: [
            IconButton(icon: const Icon(Icons.help), onPressed: () => {
              showCupertinoDialog(context: context,
                  builder: (_) => CupertinoAlertDialog(
                    title: Text("HELP"),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("1. Have no time to design vivid help modal boxes as my iOS app. ╮(╯_╰)╭ ."),
                        Text("2. This page shows student list for a chosen week."),
                        Text("3. You can click students name to turn to weekly page."),
                        Text("4. You can click mark area of a student to give or change a mark."),
                        Text("5. On the right top, there are adding button, cancel-filter button,"
                            " and filter button."),
                        Text("6. You can filter students by part of their name or id.(according to Lindsay's suggestion)"),
                        Text("7. If you want to change marking scheme, please go back to home page.")
                      ],
                    ),
                    actions: [
                      CupertinoButton(child: Text("OK"), onPressed: () => {Navigator.pop(context)})
                    ],
                  )
              )
            }),
            
            IconButton(icon: const Icon(Icons.add),
                onPressed: () {
              showDialog(context: context, builder: (context){
                return StudentDetails();
              });
                }),

            IconButton(icon: const Icon(Icons.search_off), onPressed: (){

              Provider.of<StudentModel>(context, listen: false).fetch();
              Provider.of<StudentModel>(context, listen: false).refresh();
              print(filterModel.length);

            }),

            IconButton(icon: const Icon(Icons.search), onPressed: (){
              showCupertinoDialog(
                  context: context,
                  builder: (_) => CupertinoAlertDialog(
                    title: Text("Filter students by part of name or ID"),
                    content: Material(
                      child: Form(
                        key: _FilterFormKey,
                        child: TextFormField(
                          decoration:
                          InputDecoration(labelText: "Random input may lead to no results."),
                          controller: filterController,
                          autofocus: true,
                        ),
                      ),
                    ),
                    actions: [
                      CupertinoButton(
                          child: Text("Confirm"),
                          onPressed: (){
                            var a1a = filterController.text;
                            filterModel.retainWhere((element) => element.familyName.contains(a1a)||
                                element.firstName.contains(a1a)||element.id.contains(a1a) );
                           Provider.of<StudentModel>(context, listen: false).refresh();
                            Navigator.pop(context);

                            
                          }),
                      CupertinoButton(
                          onPressed: () => Navigator.pop(context), child: Text("Cancel")),
                    ],
                  ));









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

            })
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (studentModel.loading)
                CircularProgressIndicator()
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Mark Type: " + widget.passScheme),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          studentModel.items.length.toString() + " Student(s)"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Summary: " + summary.toString()),
                    ),
                  ],
                ),
              Expanded(
                child: ListView.builder(
                    itemBuilder: (_, index) {
                      // var student = studentModel.items[index];

                        var student = filterModel[index];

                      var showText = showScore(widget.weekNumber, student,
                          widget.passScheme, widget.schemeNumber);
                      sum = 0;
                      return ListTile(
                        title: Text(
                            student.firstName + " " + student.familyName),
                        subtitle: Text(student.id),
                        leading: student.image != null
                            // ? Image.network(student.image)
                            // : null,
                        ?Image.network(
                        student.image,
                        loadingBuilder: (context, child,progress){
                          return progress == null? child : LinearProgressIndicator();
                        },
                          width: 50,
                          height: 70,

                      ): null,

                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return StudentDetails(
                              indexId: student.iid,
                            );
                          }));
                        },
                        trailing: CupertinoButton(
                          child: Text(showText),
                          onPressed: () => showCupertinoDialog(
                            context: context,
                            builder: (_) => giveMarkAlert(
                                widget.weekNumber,
                                student,
                                widget.passScheme,
                                widget.schemeNumber,
                                showText),
                          ),
                        ),
                      );
                    },

                    itemCount: filterModel.length),
              )
            ],
          ),
        ),
      );
    }

    //show score function

  }

  CupertinoAlertDialog giveMarkAlert(String wk, StudentClass chosenStudent,
      String scheme, int number, String currentMark) {
    final _giveScoreFormKey = GlobalKey<FormState>();
    final scoreInputController = TextEditingController();

    if (scheme == "Checkbox") {
      // ////////////////////////////////////////////Checkbox buttons 1
      return CupertinoAlertDialog(
        title: Text(scheme + currentMark),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoButton(
                child: Text("Present"),
                onPressed: () => {
                      changeMark(chosenStudent, wk, 100, context),
                      Navigator.pop(context),
                    }),
            CupertinoButton(
                child: Text("Absent"),
                onPressed: () => {
                      changeMark(chosenStudent, wk, 0, context),
                      Navigator.pop(context)
                    }),
          ],
        ),
        actions: [
          CupertinoButton(
              onPressed: () => Navigator.pop(context), child: Text("Cancel")),
        ],
      );
    } // checkbox if end
    else if (scheme.contains("HD")) {
      //////////////////////////////////////////////////// Alert HD buttons2
      return CupertinoAlertDialog(
        title: Text(scheme + currentMark),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoButton(
                child: Text("HD+"),
                onPressed: () => {
                      changeMark(chosenStudent, wk, 100, context),
                      Navigator.pop(context),
                    }),
            CupertinoButton(
                child: Text("HD"),
                onPressed: () => {
                      changeMark(chosenStudent, wk, 80, context),
                      Navigator.pop(context),
                    }),
            CupertinoButton(
                child: Text("DN"),
                onPressed: () => {
                      changeMark(chosenStudent, wk, 70, context),
                      Navigator.pop(context),
                    }),
            CupertinoButton(
                child: Text("CR"),
                onPressed: () => {
                      changeMark(chosenStudent, wk, 60, context),
                      Navigator.pop(context),
                    }),
            CupertinoButton(
                child: Text("PP"),
                onPressed: () => {
                      changeMark(chosenStudent, wk, 50, context),
                      Navigator.pop(context),
                    }),
            CupertinoButton(
                child: Text("NN"),
                onPressed: () => {
                      changeMark(chosenStudent, wk, 0, context),
                      Navigator.pop(context),
                    }),
          ],
        ),
        actions: [
          CupertinoButton(
              onPressed: () => Navigator.pop(context), child: Text("Cancel")),
        ],
      );
    } else if (scheme.contains("A/B")) {
      /////////////////////////////////////////////////alert button A 3
      return CupertinoAlertDialog(
        title: Text(scheme + currentMark),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoButton(
                child: Text("A"),
                onPressed: () => {
                      changeMark(chosenStudent, wk, 100, context),
                      Navigator.pop(context),
                    }),
            CupertinoButton(
                child: Text("B"),
                onPressed: () => {
                      changeMark(chosenStudent, wk, 80, context),
                      Navigator.pop(context),
                    }),
            CupertinoButton(
                child: Text("C"),
                onPressed: () => {
                      changeMark(chosenStudent, wk, 70, context),
                      Navigator.pop(context),
                    }),
            CupertinoButton(
                child: Text("D"),
                onPressed: () => {
                      changeMark(chosenStudent, wk, 60, context),
                      Navigator.pop(context),
                    }),
            CupertinoButton(
                child: Text("F"),
                onPressed: () => {
                      changeMark(chosenStudent, wk, 0, context),
                      Navigator.pop(context),
                    }),
          ],
        ),
        actions: [
          CupertinoButton(
              onPressed: () => Navigator.pop(context), child: Text("Cancel")),
        ],
      );
    } else if (scheme.contains("ulti")) {
      ////////////////////////////////////////////////multi alert button 4
      var a1 = 100 ~/ number;
      var a2 = 200 ~/ number.toInt();
      var a3 = 300 ~/ number.toInt();
      var a4 = 400 ~/ number.toInt();


      return CupertinoAlertDialog(
        title: Text(scheme + currentMark),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoButton(
                child: Text("0 / " + number.toString()),
                onPressed: () => {
                      changeMark(chosenStudent, wk, 0, context),
                      Navigator.pop(context),
                    }),
            CupertinoButton(
                child: Text("1 / " + number.toString()),
                onPressed: () => {
                      changeMark(chosenStudent, wk, a1, context),
                      Navigator.pop(context),
                    }),
            CupertinoButton(
                child: Text("2 / " + number.toString()),
                onPressed: () => {
                      changeMark(chosenStudent, wk, a2, context),
                      Navigator.pop(context),
                    }),
            if (number > 2)
              CupertinoButton(
                  child: Text("3 / " + number.toString()),
                  onPressed: () => {
                        changeMark(chosenStudent, wk, a3, context),
                        Navigator.pop(context),
                      }),
            if (number > 3)
              CupertinoButton(
                  child: Text("4 / " + number.toString()),
                  onPressed: () => {
                        changeMark(chosenStudent, wk, a4, context),
                        Navigator.pop(context),
                      }),
            if (number > 4)
              CupertinoButton(
                  child: Text("5 / " + number.toString()),
                  onPressed: () => {
                        changeMark(chosenStudent, wk, 100, context),
                        Navigator.pop(context),
                      }),
          ],
        ),
        actions: [
          CupertinoButton(
              onPressed: () => Navigator.pop(context), child: Text("Cancel")),
        ],
      );
    } else if (scheme.contains(
        "core")) ///////////////////////////////////////     alert score things 5
    {
      int scoreA;
      String b;
      return CupertinoAlertDialog(
        title: Text(scheme + currentMark),
        content: Material(
          child: Form(
            key: _giveScoreFormKey,
            child: TextFormField(
              decoration:
                  InputDecoration(labelText: "Score out of " + number.toString()),
              controller: scoreInputController,
              autofocus: true,
            ),
          ),
        ),
        actions: [
          CupertinoButton(
              child: Text("Confirm"),
              onPressed: (){
                    if (verifyScoreInput(scoreInputController.text, number) == 0)
                      {
                      var scoreA = int.parse(scoreInputController.text) + 1;
                      var scoreB = scoreA * 100 ~/ number;
                        print(verifyScoreInput(scoreInputController.text, number));
                        changeMark(chosenStudent, wk, scoreB, context);
                       Navigator.pop(context);
                      }
                    else if (verifyScoreInput(scoreInputController.text, number) == 1)//not only number
                      {
                        print(verifyScoreInput(scoreInputController.text, number));
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
                    else if (verifyScoreInput(scoreInputController.text, number) == 2)//cannot be empty
                      {
                        print(verifyScoreInput(scoreInputController.text, number));
                        showCupertinoDialog(
                          context: context,
                          builder: (_) => CupertinoAlertDialog(
                            title: Text("ERROR!"),
                            content: Text(
                                "cannot be empty! If you want to give a 0, please type in 0 (Prevent operation errors)."),
                            actions: [
                              CupertinoButton(
                                  child: Text("OK"),
                                  onPressed: () => {
                                        Navigator.pop(context),
                                      }),
                            ],
                          ),
                        );
                      }else if(verifyScoreInput(scoreInputController.text, number) == 10){
                        print(verifyScoreInput(scoreInputController.text, number));
                        showCupertinoDialog(
                          context: context,
                          builder: (_) => CupertinoAlertDialog(
                            title: Text("ERROR!"),
                            content: Text(
                                "must be inside 0 ~ $number !"),
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
          CupertinoButton(
              onPressed: () => Navigator.pop(context), child: Text("Cancel")),
        ],
      );
    }
  }
}

int verifyScoreInput(String input, int number) {// 0 : all good; 1: not only number; 2: empty; 10: out of limit
  final checkString = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
  if (input == "") {
    return 2;
  }else if(checkString.hasMatch(input)){
    int check = int.parse(input);
    if(check >= 0 && check <= number){
      print("check is: "+ check.toString());
      return 0;
    }else{
      print("check is: "+ check.toString());
      return 10;
    }

  }else if(checkString.hasMatch(input) == false){
    return 1;
  }else{
    return 100;
  }
}

void changeMark(
    StudentClass student, String wk, int score, BuildContext context) {
  var theStudent = student;

//give mark to model
  switch (wk) {
    case "w2":
      theStudent.w2 = score;
      break;
    case "w3":
      theStudent.w3 = score;
      break;
    case "w4":
      theStudent.w4 = score;
      break;
    case "w5":
      theStudent.w5 = score;
      break;
    case "w6":
      theStudent.w6 = score;
      break;
    case "w7":
      theStudent.w7 = score;
      break;
    case "w8":
      theStudent.w8 = score;
      break;
    case "w9":
      theStudent.w9 = score;
      break;
    case "w10":
      theStudent.w10 = score;
      break;
    case "w11":
      theStudent.w11 = score;
      break;
    case "w12":
      theStudent.w12 = score;
      break;
    default:
      print("here a switch default 13131");
  }
  Provider.of<StudentModel>(context, listen: false)
      .update(student.iid, theStudent);
}



String changeWkToWeek(String wk) {
  switch (wk) {
    case 'w2':
      return "Week 2";
      break;
    case 'w3':
      return "Week 3";
      break;
    case 'w4':
      return "Week 4";
      break;
    case 'w5':
      return "Week 5";
      break;
    case 'w6':
      return "Week 6";
      break;
    case 'w7':
      return "Week 7";
      break;
    case 'w8':
      return "Week 8";
      break;
    case 'w9':
      return "Week 9";
      break;
    case 'w10':
      return "Week 10";
      break;
    case 'w11':
      return "Week 11";
      break;
    case 'w12':
      return "Week 12";
      break;
    default:
      return "WEEK X";
  }
}

String showScore(String wk, StudentClass student, String scheme, int number) {
  int score;
  var show = "not marked";

  switch (wk) {
    case 'w2':
      score = student.w2;
      break;
    case 'w3':
      score = student.w3;
      break;
    case 'w4':
      score = student.w4;
      break;
    case 'w5':
      score = student.w5;
      break;
    case 'w6':
      score = student.w6;
      break;
    case 'w7':
      score = student.w7;
      break;
    case 'w8':
      score = student.w8;
      break;
    case 'w9':
      score = student.w9;
      break;
    case 'w10':
      score = student.w10;
      break;
    case 'w11':
      score = student.w11;
      break;
    case 'w12':
      score = student.w12;
      break;
    default:
      score = -1;
  }


  if (score == null) {
    show = "not marked";
    return show;
  } else if (scheme.contains("HD")) {
    switch (score) {
      case 100:
        show = "HD+";
        break;
      case 80:
        show = "HD";
        break;
      case 70:
        show = "DN";
        break;
      case 60:
        show = "CR";
        break;
      case 50:
        show = "PP";
        break;
      case 0:
        show = "NN";
        break;
      default:
        show = score.toString();
    }
  } else if (scheme.contains("A/B")) {
    switch (score) {
      case 100:
        show = "A";
        break;
      case 80:
        show = "B";
        break;
      case 70:
        show = "C";
        break;
      case 60:
        show = "D";
        break;
      case 0:
        show = "F";
        break;
      default:
        show = score.toString();
    }
  } else if (scheme.contains("core")) {
    int midScore;
    midScore = score * number ~/ 100;
    show = midScore.toString() + " / " + number.toString();
  } else if (scheme == "Checkbox") {
    switch (score) {
      case 100:
        show = "Present";
        break;
      case 0:
        show = "Absent";
        break;
      default:
        show = score.toString();
    }
  } else if (scheme.contains("ulti")) {
    var chosen = score * number ~/ 100;
    show = chosen.toString() + " / " + number.toString();
    print(chosen);
  }


  return show;
}
