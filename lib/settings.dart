import 'package:database_with_flutter/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget
{
 bool isDarkMode=false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
    body: Consumer<ThemeProvider>(builder: (_, provider, __)
    {
      return SwitchListTile.adaptive(
          title: Text("Dark Mode"),
          subtitle: Text('Change theme to dark mode'),
          onChanged: (value){
        provider.updateTheme(value: value);

          },
          value: provider.getThemeValue()
      );
    })
    );
  }
}