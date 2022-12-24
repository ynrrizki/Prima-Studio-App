import 'package:hive/hive.dart';
part 'apperance.g.dart';

@HiveType(typeId: 0)
class Apperance {
  @HiveField(0)
  bool? themeSettings;

  Apperance({required this.themeSettings});
}
