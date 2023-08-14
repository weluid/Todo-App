import 'package:flutter/material.dart';

class GroupTile extends StatelessWidget {
  final String listName;
  final Icon? iconValue;
  final VoidCallback onPressed;

  const GroupTile({Key? key, required this.listName,
    this.iconValue, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: iconValue ??
          Icon(
            Icons.list,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
      title: Text(listName),
      trailing: IconButton(
        color:Theme.of(context).colorScheme.outline,
        icon: const Icon(Icons.chevron_right),
        onPressed: onPressed,
      ),
    );
  }
}
