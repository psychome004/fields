import 'package:flutter/material.dart';
import 'package:fields/form_helper.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppScreenMode();
  }
}

class MyAppScreenMode extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Stepper Form'),
          ),
          body: StepperBody(),
        ));
  }
}

class StepperBody extends StatefulWidget {
  @override
  _StepperBodyState createState() => _StepperBodyState();
}

class _StepperBodyState extends State<StepperBody> {
  int currStep = 0;
  GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  List<Step> listSteps() {
    List<Map> stepsData = [
      {
        'title': 'Primary Information',
        'fields': [
          {'label': 'Your Name', 'type': 'text'},
          {'label': 'Email', 'type': 'email'},
          {'label': 'Contact Number', 'type': 'number'},
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
        ],
      },
      {
        'title': 'Technical Information',
        'fields': [
          {
            'label': 'Course',
            'type': 'checkboxes',
            'options': ['JAVA', 'PHP', 'PYTHON'],
            'defaultValue': 'JAVA'
          },
        ],
      },
    ];
    return FormHelper().listSteps(data: stepsData, currentIndex: currStep);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FormBuilder(
        key: _formKey,
        initialValue: {
          'date': DateTime.now(),
          'email': 'samvthom16@gmail.com',
          'your_name': 'Samuel'
        },
        autovalidate: true,
        child: ListView(children: <Widget>[
          Stepper(
            steps: listSteps(),
            physics: ClampingScrollPhysics(),
            type: StepperType.vertical,
            currentStep: this.currStep,
            onStepContinue: () {
              FocusScope.of(context).unfocus();
              setState(() {
                if (currStep < listSteps().length - 1) {
                  currStep = currStep + 1;
                } else {
                  formSubmit();
                  //Trigger submit event when all the steps are completed
                  print('Completed!!!!');
                }
              });
            },
            onStepCancel: () {
              FocusScope.of(context).unfocus();
              setState(() {
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
        ]),
      ),
    );
  }

  formSubmit() {
    print('Form submitted');
    if (_formKey.currentState.saveAndValidate()) {
      print(_formKey.currentState.value);
    }
  }
}
