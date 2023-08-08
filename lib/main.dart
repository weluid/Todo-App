import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo/bloc/theme_bloc/theme_bloc.dart';
import 'package:todo/repository/database/cache_manager.dart';
import 'package:todo/repository/todo_repository.dart';
import 'package:todo/screens/home_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/theme/theme.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
      child: RepositoryProvider(
        create: (context) => ToDoRepository.getInstance(CacheManager()),
        child: BlocBuilder<ThemeBloc, ThemeMode>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: lightTheme,
              themeMode: state,
              darkTheme: darkTheme,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: const Locale('en'),
              supportedLocales: const [
                Locale('en'), // English
                Locale('uk'), // Spanish
              ],
              home: const HomeScreen(),
            );
          },
        ),
      ),
    );
  }
}

