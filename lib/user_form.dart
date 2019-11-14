import 'package:flutter/material.dart';

class UserForm extends StatelessWidget {
  final String label;
  final String type;
  final List value;

  UserForm({this.label, this.type, this.value});

  @override
  Widget build(BuildContext context) {
    var formField;

    switch (this.type) {
      case 'textfield':
        formField = TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: this.label,
          ),
        );
        break;
      case 'email':
        formField = TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: this.label,
          ),
        );
        break;
      case 'mobile':
        formField = TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: this.label,
          ),
        );
        break;
      case 'dropdown':
        List data = this.value;
        formField = DropdownButton(
          hint: Text('Select Option'), // Not necessary for Option 1
          items: data.map((value) {
            return DropdownMenuItem(
              child: Text(value['label']),
              value: value['value'],
            );
          }).toList(),
        );
        break;
      case 'radio':
        formField = Radio(
            activeColor: Colors.green,
            value: this.value,
            groupValue: null,
            onChanged: null);
        break;
    }
    return formField;
  }

  void isChanged() {}
}
