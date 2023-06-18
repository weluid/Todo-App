import 'package:flutter/material.dart';
import 'package:todo/utilities/constants.dart';

class GroupTile extends StatelessWidget {
  final String listName;
  final Icon? iconValue;
  final VoidCallback onPressed;


  const GroupTile({Key? key, required this.listName, this.iconValue, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: iconValue ??
          Icon(
            Icons.list,
            color: ColorSelect.primaryLightColor,
          ),
      title: Text(listName),
      trailing: IconButton(
        color: ColorSelect.grayColor,
        icon: const Icon(Icons.chevron_right),
        onPressed: onPressed,
      ),
    );
  }
}
