import 'dart:convert';
import 'package:demo_project/src/models/store_model.dart';
import 'package:http/http.dart' as http;
import 'package:demo_project/src/global/global.dart';

class StoreDetailApi {
  Future<StoreModel> storeDetailApi(String id) async {
    var responseJson;
    await http.post(Uri.parse('${baseUrl}get_res_details'), body: {
      'res_id': id,
    }).then((response) {
      responseJson = _returnResponse(response);
    }).catchError((onError) {
      print(onError);
    });
    return StoreModel.fromJson(responseJson);
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);

        return responseJson;
      case 400:
        throw Exception(response.body.toString());
      case 401:
        throw Exception(response.body.toString());
      case 403:
        throw Exception(response.body.toString());
      case 500:
      default:
        throw Exception(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
