import 'package:flutter/material.dart';
import 'form_builder.dart';
import 'user_form.dart';

void main() => runApp(Homepage());

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Map> _formData = [
//    {'label': 'Your Name', 'type': 'textfield'},
//    {'label': 'Your Gender', 'type': 'radio', 'value': 'Male'},
    {'label': 'Your Gender', 'type': 'dropdown', 'value': ['php','jQuery','java']},
//    {'label': 'Your Email', 'type': 'email','value': ''},
//    {'label': 'Contact Number', 'type': 'mobile','value': ''},
//    {'label': 'Your Country', 'type': 'textfield','value': ''},
  ];

  @override
  Widget build(BuildContext context) {
    var formField;
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Home'),
          ),
//          body: Container(
//            padding: EdgeInsets.all(10.0),
//            child: ListView(
//                children: _formData.map((data){
////                  print(data['value']);
//                  return UserForm(label: data['label'], type: data['type'], value: data['value']);
//                }).toList()),
//          )),
            body: FormFields()),
    );
  }

//    List<UserForm> formData = [
//      UserForm(label: 'Your Name', type: 'textfield'),
//      UserForm(label: 'Your Gender', type: 'radio'),
//      UserForm(label: 'Your Email', type: 'emailfield'),
//      UserForm(label: 'Your Country', type: 'textfield'),
//    ];

}
