import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/repository/database/cache_manager.dart';
import 'package:todo/repository/database/sql_database.dart';
import 'package:todo/repository/todo_repository.dart';
import 'package:todo/screens/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/theme/theme.dart';

 main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Brightness isPlatformDark = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final initTheme = (isPlatformDark == Brightness.dark) ? darkTheme : lightTheme;

    return RepositoryProvider(
      create: (context) => ToDoRepository.getInstance(SqlDatabase()),
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
              Locale('uk'), // Ukrainian
            ],
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
