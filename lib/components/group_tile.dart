import 'package:flutter/material.dart';
import 'package:todo/utilities/constants.dart';

class GroupTile extends StatelessWidget {
  final String listName;
  final Icon? iconValue;
  final VoidCallback onPressed;

  const GroupTile({Key? key, required this.listName,
    this.iconValue, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ListTile(
        leading: iconValue ??
            Icon(
              Icons.list,
              color: ColorSelect.primaryLightColor,
            ),
        title: Text(listName),
        trailing: Icon(
          color: ColorSelect.grayColor,
          Icons.chevron_right,
        ),
      ),
    );
  }
}
