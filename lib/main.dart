//provider the easiest and compatible for implementing light and dark theme in the app

import 'package:database_with_flutter/data/local/db_helper.dart';
import 'package:database_with_flutter/db_provider.dart';
import 'package:database_with_flutter/splash_screen.dart';
import 'package:database_with_flutter/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
void main() {
  runApp(MultiProvider(providers:
  [
    ChangeNotifierProvider(create: (context)=> DBProvider(dbHelper: DBHelper.getInstance)),
    ChangeNotifierProvider(create: (context)=> ThemeProvider())
  ],
  child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    DBHelper db = DBHelper.getInstance;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: context.watch<ThemeProvider>().getThemeValue()?
      ThemeMode.dark: ThemeMode.light,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splashscreen(), //its the constructor
    );
  }
}



/*
CocoaPods is essential for managing iOS dependencies in Flutter projects, allowing you to use plugins that require native functionality.
Ruby is the language behind CocoaPods, necessary for running its commands.

Importance in Flutter: Since CocoaPods is built in Ruby, having Ruby installed on your Mac is essential to use CocoaPods.
When you run commands like pod install or pod update in your Flutter project's iOS directory, you're executing Ruby scripts
*/