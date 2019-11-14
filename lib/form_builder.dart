import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class FormFields extends StatefulWidget {
  @override
  _FormFieldsState createState() => _FormFieldsState();
}

class _FormFieldsState extends State<FormFields> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: <Widget>[
            FormBuilder(
              key: _fbKey,
              initialValue: {
                'date': DateTime.now(),
                'accept_terms': false,
              },
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  FormBuilderDateTimePicker(
                    attribute: "date",
                    inputType: InputType.date,
                    format: DateFormat("yyyy-MM-dd"),
                    decoration:
                    InputDecoration(labelText: "Appointment Date"),
                  ),
                  FormBuilderSlider(
                    attribute: "slider",
                    validators: [FormBuilderValidators.min(6)],
                    min: 0.0,
                    max: 10.0,
                    initialValue: 1.0,
                    divisions: 20,
                    decoration:
                    InputDecoration(labelText: "Number of things"),
                  ),
                  FormBuilderCheckbox(
                    attribute: 'accept_terms',
                    label: Text(
                        "I have read and agree to the terms and conditions"),
                    validators: [
                      FormBuilderValidators.requiredTrue(
                        errorText:
                        "You must accept terms and conditions to continue",
                      ),
                    ],
                  ),
                  FormBuilderDropdown(
                    attribute: "gender",
                    decoration: InputDecoration(labelText: "Gender"),
                    // initialValue: 'Male',
                    hint: Text('Select Gender'),
                    validators: [FormBuilderValidators.required()],
                    items: ['Male', 'Female', 'Other']
                        .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text("$gender")
                    )).toList(),
                  ),
                  FormBuilderTextField(
                    attribute: "age",
                    decoration: InputDecoration(labelText: "Age"),
                    validators: [
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.max(70),
                    ],
                  ),
                  FormBuilderSegmentedControl(
                    decoration:
                    InputDecoration(labelText: "Movie Rating (Archer)"),
                    attribute: "movie_rating",
                    options: List.generate(5, (i) => i + 1)
                        .map(
                            (number) => FormBuilderFieldOption(value: number))
                        .toList(),
                  ),
                  FormBuilderSwitch(
                    label: Text('I Accept the tems and conditions'),
                    attribute: "accept_terms_switch",
                    initialValue: true,
                  ),
                  FormBuilderStepper(
                    decoration: InputDecoration(labelText: "Stepper"),
                    attribute: "stepper",
                    initialValue: 10,
                    step: 1,
                  ),
                  FormBuilderRate(
                    decoration: InputDecoration(labelText: "Rate this form"),
                    attribute: "rate",
                    iconSize: 32.0,
                    initialValue: 1,
                    max: 5,
                  ),
                  FormBuilderCheckboxList(
                    decoration:
                    InputDecoration(labelText: "The language of my people"),
                    attribute: "languages",
                    initialValue: ["Dart"],
                    options: [
                      FormBuilderFieldOption(value: "Dart"),
                      FormBuilderFieldOption(value: "Kotlin"),
                      FormBuilderFieldOption(value: "Java"),
                      FormBuilderFieldOption(value: "Swift"),
                      FormBuilderFieldOption(value: "Objective-C"),
                    ],
                  ),
                  FormBuilderSignaturePad(
                    decoration: InputDecoration(labelText: "Signature"),
                    attribute: "signature",
                    height: 100,
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                MaterialButton(
                  child: Text("Submit"),
                  onPressed: () {
                    if (_fbKey.currentState.saveAndValidate()) {
                      print(_fbKey.currentState.value);
                    }
                  },
                ),
                MaterialButton(
                  child: Text("Reset"),
                  onPressed: () {
                    _fbKey.currentState.reset();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
