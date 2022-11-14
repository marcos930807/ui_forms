import 'package:flutter/material.dart';
import 'package:ui_forms/shared/dimen.dart';
import 'package:ui_forms/shared/text_style.dart';

import 'reactive_raw_autocomplete.dart';

class ReactiveAutocomplete<T> extends StatelessWidget {
  const ReactiveAutocomplete({
    Key? key,
    required this.options,
    required this.formControlName,
    this.decoration,
  }) : super(key: key);
  final List<T> options;
  final String formControlName;
  final InputDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    return ReactiveRawAutocomplete<T, String>(
        viewDataTypeFromTextEditingValue: (textValue) => textValue,
        optionsBuilder: (textEditingValue) {
          return options.where((T option) {
            return option
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          }).map((e) => e.toString());
        },
        optionsViewBuilder: (context, onSelected, options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(Dimens.xs),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: double.infinity,
                    ),
                    Text(
                      'Sugerencias:',
                      style: TStyle.title1,
                    ),
                    Wrap(
                      // runSpacing: Dimens.xs,
                      spacing: Dimens.xs,
                      children: [
                        ...options.map(
                          (e) => RawChip(
                            label: Text(e),
                            onPressed: () {
                              onSelected(e);
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        formControlName: formControlName,
        decoration: decoration ?? const InputDecoration()
        //label: localized.description,
        );
  }
}
