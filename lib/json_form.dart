import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class JsonFormBuilder extends StatefulWidget {
  final String label;
  final String type;
  final value;

  JsonFormBuilder({this.label, this.type, this.value});

  @override
  _JsonFormBuilderState createState() => _JsonFormBuilderState();
}

class _JsonFormBuilderState extends State<JsonFormBuilder> {
  Widget formField;

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case 'textfield':
        formField = FormBuilderTextField(
          attribute: widget.label.toLowerCase().replaceAll(RegExp(' '), '_'),
          decoration: InputDecoration(labelText: widget.label),
          validators: [
            FormBuilderValidators.required(errorText: 'Cannot be empty'),
          ],
        );
        break;
      case 'email':
        formField = FormBuilderTextField(
          attribute: "email",
          decoration: InputDecoration(labelText: widget.label),
          validators: [
            FormBuilderValidators.email(
                errorText: 'Must be a valid email address'),
          ],
        );
        break;
      case 'password':
        formField = FormBuilderTextField(
          obscureText: true,
          attribute: widget.label.toLowerCase().replaceAll(RegExp(' '), '_'),
          decoration: InputDecoration(labelText: widget.label),
          validators: [
            FormBuilderValidators.required(errorText: 'Cannot be empty'),
          ],
        );
        break;
      case 'number':
        formField = FormBuilderTextField(
          keyboardType: TextInputType.numberWithOptions(),
          attribute: widget.label.toLowerCase().replaceAll(RegExp(' '), '_'),
          decoration: InputDecoration(labelText: widget.label),
          validators: [
            FormBuilderValidators.numeric(errorText: 'Must be numeric'),
          ],
        );
        break;
      case 'dropdown':
        var options = List.from(widget.value)
            .map((value) => DropdownMenuItem(
                  value: value,
                  child: Text("$value"),
                ))
            .toList();
        formField = FormBuilderDropdown(
          attribute: widget.label.toLowerCase().replaceAll(RegExp(' '), '_'),
          decoration: InputDecoration(labelText: "Gender"),
          // initialValue: 'Male',
          hint: Text(widget.label),
          validators: [FormBuilderValidators.required()],
          items: options,
        );
        break;
      case 'checkbox_multiple':
        var options = List.from(widget.value)
            .map((value) => FormBuilderFieldOption(value: value))
            .toList();
        formField = FormBuilderCheckboxList(
          attribute: widget.label.toLowerCase().replaceAll(RegExp(' '), '_'),
            decoration: InputDecoration(labelText: widget.label),
            options: options);
        break;
      case 'radio':
        var options = List.from(widget.value)
            .map((value) => FormBuilderFieldOption(value: value))
            .toList();
        formField = FormBuilderRadio(
          attribute: widget.label.toLowerCase().replaceAll(RegExp(' '), '_'),
          validators: [FormBuilderValidators.required()],
            decoration: InputDecoration(labelText: widget.label),
            options: options);
        break;
      case 'date':
        formField = FormBuilderDateTimePicker(
          attribute: "date",
          inputType: InputType.date,
          format: DateFormat("yyyy-MM-dd"),
          decoration: InputDecoration(labelText: widget.label),
      );
    }
    return formField;
  }
}
