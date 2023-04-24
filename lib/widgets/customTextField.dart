import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  String labeltext;
  String hintText;
  TextEditingController controler;
  IconData icondata;
  bool hidde;
  TextInputType type;
  final String? Function(String?)? validator;
  CustomTextField(
      {required this.controler,
      required this.labeltext,
      required this.hintText,
      required this.validator,
      required this.icondata,
      required this.hidde,
      required this.type,
      super.key});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: widget.controler,
        obscureText: widget.hidde,
        keyboardType: widget.type,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icondata),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          labelText: widget.labeltext,
          hintText: widget.hintText,
        ),
        validator: widget.validator,
      ),
    );
  }
}
