import 'package:e_learning/features/auth/utils/typedefs.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    this.controller,
    this.labelText,
    this.validator,
    this.title,
    this.isPassword = false,
    this.onSaved,
    this.keyboardType = TextInputType.text,
  });

  final String? labelText;
  final String? title;
  final TextEditingController? controller;
  final Function(String?)? onSaved;
  final ValidatorFunction validator;
  final bool? isPassword;
  final TextInputType? keyboardType;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title ?? "",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        TextFormField(
          cursorHeight: 20,
          textAlignVertical: TextAlignVertical.center,
          controller: widget.controller,
          obscureText: widget.isPassword ?? false,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          onSaved: widget.onSaved,
          cursorColor: Colors.white,
          style: Theme.of(context).textTheme.titleSmall,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            floatingLabelStyle: Theme.of(context).textTheme.titleSmall,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            hoverColor: Colors.white,
            focusColor: Colors.white,
            labelText: widget.labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.white)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.red)),
          ),
        )
      ],
    );
  }
}