import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/components/bottom_button.dart';
import 'package:todo/components/list_tile.dart';
import 'package:todo/main.dart';
import 'package:todo/repository/database/cache_manager.dart';
import 'package:todo/repository/todo_repository.dart';
import 'package:todo/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ToDoRepository toDoRepository = ToDoRepository(CacheManager());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToDoBloc>(
      create: (BuildContext context) {
        ToDoBloc bloc = ToDoBloc(toDoRepository);
        bloc.add(ToDoStartEvent());

        return bloc;
      },
      child: BlocBuilder<ToDoBloc, ToDoState>(
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
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                HomeTiles(
                  listName: AppLocalizations.of(context).myDay,
                  iconValue: Icon(
                    Icons.sunny,
                    color: ColorSelect.primaryColor,
                  ),
                ),
                HomeTiles(
                  listName: AppLocalizations.of(context).important,
                  iconValue: Icon(
                    Icons.star,
                    color: ColorSelect.importantColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Divider(
                    color: ColorSelect.grayColor,
                    indent: 20, //spacing at the start of divider
                    endIndent: 30, //spacing at the end of divider
                  ),
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.groups.length,
                  itemBuilder: (BuildContext context, int index) {
                    return HomeTiles(listName: state.groups[index].title);
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 40,
          child: Center(
            child: MyBottomButton(
              text: AppLocalizations.of(context).addList,
              icon: Icons.add,
              onTap: () async {
                final groupName = await _showDialog();

                if (groupName != null) {
                  if (!mounted) return;

                  BlocProvider.of<ToDoBloc>(context).add(
                    AddGroupEvent(title: groupName),
                  );
                }
                debugPrint('Group name: $groupName'); //test city
              },
            ),
          ),
        ));
  }

  Future<String?> _showDialog() async {
    String? title;
    title = await showDialog(
        context: context,
        builder: (context) {
          String inputText = AppLocalizations.of(context).initialValue;
          return AlertDialog(
            title: Text(AppLocalizations.of(context).newList),
            content: TextFormField(
              initialValue: AppLocalizations.of(context).initialValue,
              onChanged: (value) {
                inputText = value;
              },
              decoration: InputDecoration(hintText: AppLocalizations.of(context).enterGroupTitle),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Text(
                      AppLocalizations.of(context).cancel,
                      style: TextStyle(color: ColorSelect.primaryColor),
                    ),
                    onTap: () {
                      Navigator.pop(context, null);
                    },
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      title = inputText;
                      Navigator.pop(context, inputText);

                    },
                    child: Container(
                      width: 108,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        color: ColorSelect.primaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            AppLocalizations.of(context).create,
                            style: const TextStyle(color: Colors.white),
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
    return title;
  }
}
