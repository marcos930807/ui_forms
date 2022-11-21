import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:ui_forms/forms/dropdown_base_picker.dart';
import '../../shared/dimen.dart';
import '../input_decoration.dart';

class DecoratedReactiveBasePicker<T> extends StatelessWidget {
  const DecoratedReactiveBasePicker({
    Key? key,
    required this.formControlName,
    required this.loadFunction,
    required this.itemBuilder,
    this.icon,
    this.label,
    this.backgroundColor,
    this.validationMessages,
    this.onTap,
    this.onChange,
    this.mandatory = false,
  }) : super(key: key);

  final String formControlName;
  final SyncLoadFunction<T> loadFunction;
  final BasePickerItemBuilder<T> itemBuilder;
  final IconData? icon;
  final String? label;
  final Color? backgroundColor;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final ReactiveFormFieldCallback<T>? onTap;
  final ReactiveFormFieldCallback<T>? onChange;
  final bool mandatory;
  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).textScaleFactor;
    return ReactiveDropdownField<T>(
      elevation: 1,

      isDense: false,
      enableFeedback: true,
      onChanged: onChange,
      validationMessages: validationMessages,
      decoration: formCustomDecoration(context).copyWith(
        isDense: true,
        isCollapsed: true, //The magic
        contentPadding: const EdgeInsets.symmetric(horizontal: Dimens.xs),
        prefixIcon: icon != null
            ? Icon(
                icon,
                size: 22,
                // color: Colors.white,
              )
            : null,
        labelText: mandatory ? ('$label *') : label,
        labelStyle: const TextStyle(height: 1.5),
      ),
      icon: Padding(
        padding: const EdgeInsets.only(
          left: 4,
        ),
        child: Icon(
          Icons.arrow_drop_down,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
      // showErrors: (control) => true,
      formControlName: formControlName,
      onTap: onTap,
      items: loadFunction()
          .map((e) => DropdownMenuItem<T>(
                value: e,
                child: Container(
                    height: 45 * scale,
                    padding: const EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    child: itemBuilder(e)),
              ))
          .toList(),
    );
  }
}
