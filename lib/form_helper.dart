import 'package:flutter/material.dart';
import 'form_field.dart';

class FormHelper {
  List<Step> listSteps({@required data, @required currentIndex}) {
    int step_i = -1;
    List steps = data.map((stepData) {
      step_i++;
      StepState state = StepState.indexed;
      if (step_i < currentIndex) {
        state = StepState.complete;
      }
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
