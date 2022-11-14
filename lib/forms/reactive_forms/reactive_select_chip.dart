import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../multiselect_chips.dart';
import '../select_chip.dart';
import 'decorated_reactive_base_picker.dart' as bp;

class ReactiveSelect<T> extends ReactiveFormField<T, T> {
  ReactiveSelect({
    super.key,
    required String super.formControlName,
    super.validationMessages,
    required bp.SyncLoadFunction<T> availablesOptions,
    required ItemBuilder<T> itemBuilder,
    String? label,
    WrapAlignment? wrapAlignment,
    bool allowUnselectedNullState = true,
  }) : super(
          builder: (ReactiveFormFieldState<T, T> field) {
            return SelectChip<T>(
              errorText: field.errorText,
              label: label,
              availablesOptions: availablesOptions.call(),
              onSelectionChanged: (value) => field.didChange(value),
              itemBuilder: itemBuilder,
              selectedChoice: field.value,
              alignment: wrapAlignment,
              allowUnselectedNullState: allowUnselectedNullState,
            );
          },
        );
  @override
  ReactiveFormFieldState<T, T> createState() => ReactiveFormFieldState<T, T>();
}

class ReactiveMultiSelect<T>
    extends ReactiveFormField<BuiltList<T>, BuiltList<T>> {
  ReactiveMultiSelect({
    super.key,
    required String formControlName,
    final Map<String, ValidationMessageFunction>? validationMessages,
    required final bp.SyncLoadFunction<T> availablesOptions,
    required final ItemBuilder<T> itemBuilder,
    final IconData? icon,
    final String? label,
    final Color? backgroundColor,
  }) : super(
            formControlName: formControlName,
            // showErrors: (control) {
            //   return control.invalid;
            // },
            validationMessages: validationMessages,
            builder:
                (ReactiveFormFieldState<BuiltList<T>, BuiltList<T>> field) {
              return MultiSelectChip<T>(
                errorText: field.errorText,
                label: label,
                icon: icon,
                availablesOptions: availablesOptions.call(),
                onSelectionChanged: (value) => field.didChange(value),
                itemBuilder: itemBuilder,
                selectedChoice: field.value ?? BuiltList(),
                backgroundColor: backgroundColor,
              );
            });
  @override
  ReactiveFormFieldState<BuiltList<T>, BuiltList<T>> createState() =>
      ReactiveFormFieldState<BuiltList<T>, BuiltList<T>>();
}
