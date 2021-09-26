import 'package:flutter/material.dart';

class CustomTextInputField extends StatelessWidget {
  final IconData prefixIcon;
  final String hintText;
  final TextEditingController editingController;

  const CustomTextInputField({
    this.prefixIcon,
    this.hintText,
    this.editingController,
  });
  usernameAndPasswordValidator(String fieldName, text) {
    return ((text.isEmpty)
        ? "$fieldName cannot be empty"
        : ((text.length < 3)
            ? "$fieldName cannot be less than 3 characters"
            : ((text.length > 11)
                ? "$fieldName length cannot be exceed to 11 characters"
                : null)));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          Icon(
            prefixIcon,
            color: Colors.grey,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 20, left: 10),
              child: TextFormField(
                controller: editingController,
                decoration: InputDecoration(hintText: hintText),
                validator: (text) =>
                    usernameAndPasswordValidator(hintText, text),
              ),
            ),
          )
        ],
      ),
    );
  }
}
