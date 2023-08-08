import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo/repository/database/cache_manager.dart';
import 'package:todo/repository/todo_repository.dart';
import 'package:todo/screens/home_screen.dart';
import 'package:todo/screens/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/theme/dark_theme.dart';
import 'package:todo/theme/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ToDoRepository.getInstance(CacheManager()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightTheme,
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
      ),
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SplashScreen(),
                  ),
                );
              },
              child: const Text('Splash Screen'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: const Text('Home Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
