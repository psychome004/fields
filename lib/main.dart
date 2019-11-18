import 'package:fields/stepper_form.dart';
import 'package:fields/test_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'form_field.dart';

void main() => runApp(FormStepper());

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  List<Map> _formData = [
    {'label': 'Your Name', 'type': 'text', 'value': 'Flutter'},
    {'label': 'Email', 'type': 'email', 'value': 'anything@gmail.com'},
    {'label': 'Password', 'type': 'password', 'value': 'qwerty'},
    {'label': 'Contact Number', 'type': 'number', 'value': '8976789067'},
    {
      'label': 'Gender',
      'type': 'radio',
      'options': ['Male', 'Female', 'Other'],
      'defaultValue' : 'Male'
    },
    {
      'label': 'Select Country',
      'type': 'dropdown',
      'options': ['India', 'Sweden', 'U.S.A'],
      'defaultValue': 'India'
    },
    {
      'label': 'Course',
      'type': 'checkbox_multiple',
      'options': ['JAVA', 'PHP', 'PYTHON'],
    },
    {'label': 'Date', 'type': 'date', 'value': ''},
//    {'label': 'Accept the terms and conditions', 'type': 'checkbox_single', 'value': ''},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(_formData.length);

    OrbitFormField formField = OrbitFormField(_formData[0]);
    //print(formField);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
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
                  children: _formData.map((data) {

                return OrbitFormField(data).widget;
              }).toList()),
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
//            body: FormFields()),
    );
  }
}
