import 'package:bluestack_flutter_app/common/constants.dart';
import 'package:bluestack_flutter_app/model/recommended_model.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class DashboardProvider extends ChangeNotifier {
  int pageKey = 10;
  PagingController<int, RecommendedModel> pagingController =
      PagingController(firstPageKey: 0);
  String errorMessage;
  List<RecommendedModel> recommendedGamesList;
  Future fetchRecommendedContent() async {
    try {
      recommendedGamesList =
          await Constants.dashboardRepository.fetchRecommendedGames(pageKey);

      if (recommendedGamesList == null && pageKey > 10) {
        pagingController.appendLastPage([]);
      } else {
        pageKey = pageKey + recommendedGamesList.length;
        pagingController.appendPage(recommendedGamesList, pageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }
}
