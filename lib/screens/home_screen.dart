import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/group_bloc/group_bloc.dart';
import 'package:todo/bloc/theme_bloc/theme_bloc.dart';
import 'package:todo/components/bottom_button.dart';
import 'package:todo/components/group_tile.dart';
import 'package:todo/repository/todo_repository.dart';
import 'package:todo/screens/splash_screen.dart';
import 'package:todo/screens/task_screen.dart';
import 'package:todo/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GroupBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupBloc>(
      create: (BuildContext context) {
        bloc = GroupBloc(context.read<ToDoRepository>());
        bloc.add(InitializationEvent());

        return bloc;
      },
      child: BlocBuilder<GroupBloc, GroupState>(
        builder: (context, state) {
          if (state is InitializationApp) {
            return _buildParentWidget(context, state, bloc);
          } else {
            return const SplashScreen();
          }
        },
      ),
    );
  }

  _buildParentWidget(BuildContext context, InitializationApp state, GroupBloc bloc) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GroupTile(
                  listName: AppLocalizations.of(context).myDay,
                  iconValue: Icon(
                    Icons.sunny,
                    color: ColorSelect.primaryColor,
                  ),
                  onPressed: () {},
                ),
                GroupTile(
                  listName: AppLocalizations.of(context).important,
                  iconValue: Icon(
                    Icons.star,
                    color: ColorSelect.importantColor,
                  ),
                  onPressed: () {},
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
                    return GroupTile(
                      listName: state.groups[index].groupName,
                      onPressed: () => _goToTaskPage(
                        state.groups[index].groupName,
                        context,
                        state.groups[index].id,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 40,
          child: Row(
            children: [
              Center(
                child: MyBottomButton(
                  text: AppLocalizations.of(context).addGroup,
                  icon: Icons.add,
                  onTap: () async {
                    final String? groupName = await _showDialog();

                    if (groupName!.trim().isNotEmpty) {
                      if (!mounted) return;
                      BlocProvider.of<GroupBloc>(context).add(
                        AddGroupEvent(title: groupName),
                      );
                    }
                    debugPrint('Group name: $groupName'); //test city
                  },
                ),
              ),
              const Spacer(),
              Switch(
                focusColor: Colors.white,
                value: context.read<ThemeBloc>().state == ThemeMode.dark,
                onChanged: (value) {
                  context.read<ThemeBloc>().add(ThemeChanged(value));
                },
              )
            ],
          ),
        ));
  }

  _goToTaskPage(String groupName, BuildContext context, String id) async {
    final changeFlag = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TaskScreen(
                  groupName: groupName,
                  id: id,
                )));

    if (changeFlag == true) {
      if (!mounted) return;
      BlocProvider.of<GroupBloc>(context).add(
        InitializationEvent(),
      );
    }
  }

  Future<String?> _showDialog() async {
    Completer<String?> completer = Completer<String>();
    final formKey = GlobalKey<FormState>();

    showDialog(
        context: context,
        builder: (context) {
          String inputText = AppLocalizations.of(context).initialValue;
          return AlertDialog(
            surfaceTintColor:  Theme.of(context).colorScheme.background,

            title: Text(AppLocalizations.of(context).newList),
            content: Form(
              key: formKey,
              child: TextFormField(
                initialValue: AppLocalizations.of(context).initialValue,
                onChanged: (value) {
                  inputText = value;
                },
                decoration: InputDecoration(hintText: AppLocalizations.of(context).enterGroupTitle),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return AppLocalizations.of(context).enterGroupTitle;
                  } else {
                    return null;
                  }
                },
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Text(
                      AppLocalizations.of(context).cancel,
                      style: TextStyle(color: Theme.of(context).colorScheme.outlineVariant),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      completer.complete(inputText);
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 108,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        color: Theme.of(context).colorScheme.outlineVariant,
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
    return await completer.future;
  }
}
