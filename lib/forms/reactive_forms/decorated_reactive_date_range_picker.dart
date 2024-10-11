import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:ui_forms/shared/datetime.dart';

import 'reactive_date_range_picker.dart';

class DecoratedReactiveDateRangePicker extends StatelessWidget {
  const DecoratedReactiveDateRangePicker(
      {Key? key,
      required this.formControlName,
      this.label,
      this.mandatory = false,
      this.validationMessages})
      : super(key: key);
  final String formControlName;
  final String? label;
  final bool mandatory;

  final Map<String, String Function(Object)>? validationMessages;
  @override
  Widget build(BuildContext context) {
    ValidationMessageFunction? findValidationMessage(String errorKey) {
      if (validationMessages != null &&
          validationMessages!.containsKey(errorKey)) {
        return validationMessages![errorKey];
      } else {
        final formConfig = ReactiveFormConfig.of(context);
        return formConfig?.validationMessages[errorKey];
      }
    }

    const icon = Icons.calendar_month;
    final safeLabel = label ?? 'Select Date Range';
    final decoration = InputDecoration(
      labelText: mandatory ? ('$safeLabel *') : safeLabel,
      suffixIcon: Icon(
        icon,
        color: Theme.of(context).iconTheme.color,
        // size: 22,
      ),
    );

    return ReactiveDateRangePicker(
      formControlName: formControlName,
      builder: (context, picker, child) {
        final control = picker.control;
        String? errorText;
        var showErrors = control.invalid && control.touched;
        if (control.hasErrors && showErrors) {
          final errorKey = control.errors.keys.first;
          final validationMessage = findValidationMessage(errorKey);

          errorText = validationMessage != null
              ? validationMessage(control.getError(errorKey)!)
              : errorKey;
        }
        return InkWell(
          onTap: () async {
            picker.showPicker();
          },
          child: InputDecorator(
            isEmpty: picker.value == null,
            decoration: decoration.copyWith(errorText: errorText),
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
                    const Text('<-->'),
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
