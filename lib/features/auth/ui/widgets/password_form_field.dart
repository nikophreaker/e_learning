import 'package:e_learning/core/utils/validate_operations.dart';
import 'package:e_learning/features/auth/ui/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class PasswordFormField extends StatelessWidget {
  const PasswordFormField({
    Key? key,
    required this.passwordController,
    required this.passwordTitle,
    required this.labelText,
  }) : super(key: key);

  final TextEditingController passwordController;
  final String passwordTitle;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      isPassword: true,
      title: passwordTitle,
      labelText: labelText,
      controller: passwordController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        passwordController.text = value!;
      },
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}
