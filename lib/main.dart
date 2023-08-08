import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo/repository/database/cache_manager.dart';
import 'package:todo/repository/todo_repository.dart';
import 'package:todo/screens/home_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/theme/theme.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Brightness isPlatformDark = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final initTheme = (isPlatformDark == Brightness.dark) ? darkTheme : lightTheme;

    return RepositoryProvider(
      create: (context) => ToDoRepository.getInstance(CacheManager()),
      child: ThemeProvider(
        initTheme: initTheme,
        builder: (_, lightTheme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
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
    );
  }
}
