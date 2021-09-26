import 'dart:convert';
import 'package:bluestack_flutter_app/common/constants.dart';
import 'package:bluestack_flutter_app/model/recommended_model.dart';
import 'package:http/http.dart' as http;

class DashboardRepository {
  Future fetchRecommendedGames(int pageKey) async {
    try {
      var url = Uri.parse(
          Constants.dashboardContentUrl + "?limit=$pageKey&status=all");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data);
        if (decodedData['data']['tournaments'] != null)
          return decodedData['data']['tournaments']
              .map<RecommendedModel>((i) => RecommendedModel.fromJson(i))
              .toList();
        else
          return null;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
