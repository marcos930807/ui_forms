import 'package:flutter/material.dart';

import 'package:reactive_forms/reactive_forms.dart';
import 'package:ui_forms/shared/dimen.dart';
import 'input_decoration.dart';

typedef SyncLoadFunction<T> = List<T> Function();
typedef BasePickerItemBuilder<T> = Widget Function(T item);

class DropDownBasePicker<T> extends StatelessWidget {
  const DropDownBasePicker(
      {Key? key,
      required this.loadFunction,
      required this.itemBuilder,
      this.icon,
      this.label,
      this.backgroundColor,
      this.currentValue,
      required this.onChanged})
      : super(key: key);

  final SyncLoadFunction<T> loadFunction;
  final BasePickerItemBuilder<T> itemBuilder;
  final IconData? icon;
  final String? label;
  final Color? backgroundColor;
  final T? currentValue;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).textScaleFactor;
    return InputDecorator(
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
        labelText: label,
        labelStyle: const TextStyle(height: 1.5),
      ),
      isEmpty: currentValue == null,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: currentValue,
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
          elevation: 1,
          icon: Padding(
            padding: const EdgeInsets.only(
              left: 4,
            ),
            child: Icon(
              Icons.arrow_drop_down,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          onChanged: (value) {
            onChanged.call(value);
          },
        ),
      ),
    );
  }
}
