import 'package:fields/json_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() => runApp(Homepage());

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  List<Map> _formData = [
    {'label': 'Your Name', 'type': 'textfield', 'value': ''},
    {'label': 'Email', 'type': 'email', 'value': ''},
    {'label': 'Password', 'type': 'password', 'value': ''},
    {'label': 'Contact Number', 'type': 'number', 'value': ''},
    {'label': 'Gender', 'type': 'radio', 'value': ['Male', 'Female', 'Other']},
    {'label': 'Select Country', 'type': 'dropdown', 'value': ['India', 'Sweden', 'U.S.A']},
    {'label': 'Course', 'type': 'checkbox_multiple', 'value': ['JAVA', 'PHP', 'PYTHON']},
    {'label': 'Date', 'type': 'date', 'value': ''},
//    {'label': 'Accept the terms and conditions', 'type': 'checkbox_single', 'value': ''},
  ];

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
                return JsonFormBuilder(
                    label: data['label'],
                    type: data['type'],
                    value: data['value']);
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
