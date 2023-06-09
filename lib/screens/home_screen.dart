import 'package:flutter/material.dart';
import 'package:todo/components/add_list_dialog.dart';
import 'package:todo/components/bottom_button.dart';
import 'package:todo/components/list_tile.dart';
import 'package:todo/repository/list_management%20.dart';
import 'package:todo/utilities/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ListManagement taskManager = ListManagement();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView.builder(
              itemCount: taskManager.groupList.length,
              itemBuilder: (BuildContext context, int index) {
                return drawLists(context, index, taskManager.groupList[index].title);
              },
            ),
            MyBottomButton(
              text: 'Add list',
              icon: Icons.add,
              onTap: () {
                _showDialog();
              },
            ),
            TextButton(
              onPressed: () {
                taskManager.addTask(0, 'Нова таска 1');
                print(taskManager.groupList[0].tasks[0].title);
              },
              child: Text("Add Task"),
            )
          ],
        ),
      ),
    );
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          String valueText = 'Untitled List';
          return AlertDialog(
            title: const Text('New List'),
            content: TextFormField(
              initialValue: 'Untitled List',
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              decoration: const InputDecoration(hintText: "Enter list title"),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: ColorSelect.primaryColor),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      int index = ListManagement.groupIndex++;
                      debugPrint(index.toString());

                      setState(() {
                        taskManager.addGroup(valueText, index);
                      });
                      debugPrint(taskManager.groupList.toString());
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 108,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        color: ColorSelect.primaryColor,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Create ',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}

Widget drawLists(BuildContext context, int index, String listTitle) {
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
      listName: listTitle,
    );
  }
}
