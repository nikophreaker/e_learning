import 'package:e_learning/core/utils/validate_operations.dart';
import 'package:e_learning/features/auth/ui/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class EmailFormField extends StatelessWidget {
  const EmailFormField({
    Key? key,
    required this.emailController,
    required this.emailTitle,
    required this.labelText,
  }) : super(key: key);

  final TextEditingController emailController;
  final String emailTitle;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      title: emailTitle,
      labelText: labelText,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
      },
      validator: (value) => ValidateOperations.emailValidation(value),
    );
  }
}
