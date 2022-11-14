import 'package:flutter/material.dart';
import 'package:ui_forms/shared/datetime.dart';

import 'reactive_date_range_picker.dart';

class DecoratedReactiveDateRangePicker extends StatelessWidget {
  const DecoratedReactiveDateRangePicker({
    Key? key,
    required this.formControlName,
    this.label,
    this.backgroundColor,
  }) : super(key: key);
  final String formControlName;
  final Color? backgroundColor;
  final String? label;
  @override
  Widget build(BuildContext context) {
    const icon = Icons.calendar_today;
    final decoration = InputDecoration(
      isDense: true,
      // filled: true,
      contentPadding: const EdgeInsets.only(right: 8.0, top: 6.0, bottom: 2.0),
      prefixIcon: Container(
        margin: const EdgeInsets.fromLTRB(2.0, 2.0, 6.0, 2.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withAlpha(130),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: const Icon(
          icon,
          size: 22,
          color: Colors.white,
        ),
      ),
      border: InputBorder.none,
      labelText: label ?? 'Date',
      errorStyle: TextStyle(
          height: 0.3,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold),
    );
    final InputDecoration effectiveDecoration = decoration.applyDefaults(
      Theme.of(context).inputDecorationTheme,
    );
    return ReactiveDateRangePicker(
      formControlName: formControlName,
      builder: (context, picker, child) {
        return Card(
          color: backgroundColor,
          elevation: 0,
          child: InkWell(
            onTap: () async {
              picker.showPicker();
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
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
                        const Text('=>'),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          picker.value!.end.toFormattedDayMontYear,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ]
                    ],
                  ),
                ),
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
