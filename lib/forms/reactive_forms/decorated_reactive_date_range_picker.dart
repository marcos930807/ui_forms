import 'package:flutter/material.dart';
import 'package:ui_forms/forms/input_decoration.dart';
import 'package:ui_forms/shared/datetime.dart';

import 'reactive_date_range_picker.dart';

class DecoratedReactiveDateRangePicker extends StatelessWidget {
  const DecoratedReactiveDateRangePicker(
      {Key? key,
      required this.formControlName,
      this.label,
      this.mandatory = false})
      : super(key: key);
  final String formControlName;
  final String? label;
  final bool mandatory;
  @override
  Widget build(BuildContext context) {
    const icon = Icons.calendar_month;
    final safeLabel = label ?? 'Seleccione Rango de Fecha';
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
    return ReactiveDateRangePicker(
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
                  if (picker.value != null) ...[
                    Text(
                      picker.value!.start.toFormattedDayMontYear,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text('-->'),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      picker.value!.end.toFormattedDayMontYear,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ] else
                    const Text('')
                ],
              ),
            ),
          ),
        );
      },
      firstDate: DateTime(2019),
      lastDate: DateTime(2029),
    );
  }
}
