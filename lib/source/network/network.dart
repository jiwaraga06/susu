import 'package:http/http.dart' as http;
import 'package:susu/source/network/api.dart';

class MyNetwork {
  Future login(username, userpass) async {
    try {
      var url = Uri.parse(MyApi.login(username, userpass));
      var response = await http.get(
        url,
        headers: {'Authorization': '${MyApi.token()}'},
      );
      return response;
    } catch (e) {
      print('ERROR NETWORK LOGIN: $e');
    }
  }

  Future invetoryIssue(body) async {
    try {
      var url = Uri.parse(MyApi.invetoryIssue());
      var response = await http.post(url,
          headers: {
            'Authorization': '${MyApi.token()}',
            'Accept': 'application/json',
          },
          body: body);
      return response;
    } catch (e) {
      print('ERROR NETWORK INVTY ISSUE: $e');
    }
  }

  Future tukarSusu(barcode) async {
    try {
      var url = Uri.parse(MyApi.tukarSusu(barcode));
      var response = await http.post(url, headers: {
        'Authorization': '${MyApi.token()}',
      });
      return response;
    } catch (e) {
      print('ERROR NETWORK TUKAR SUSU: $e');
    }
  }
}
