abstract class Repository<T> {
  //This is the field variable for the Hive database
  static dynamic themeBox;

  //This method is used to check if the database exists
  static Future<void> checkDatabaseExists() async {}

  //This method is used to create the database
  static Future<void> createDatabase() async {}

  static putThemeSettings(bool? themeFlag) {}

  static bool? getThemeSettings() {
    return null;
  }
}
