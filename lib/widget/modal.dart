import 'package:flutter/material.dart';

void showModel(context,addTodo) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => Container(
      decoration: BoxDecoration(
        color:  Color(0xFFB1D4E0),
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.75,
      padding: EdgeInsets.all(10),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.text,
        maxLines: 2,
        validator: (value) {
          if (value.isEmpty) {
            return "Text should not be empty";
          } else if (value.length < 2) {
            return "Text length should not less then 2";
          } else if (value.length >= 100) {
            return "Text length should not greater then 100";
          }
          return null;
        },
        onFieldSubmitted: (value) => addTodo(value),
        decoration: InputDecoration(
          hintText: 'Enter your todo here...',
          contentPadding: EdgeInsets.all(8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
        // onFieldSubmitted: (value) => addTodo(value + " "),
      ),
    ),
  );
}
