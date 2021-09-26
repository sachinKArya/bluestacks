import 'package:bluestack_flutter_app/custom_widgets/recommended_widget.dart';
import 'package:bluestack_flutter_app/model/recommended_model.dart';
import 'package:bluestack_flutter_app/provider/dashboard_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<DashboardProvider>(context, listen: false)
        .pagingController
        .addPageRequestListener(
      (pageKey) {
        Provider.of<DashboardProvider>(context, listen: false)
            .fetchRecommendedContent();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(16),
            children: [
              headerWidget(),
              profileHeaderWidget(),
              secondaryProfileWidget(),
              Text(
                'Recommended for you',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Consumer<DashboardProvider>(
                builder: (context, model, child) =>
                    (PagedListView<int, RecommendedModel>(
                  pagingController: model.pagingController,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  builderDelegate: PagedChildBuilderDelegate<RecommendedModel>(
                    itemBuilder: (context, item, index) {
                      return RecommendedWidget(
                        recommendedModel: item,
                      );
                    },
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container secondaryProfileWidget() {
    return Container(
      padding: EdgeInsets.only(
        bottom: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
      child: Row(
        children: [
          secondProfileContainer(
            number: '34',
            itemText: 'Tournaments played',
            radius: BorderRadius.only(
              topLeft: Radius.circular(40),
              bottomLeft: Radius.circular(40),
            ),
            color: Colors.orange,
          ),
          secondProfileContainer(
            number: '09',
            itemText: 'Tournaments won',
            color: Colors.deepPurple,
          ),
          secondProfileContainer(
            number: '26%',
            itemText: 'Winning percentage',
            color: Colors.red,
            radius: BorderRadius.only(
              topRight: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ],
      ),
    );
  }

  secondProfileContainer({
    radius,
    color,
    number,
    itemText,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 90,
        decoration: BoxDecoration(
          borderRadius: radius,
          gradient: LinearGradient(
            colors: [
              color[500],
              color[300],
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              itemText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  profileHeaderWidget() {
    return Container(
      padding: EdgeInsets.only(
        bottom: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: CachedNetworkImage(
              imageUrl:
                  'https://www.mrdustbin.com/en/wp-content/uploads/2021/05/tom-hardy.jpg',
              imageBuilder: (context, imageProvider) => Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    strokeWidth: 0.5,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(width: 12),
          Container(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Tom Hardy',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 40,
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 30,
                  ),
                  // width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue[300],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(22),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '2271',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue[300],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Elo Rating',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue[300],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  headerWidget() {
    return Container(
      padding: EdgeInsets.only(
        bottom: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Image.asset(
                  "assets/images/menu.png",
                  alignment: Alignment.centerLeft,
                  color: Colors.grey,
                  height: 16,
                  width: 16,
                ),
              )),
          Expanded(
            flex: 3,
            child: Text(
              "Flyingwold",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
