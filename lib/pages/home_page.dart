import 'package:flutter/material.dart';
import 'package:flutter_champions/model/data.dart';
import 'package:flutter_champions/widgets/card_scroll_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = championList.length - 1.0;
  var currentPageFavorites = favoritList.length - 1.0;
  PageController pageController;
  PageController pageControllerFavorites;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: championList.length - 1);
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page;
      });
    });

    pageControllerFavorites =
        PageController(initialPage: favoritList.length - 1);
    pageControllerFavorites.addListener(() {
      setState(() {
        currentPageFavorites = pageControllerFavorites.page;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    pageControllerFavorites.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black.withOpacity(0.9),
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }

  _buildBody() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.79)),
        child: ListView(
          children: <Widget>[
            _buildTitle(
                title: "Champions", count: championList.length.toString()),
            _buildCardsChampions(
              list: championList,
              controller: pageController,
              page: currentPage,
            ),
            _buildTitle(
                title: "Favorites", count: favoritList.length.toString()),
            _buildCardsChampions(
              list: favoritList,
              controller: pageControllerFavorites,
              page: currentPageFavorites,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle({String title, String count}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.more_horiz,
                  size: 40,
                  color: Colors.white,
                ),
                onPressed: () {},
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 22, vertical: 6),
                      child: Text(
                        "Animated",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    count + "+ champions",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCardsChampions(
      {List list, PageController controller, double page}) {
    return Stack(
      children: <Widget>[
        CardScrollWidget(
          currentPage: page,
          list: list,
        ),
        Positioned.fill(
          child: PageView.builder(
            itemCount: list.length,
            controller: controller,
            reverse: true,
            itemBuilder: (context, index) {
              return Container();
            },
          ),
        )
      ],
    );
  }
}
