import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class DueDate extends StatelessWidget {
  final VoidCallback datePicker;
  final VoidCallback dateToday;
  final VoidCallback dateTomorrow;

  const DueDate({required this.datePicker, super.key, required this.dateToday, required this.dateTomorrow});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             Center(
              child: Text(
                AppLocalizations.of(context).due,
                style: const TextStyle(fontSize: 22),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: Divider(height: 1, color: Theme.of(context).colorScheme.outlineVariant,),
            ),
            GestureDetector(
              onTap: () {
                dateToday.call();
              },
              child:  Row(
                children: [
                  const Icon(Icons.calendar_today, size: 20),
                  const SizedBox(width: 18),
                  Text(AppLocalizations.of(context).today, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 22),
            GestureDetector(
              onTap: () {
                dateTomorrow.call();
              },
              child:  Row(
                children: [
                  const Icon(Icons.calendar_today, size: 20),
                  const SizedBox(width: 18),
                  Text(AppLocalizations.of(context).tomorrow, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 22),
            GestureDetector(
              onTap: () {
                datePicker();
              },
              child:  Row(
                children: [
                  const Icon(Icons.calendar_today, size: 20),
                  const SizedBox(width: 18),
                  Text(AppLocalizations.of(context).pickDate, style: const TextStyle(fontSize: 14)),
                  const Spacer(),
                  const Icon(Icons.chevron_right, size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
