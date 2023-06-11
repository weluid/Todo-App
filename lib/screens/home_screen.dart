import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/components/bottom_button.dart';
import 'package:todo/components/list_tile.dart';
import 'package:todo/main.dart';
import 'package:todo/repository/list_management%20.dart';
import 'package:todo/utilities/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoRepository listManagement = TodoRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (BuildContext context) {
        TodoBloc bloc = TodoBloc(listManagement);
        bloc.add(ToDoStartEvent());

        return bloc;
      },
      child: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is StartApp) {
            return _buildParentWidget(context, state);
          } else {
            return const StartPage();
          }
        },
      ),
    );
  }

  _buildParentWidget(BuildContext context, StartApp state) {
    print(state.groups.length);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView.builder(
              itemCount: state.groups.length,
              itemBuilder: (BuildContext context, int index) {
                return drawLists(context, index, state.groups[index].title);
              },
            ),
            MyBottomButton(
              text: 'Add list',
              icon: Icons.add,
              onTap: () async {
                // _showDialog();
                final groupName = await _showDialog();
                // await Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const SearchPage(),
                //   ),
                // );

                if (groupName != null) {
                  if (!mounted) return;

                  BlocProvider.of<TodoBloc>(context).add(
                    AddGroupEvent(title: groupName),
                  );
                }
                debugPrint('nAME gROUP after: $groupName'); //test city
              },
            ),
            TextButton(
              onPressed: () {
                // taskManager.addTask(= 'Нова таска 1');
                // print(taskManager.groupList[0].tasks[0].title);
              },
              child: Text("Add Task"),
            )
          ],
        ),
      ),
    );
  }

   Future<String?>_showDialog() async {
    Completer<String?> completer = Completer<String>();

    showDialog(
        context: context,
        builder: (context) {
          String inputText = 'Untitled List';
          return AlertDialog(
            title: const Text('New List'),
            content: TextFormField(
              initialValue: 'Untitled List',
              onChanged: (value) {
                inputText = value;
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
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context, inputText);
                      completer.complete(inputText);
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
    return await completer.future;
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
