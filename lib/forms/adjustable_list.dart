import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

typedef ItemBuilder<T> = Widget Function(T item);

class AdjustableList<T> extends StatelessWidget {
  final BuiltList<T> initialValues;
  final ValueChanged<BuiltList<T>> onListChanged;
  final ItemBuilder<T> itemBuilder;
  final String? label;
  final String? addPlaceholder;
  final IconData? addIcon;

  const AdjustableList({
    Key? key,
    required this.initialValues,
    required this.onListChanged,
    required this.itemBuilder,
    this.label,
    this.addPlaceholder,
    this.addIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    void onAdd() {
      if (controller.text.isNotEmpty) {
        T newValue;
        if (T == double) {
          newValue = double.tryParse(controller.text) as T;
        } else {
          newValue = controller.text as T;
        }

        if (newValue != null && !initialValues.contains(newValue)) {
          final updatedList =
              initialValues.rebuild((list) => list.add(newValue));
          onListChanged(updatedList);
        }

        controller.clear();
      }
    }

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (label != null)
                  Text(label!, style: Theme.of(context).textTheme.bodySmall),
                Wrap(
                  spacing: 8.0,
                  alignment: WrapAlignment.start,
                  children: [
                    ...initialValues.map((value) {
                      return Chip(
                        label: itemBuilder(value),
                        onDeleted: () {
                          final updatedList = initialValues
                              .rebuild((list) => list.remove(value));
                          onListChanged(updatedList);
                        },
                      );
                    }),
                    SizedBox(
                      height: 42,
                      width: 120,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                        child: TextField(
                          controller: controller,
                          onSubmitted: (_) => onAdd(),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.surfaceDim,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            labelText: addPlaceholder ?? 'Add',
                            suffixIcon: IconButton(
                              icon: Icon(
                                addIcon ?? Icons.add,
                                size: 16,
                              ),
                              onPressed: onAdd,
                            ),
                          ),
                          keyboardType: T == double
                              ? TextInputType.number
                              : TextInputType.text,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ReactiveAdjustableList<T>
    extends ReactiveFormField<BuiltList<T>, BuiltList<T>> {
  ReactiveAdjustableList({
    Key? key,
    required String formControlName,
    required ItemBuilder<T> itemBuilder,
    String? label,
    String? addPlaceholder,
    IconData? addIcon,
    Map<String, ValidationMessageFunction>? validationMessages,
  }) : super(
          key: key,
          formControlName: formControlName,
          validationMessages: validationMessages,
          builder: (ReactiveFormFieldState<BuiltList<T>, BuiltList<T>> field) {
            return AdjustableList<T>(
              initialValues: field.value ?? BuiltList<T>(),
              onListChanged: field.didChange,
              itemBuilder: itemBuilder,
              label: label,
              addPlaceholder: addPlaceholder,
              addIcon: addIcon,
            );
          },
        );

  @override
  ReactiveFormFieldState<BuiltList<T>, BuiltList<T>> createState() =>
      ReactiveFormFieldState<BuiltList<T>, BuiltList<T>>();
}
