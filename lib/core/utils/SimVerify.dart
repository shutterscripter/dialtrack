import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class SimVerifyModel {
  SimVerifyModel({required this.simVerifyFlag});

  @HiveField(0)
  bool simVerifyFlag = false;
}
