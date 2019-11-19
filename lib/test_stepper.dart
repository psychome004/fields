import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormStepper extends StatefulWidget {
  @override
  _FormStepperState createState() => _FormStepperState();
}

class _FormStepperState extends State<FormStepper> {
  int currStep = 0;
  static var _focusNode = new FocusNode();
  GlobalKey<FormState> _jsonFormKey = new GlobalKey<FormState>();

  List<Step> steps = [
    Step(
        title: const Text('Page'),
        //subtitle: const Text('Subtitle'),
        isActive: true,
        //state: StepState.editing,
        state: StepState.indexed,
        content: Text('HI')
    ),
  ];

//  List<Step> _getSteps(fields){
//    int count;
//    var _steps = fields.map((field){
//        return Step(
//            title: Text('Page  $count++'),
//            //subtitle: const Text('Subtitle'),
//            isActive: true,
//            //state: StepState.editing,
//            state: StepState.indexed,
//            content: field
//        );
//      });
//      return _steps;
//    }

  @override
  Widget build(BuildContext context) {


    void _submitDetails() {
      final FormState formState = _jsonFormKey.currentState;

      if (!formState.validate()) {
        print('Please enter correct data');
      } else {
        print(formState);
      }
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Stepper Form'),),
        body: Container(
            child: new FormBuilder(
              key: _jsonFormKey,
              child: ListView(children: <Widget>[
                new Stepper(
                  steps: steps,
                  type: StepperType.vertical,
                  currentStep: this.currStep,
                  onStepContinue: () {
                    setState(() {
                      if (currStep < steps.length - 1) {
                        currStep = currStep + 1;
                      } else {
                        //Trigger submit when all steps are completed
                        currStep = 0;
                      }
                    });
                  },
                  onStepCancel: () {
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
                new RaisedButton(
                  child: new Text(
                    'Save details',
                    style: new TextStyle(color: Colors.white),
                  ),
                  onPressed: _submitDetails,
                  color: Colors.blue,
                ),
              ]),
            )),
      ),
    );
  }
}
