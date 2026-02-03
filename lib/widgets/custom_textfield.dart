import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final Function(String) onChanged;
  final TextInputType keyboardType;
  final String initialValue;

  const CustomTextField({
    super.key,
    required this.label,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    this.initialValue = '',
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
