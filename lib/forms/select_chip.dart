import 'package:flutter/material.dart';
import 'package:ui_forms/forms/input_decoration.dart';
import 'package:ui_forms/shared/dimen.dart';

typedef ItemBuilder<T> = Widget Function(T item);

class SelectChip<T> extends StatelessWidget {
  final List<T> availablesOptions;
  final T? selectedChoice;
  final ValueChanged<T?> onSelectionChanged;
  final ItemBuilder<T> itemBuilder;
  final String? errorText;
  final String? label;
  final bool allowUnselectedNullState;
  final WrapAlignment? alignment;
  const SelectChip({
    super.key,
    required this.availablesOptions,
    required this.onSelectionChanged,
    required this.itemBuilder,
    this.errorText,
    this.label,
    this.selectedChoice,
    this.alignment,
    this.allowUnselectedNullState = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: Theme(
        data: Theme.of(context).copyWith(useMaterial3: true),
        child: InputDecorator(
          decoration: formCustomDecoration(context).copyWith(labelText: label),
          child: Wrap(
            spacing: Dimens.xxs,
            alignment: alignment ?? WrapAlignment.start,
            children: _buildChoiceList(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildChoiceList(BuildContext context) {
    return availablesOptions
        .map(
          (item) => Container(
            constraints: BoxConstraints(
              maxWidth: (MediaQuery.of(context).size.width) * 0.5 - 40,
            ),
            child: ChoiceChip(
              label: FittedBox(child: itemBuilder(item)),
              side: BorderSide.none,
              selected: item == selectedChoice,
              onSelected: (selected) {
                if (selected) {
                  onSelectionChanged.call(item);
                } else {
                  if (allowUnselectedNullState) {
                    onSelectionChanged.call(null);
                  }
                }
              },
            ),
          ),
        )
        .toList();
  }
}
