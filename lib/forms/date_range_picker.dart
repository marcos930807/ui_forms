import 'package:flutter/material.dart';
import 'package:ui_forms/shared/datetime.dart';

import 'input_decoration.dart';

class DateRangePicker extends StatelessWidget {
  const DateRangePicker({
    Key? key,
    this.currentRange,
    required this.onRangeUpdate,
    this.label,
  }) : super(key: key);
  final DateTimeRange? currentRange;
  final ValueChanged<DateTimeRange> onRangeUpdate;
  final String? label;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: Theme(
        data: Theme.of(context).copyWith(useMaterial3: true),
        child: InkWell(
          onTap: () async {
            final range = await selectDateRange(
              context,
              initialDateRange: currentRange,
            );
            if (range != null) {
              onRangeUpdate.call(range);
            }
          },
          child: InputDecorator(
            decoration: formCustomDecoration(context)
                .copyWith(labelText: label ?? 'Select Date Range'),
            child: Text(
              currentRange != null
                  ? '${currentRange?.start.toPipeFormattedDateUTC} - ${currentRange?.end.toPipeFormattedDateUTC}'
                  : 'Presione para seleccionar',
            ),
          ),
        ),
      ),
    );
  }
}
