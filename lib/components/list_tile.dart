import 'package:flutter/material.dart';
import 'package:todo/utilities/constants.dart';

class HomeTiles extends StatelessWidget {
  final String listName;
  final Icon? iconValue;

  const HomeTiles({Key? key, required this.listName, this.iconValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: iconValue ??
          Icon(
            Icons.list,
            color: ColorSelect.primaryLightColor,
          ),
      title: Text(listName),
      trailing: Icon(
        Icons.chevron_right,
        color: ColorSelect.grayColor,
      ),
    );
  }
}
