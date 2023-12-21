import 'package:hive_flutter/hive_flutter.dart';
//type adaptor lek usermodel page generate cheyunu / g-is generate
part 'usermodel.g.dart';
//then terminal-flutter packages pub run build_runner build
// rdy ayilenkil sdk-terminal update then- edit environments- flutter\bin


//import hive maati hive flutter aaknam
@HiveType(typeId:1)
class User{
  @HiveField(0)
  final String username;

  @HiveField(1)
  final String password;

  @HiveField(2)
  String? id;
  User({required this.username,required this.password}){
    id=DateTime.now().microsecondsSinceEpoch.toString();
  }
}