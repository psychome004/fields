import 'package:flutter/material.dart';
import 'package:fields/form_helper.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppScreenMode();
  }
}

class MyData {
  String name = '';
  String phone = '';
  String email = '';
  String age = '';
}

class MyAppScreenMode extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: new ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Stepper Form'),
          ),
          body: new StepperBody(),
        ));
  }
}

class StepperBody extends StatefulWidget {
  @override
  _StepperBodyState createState() => new _StepperBodyState();
}

class _StepperBodyState extends State<StepperBody> {
  int currStep = 0;
  static var _focusNode = new FocusNode();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static MyData data = new MyData();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
      print('Has focus: $_focusNode.hasFocus');
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  List<Step> listSteps() {
    List<Map> stepsData = [
      {
        'title': 'Primary Information',
        'fields': [
          {'label': 'Your Name', 'type': 'text', 'value': 'Flutter'},
          {'label': 'Email', 'type': 'email', 'value': 'anything@gmail.com'},
          {'label': 'Contact Number', 'type': 'number', 'value': '8976789067'},
        ]
      },
      {
        'title': 'Secondary Information',
        'fields': [
          {
            'label': 'Gender',
            'type': 'radio',
            'options': ['Male', 'Female', 'Other'],
            'defaultValue': 'Male'
          },
          {
            'label': 'Select Country',
            'type': 'dropdown',
            'options': ['India', 'Sweden', 'U.S.A'],
            'defaultValue': 'India'
          },
          {
            'label': 'Course',
            'type': 'checkboxes',
            'options': ['JAVA', 'PHP', 'PYTHON'],
            'defaultValue': 'JAVA'
          },
        ],
      },
      {'title': 'Email'},
      {'title': 'Age'},
    ];
    return FormHelper().listSteps(data: stepsData, currentIndex: currStep);
  }

  @override
  Widget build(BuildContext context) {
    void showSnackBarMessage(String message,
        [MaterialColor color = Colors.red]) {
      Scaffold.of(context)
          .showSnackBar(new SnackBar(content: new Text(message)));
    }

    void _submitDetails() {
      final FormState formState = _formKey.currentState;

      if (!formState.validate()) {
        showSnackBarMessage('Please enter correct data');
      } else {
        formState.save();
        print("Name: ${data.name}");
        print("Phone: ${data.phone}");
        print("Email: ${data.email}");
        print("Age: ${data.age}");

        showDialog(
            context: context,
            child: new AlertDialog(
              title: new Text("Details"),
              //content: new Text("Hello World"),
              content: new SingleChildScrollView(
                child: new ListBody(
                  children: <Widget>[
                    new Text("Name : " + data.name),
                    new Text("Phone : " + data.phone),
                    new Text("Email : " + data.email),
                    new Text("Age : " + data.age),
                  ],
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
      }
    }

    return new Container(
        child: new Form(
      key: _formKey,
      child: ListView(children: <Widget>[
        Stepper(
          steps: listSteps(),
          physics: ClampingScrollPhysics(),
//          controlsBuilder: (BuildContext context,
//              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
//            return Row(
//              children: <Widget>[
//                FlatButton(
//                  onPressed: onStepContinue,
//                  child: Text('NEXT'),
//                ),
//                FlatButton(
//                  onPressed: onStepCancel,
//                  child: Text('PREVIOUS'),
//                ),
//              ],
//            );
//          },
          type: StepperType.vertical,
          currentStep: this.currStep,
          onStepContinue: () {
            setState(() {
              if (currStep < listSteps().length - 1) {
                currStep = currStep + 1;
              } else {
                FocusScope.of(context).unfocus();
                //Trigger submit event when all the steps are completed
//                    currStep = 0;
                print('Completed!!!!');
              }
            });
          },
          onStepCancel: () {
            setState(() {
              FocusScope.of(context).unfocus();
              if (currStep > 0) {
                currStep = currStep - 1;
              } else {
                currStep = 0;
              }
            });
          },
          onStepTapped: (step) {
            setState(() {
              currStep = step;
            });
          },
        ),
        RaisedButton(
          child: new Text(
            'Submit',
            style: new TextStyle(color: Colors.white),
          ),
          onPressed: _submitDetails,
          color: Colors.deepPurple,
        ),
      ]),
    ));
  }
}
