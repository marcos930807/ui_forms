import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:ui_forms/forms/input_decoration.dart';
import 'package:ui_forms/shared/datetime.dart';

class DecoratedReactiveDatePicker extends StatelessWidget {
  const DecoratedReactiveDatePicker({
    Key? key,
    required this.formControlName,
    this.label,
    this.mandatory = false,
  }) : super(key: key);

  final String formControlName;
  final bool mandatory;
  final String? label;
  @override
  Widget build(BuildContext context) {
    const icon = Icons.calendar_month;
    final safeLabel = label ?? 'Seleccione Fecha';
    final decoration = formCustomDecoration(context).copyWith(
      labelText: mandatory ? ('$safeLabel *') : safeLabel,
      suffixIcon: Icon(
        icon,
        color: Theme.of(context).iconTheme.color,
        // size: 22,
      ),
    );

    final InputDecoration effectiveDecoration = decoration.applyDefaults(
      Theme.of(context).inputDecorationTheme,
    );
    return ReactiveDatePicker(
      formControlName: formControlName,
      builder: (context, picker, child) {
        return InkWell(
          onTap: () async {
            picker.showPicker();
          },
          child: InputDecorator(
            isEmpty: picker.value == null,
            decoration: effectiveDecoration,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  Text(
                    picker.value?.toPipeFormattedDateUTC ?? '',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      firstDate: DateTime(2019),
      lastDate: DateTime(2025),
    );
  }
}
