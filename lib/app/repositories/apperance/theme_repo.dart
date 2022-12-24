import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prima_studio/app/models/apperance.dart';

class ThemeRepository {
  ThemeRepository._();

  static dynamic themeBox;

  static Future<void> checkDatabaseExists() async {
    Directory themeDatabaseDir = await getApplicationSupportDirectory();

    //Initialise the database
    Hive.init(themeDatabaseDir.path);

    //If the database exists, open it. Else, call the createDatabase method
    if (await Hive.boxExists("themeBox")) {
      themeBox = await Hive.openBox("themeBox");
    } else {
      createDatabase();
    }
  }

  static Future<void> createDatabase() async {
    Directory themeDatabaseDir = await getApplicationSupportDirectory();

    //Initialise the database
    Hive.init(themeDatabaseDir.path);

    //Register the Hive database Type Adapter
    Hive.registerAdapter(ThemeAdapter());

    //Open the database
    themeBox = await Hive.openBox("themeBox");
    await themeBox.put("themeSettings", true);
  }

  static putThemeSettings(bool? themeFlag) {
    themeBox.put("themeSettings", themeFlag);
  }

  static bool getThemeSettings() {
    bool themeValue = themeBox?.get("themeSettings") ?? true;
    return themeValue;
  }
}
