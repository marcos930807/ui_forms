import 'package:flutter/material.dart';
import 'package:ui_forms/shared/input_borders.dart';

InputDecoration formCustomDecoration(BuildContext context) => InputDecoration(
      filled: true,
      isDense: true,
      fillColor: Theme.of(context).cardColor,
      labelText: 'Hint',
      border: InputBorder.none,
      focusedBorder: LeftInputBorder(
        borderSide: BorderSide(width: 5, color: Theme.of(context).primaryColor),
      ),
      focusedErrorBorder: const LeftInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 5),
      ),
      errorBorder: const LeftInputBorder(
        borderSide: BorderSide(
          width: 5,
          color: Colors.red,
        ),
      ),
      errorStyle: const TextStyle(
        height: 0.3,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
