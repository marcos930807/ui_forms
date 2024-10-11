import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:ui_forms/shared/dimen.dart';

typedef MultiSelectItemBuilder<T> = Widget Function(T item);

class MultiSelectChip<T> extends StatelessWidget {
  final List<T> availablesOptions;
  final BuiltList<T> selectedChoice;
  final ValueChanged<BuiltList<T>> onSelectionChanged;
  final MultiSelectItemBuilder<T> itemBuilder;
  final String? errorText;
  final String? label;
  final IconData? icon;
  final Color? backgroundColor;
  const MultiSelectChip({
    super.key,
    required this.availablesOptions,
    required this.onSelectionChanged,
    required this.itemBuilder,
    this.errorText,
    this.icon,
    this.label,
    required this.selectedChoice,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: InputDecorator(
        decoration: InputDecoration(labelText: label, errorText: errorText),
        child: Wrap(
          spacing: Dimens.xxs,
          alignment: WrapAlignment.start,
          children: _buildChoiceList(context),
        ),
      ),
    );
  }

  List<Widget> _buildChoiceList(BuildContext context) {
    return availablesOptions.map((item) {
      final bool isSelected = selectedChoice.any((p0) => p0 == item);
      return Container(
        padding: const EdgeInsets.only(right: 4.0),
        child: ChoiceChip(
          label: itemBuilder(item),
          side: BorderSide.none,
          labelStyle: TextStyle(color: Theme.of(context).iconTheme.color),
          selected: isSelected,
          onSelected: (selected) {
            if (isSelected) {
              onSelectionChanged
                  .call(selectedChoice.rebuild((list) => list.remove(item)));
            } else {
              onSelectionChanged
                  .call(selectedChoice.rebuild((list) => list.add(item)));
            }
          },
        ),
      );
    }).toList();
  }
}
