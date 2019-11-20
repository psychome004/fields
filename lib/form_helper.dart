import 'package:flutter/material.dart';
import 'form_field.dart';

class FormHelper {

  StepState getStepState({ @required stepIndex, @required currentIndex}){
    StepState state = StepState.indexed;
    if (stepIndex < currentIndex) {
      state = StepState.complete;
    }
    else if(stepIndex > currentIndex){
      state = StepState.disabled;
    }
    return state;
  }

  List<Step> listSteps({@required data, @required currentIndex}) {
    int step_i = -1;
    List steps = data.map((stepData) {
      step_i++;
      StepState state = getStepState(stepIndex: step_i, currentIndex: currentIndex);
      List<Widget> fields = [];
      if (stepData.containsKey('fields')) {
        fields = List<Widget>.from(stepData['fields'].map((field) {
          return OrbitFormField(field).widget;
        }));
      }
      return createStep(
          title: stepData['title'],
          fields: fields,
          isActive: currentIndex >= step_i,
          state: state);
    }).toList();

    return List<Step>.from(steps);
  }

  Step createStep(
      {@required title,
      List<Widget> fields,
      isActive = false,
      state = StepState.indexed}) {
    return Step(
      title: Text('$title'),
      isActive: isActive,
      state: state,
      content: Column(
        children: fields,
      ),
    );
  }
}
