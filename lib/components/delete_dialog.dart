import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef IdCallback = void Function(String id);

class DeletedDialog extends StatelessWidget {
  final IdCallback deleteObject;
  final String id;
  final String desc;

  const DeletedDialog({super.key, required this.deleteObject, required this.id, required this.desc});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Theme.of(context).colorScheme.background,
      title: Text(
        AppLocalizations.of(context).youSure,
        style: const TextStyle(fontSize: 22),
      ),
      content: Text(desc),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            AppLocalizations.of(context).cancel,
            style: TextStyle(color: Theme.of(context).colorScheme.outlineVariant, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            deleteObject.call(id);
            Navigator.pop(context, true);
          },
          child: Container(
            height: 40,
            width: 89,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            child: Center(
              child: Text(
                AppLocalizations.of(context).delete,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
