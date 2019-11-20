import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class OrbitFormField {
  String label;
  String type;
  String slug;
  var value; // THIS CAN BE STRING OR LIST
  String defaultValue;
  var options;

  Widget widget;

  OrbitFormField(Map data) {
    this.label = data.containsKey('label') ? data['label'] : "";
    this.type = data.containsKey('type') ? data['type'] : "text";
    this.slug = data.containsKey('slug') ? data['slug'] : getAttribute();
    this.defaultValue =
        data.containsKey('defaultValue') ? data['defaultValue'] : '';
    if (data.containsKey('value')) {
      this.value = data['value'];
    }
    if (data.containsKey('options')) {
      this.options = data['options'];
    }

    this.widget = build();

    /*
    GlobalKey<FormBuilderState> _formKey = FormBuilder.of(context);
    print(_formKey);
    */

  }

  Map toJson() {
    Map data = {
      'label': this.label,
      'type': this.type,
      'slug': this.slug,
      'defaultValue': this.defaultValue
    };
    if (this.value != null) {
      data['value'] = this.value;
    }
    if (this.options != null) {
      data['options'] = this.options;
    }
    return data;
  }

  String toString() {
    return toJson().toString();
  }

  List listOptionsForWidget() {
    if (type == 'dropdown') {
      return List.from(options)
          .map((value) => DropdownMenuItem(value: value, child: Text("$value")))
          .toList();
    }
    return List.from(options)
        .map((value) => FormBuilderFieldOption(value: value))
        .toList();
  }

  String getAttribute() {
    return this.label.toLowerCase().replaceAll(RegExp(' '), '_');
  }

  Widget build() {
    Widget child;
    switch (this.type) {
      case 'text':
        child = buildText();
        break;
      case 'email':
        child = buildEmail();
        break;
      case 'password':
        child = buildPassword();
        break;
      case 'number':
        child = buildNumber();
        break;
      case 'dropdown':
        child = buildDropdown();
        break;
      case 'checkboxes':
        child = buildCheckboxes();
        break;
      case 'radio':
        child = buildRadio();
        break;
      case 'date':
        child = buildDateTimePicker();
        break;
    }

    return Column(
      children: <Widget>[
        child,
        SizedBox(
          height: 30.0,
        )
      ],
    );
  }

  Widget buildNumber() {
    var validators = [
      FormBuilderValidators.required(errorText: "Cannot be empty"),
      FormBuilderValidators.numeric(errorText: 'Must be a number')
    ];
    return buildTextField(
        keyboardType: TextInputType.numberWithOptions(),
        validators: validators);
  }

  Widget buildPassword() {
    var validators = [
      FormBuilderValidators.required(errorText: "Cannot be empty")
    ];
    return buildTextField(obscureText: true, validators: validators);
  }

  Widget buildText() {
    var validators = [
      FormBuilderValidators.required(errorText: "Cannot be empty")
    ];
    return buildTextField(validators: validators);
  }

  Widget buildEmail() {
    var validators = [
      FormBuilderValidators.email(errorText: 'Must be a valid email address')
    ];
    return buildTextField(validators: validators);
  }

  Widget buildDropdown() {
    return FormBuilderDropdown(
      attribute: this.slug,
      decoration: InputDecoration(labelText: this.label),
      initialValue: (this.value != null) ? this.value : this.defaultValue,
      hint: Text(this.label),
      validators: [FormBuilderValidators.required()],
      items: listOptionsForWidget(),
    );

  }

  Widget buildRadio() {
    return FormBuilderRadio(
      attribute: this.slug,
      initialValue: (this.value != null) ? this.value : this.defaultValue,
      validators: [FormBuilderValidators.required()],
      decoration: InputDecoration(
          labelText: this.label,
          border: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.red,
                  width: 2.0,
                  style: BorderStyle.solid))),
      options: listOptionsForWidget(),
    );
  }

  Widget buildCheckboxes() {
    var initialValue = (this.value != null) ? this.value : [];
    return FormBuilderCheckboxList(
      attribute: this.slug,
      initialValue: initialValue,
      decoration: InputDecoration(labelText: this.label),
      options: listOptionsForWidget(),
    );
  }

  Widget buildDateTimePicker() {
    return FormBuilderDateTimePicker(
      attribute: this.slug,
      inputType: InputType.date,
      format: DateFormat("yyyy-MM-dd"),
      decoration: InputDecoration(labelText: this.label),
    );
  }

  Widget buildTextField(
      {keyboardType = TextInputType.text,
      errorText = 'Cannot be empty',
      errorMailText,
      errorNumericText,
      validators,
      obscureText = false}) {
    if (validators == null) {
      validators = [FormBuilderValidators.required(errorText: errorText)];
    }

    if (errorNumericText != null) {
      validators
          .add(FormBuilderValidators.numeric(errorText: errorNumericText));
    }

    return FormBuilderTextField(
      keyboardType: keyboardType,
      //initialValue: this.value,
      obscureText: obscureText,
      attribute: this.slug,
      decoration: InputDecoration(labelText: this.label),
      validators: validators,
    );
  }
}
