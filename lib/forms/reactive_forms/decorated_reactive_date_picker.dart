import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:ui_forms/shared/datetime.dart';

class DecoratedReactiveDatePicker extends StatelessWidget {
  const DecoratedReactiveDatePicker({
    super.key,
    required this.formControlName,
    this.label,
    this.mandatory = false,
    this.validationMessages,
  });

  final String formControlName;
  final bool mandatory;
  final String? label;

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
    final safeLabel = label ?? 'Select Date';
    final decoration = InputDecoration(
      labelText: mandatory ? ('$safeLabel *') : safeLabel,
      suffixIcon: Icon(
        icon,
        color: Theme.of(context).iconTheme.color,
        // size: 22,
      ),
    );

    return ReactiveDatePicker(
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
