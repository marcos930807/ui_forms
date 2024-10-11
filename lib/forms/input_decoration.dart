import 'package:flutter/material.dart';
import 'package:ui_forms/shared/input_borders.dart';

InputDecoration formCustomDecoration(BuildContext context) {
  final border = UnderlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  return InputDecoration(
    filled: true,
    fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
    labelText: 'Hint',
    enabledBorder: border,
    border: border,
    focusedBorder: LeftInputBorder(
      borderSide: BorderSide(
        width: 5,
        color: Theme.of(context).primaryColor,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    focusedErrorBorder: LeftInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 5,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    errorBorder: LeftInputBorder(
      borderSide: BorderSide(
        width: 5,
        color: Colors.red,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    errorStyle: const TextStyle(
      height: 0.3,
      color: Colors.red,
      fontWeight: FontWeight.bold,
    ),
  );
}
