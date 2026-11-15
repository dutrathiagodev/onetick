import 'package:flutter/cupertino.dart'
    show
        CupertinoButton,
        CupertinoDatePicker,
        CupertinoDatePickerMode,
        showCupertinoModalPopup;
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Asks for a time of day. Android uses the Material dial; iOS uses the
/// native wheel in a bottom popup. Returns null when dismissed.
Future<TimeOfDay?> pickTimeOfDay(
  BuildContext context, {
  required TimeOfDay initial,
  required String title,
}) {
  if (defaultTargetPlatform != TargetPlatform.iOS) {
    return showTimePicker(
      context: context,
      initialTime: initial,
      helpText: title,
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
    );
  }
  return showCupertinoModalPopup<TimeOfDay>(
    context: context,
    builder: (popupContext) => _IosTimeSheet(initial: initial, title: title),
  );
}

class _IosTimeSheet extends StatefulWidget {
  const _IosTimeSheet({required this.initial, required this.title});

  final TimeOfDay initial;
  final String title;

  @override
  State<_IosTimeSheet> createState() => _IosTimeSheetState();
}

class _IosTimeSheetState extends State<_IosTimeSheet> {
  late TimeOfDay _value = widget.initial;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      color: colors.surface,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 300,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      key: const Key('time_cancel'),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancelar'),
                    ),
                    Text(
                      widget.title,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: colors.text,
                      ),
                    ),
                    CupertinoButton(
                      key: const Key('time_confirm'),
                      onPressed: () => Navigator.of(context).pop(_value),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: true,
                  initialDateTime: DateTime(
                    2000,
                    1,
                    1,
                    widget.initial.hour,
                    widget.initial.minute,
                  ),
                  onDateTimeChanged: (d) =>
                      _value = TimeOfDay(hour: d.hour, minute: d.minute),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
