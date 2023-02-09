import 'package:susu/source/network/network.dart';

class MyRepository {
  final MyNetwork? myNetwork;

  MyRepository({required this.myNetwork});

  Future login(username,userpass) async {
    var json = await myNetwork!.login(username, userpass);
    return json;
  }

  Future invetoryIssue(body) async {
    var json = await myNetwork!.invetoryIssue(body);
    return json;
  }
  Future tukarSusu(barcode)async {
    var json = await myNetwork!.tukarSusu(barcode);
    return json;
  }
}
