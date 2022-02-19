import 'package:flutter/material.dart';

class TextFieldProvider {
  static TextField getBasic(
      TextInputType keyboardType, String? placeholder, dynamic onChanged,
      {bool readOnly = false}) {
    return TextField(
      keyboardType: keyboardType,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: placeholder,
      ),
      onChanged: onChanged(),
    );
  }

  static TextField getControllerBasic(TextInputType keyboardType,
      TextEditingController? textEditingController, String? placeholder,
      {bool readOnly = false}) {
    return TextField(
        keyboardType: keyboardType,
        controller: textEditingController,
        enabled: !readOnly,
        decoration: InputDecoration(
          labelText: placeholder,
        ));
  }
}
