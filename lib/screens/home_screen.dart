import 'package:flutter/material.dart';
import 'package:todo/components/add_list_dialog.dart';
import 'package:todo/components/bottom_button.dart';
import 'package:todo/components/list_tile.dart';
import 'package:todo/utilities/constants.dart';
import 'package:todo/repository/task_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView.builder(
              itemCount: TaskList.taskList.length,
              itemBuilder: (BuildContext context, int index) {
                return drawLists(context, index, TaskList.taskList);
              },
            ),
            MyBottomButton(
              text: 'Add list',
              icon: Icons.add,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const ListDialog();
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget drawLists(BuildContext context, int index, List listName) {
  if (index == 0) {
    return HomeTiles(
      listName: 'My Day',
      iconValue: Icon(
        Icons.sunny,
        color: ColorSelect.primaryColor,
      ),
    );
  } else if (index == 1) {
    return Column(
      children: [
        HomeTiles(
          listName: 'Important',
          iconValue: Icon(
            Icons.star,
            color: ColorSelect.importantColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Divider(
            color: ColorSelect.grayColor,
            indent: 20, //spacing at the start of divider
            endIndent: 30, //spacing at the end of divider
          ),
        ),
      ],
    );
  } else {
    return HomeTiles(
      listName: listName[index],
    );
  }
}
