import 'package:flutter/material.dart';
import 'package:anime_flutter/models/anime_item.dart';
import 'item_widget.dart';
import 'package:anime_flutter/services/top.dart';

enum TopType { anime, manga }

class Search extends SearchDelegate {
  TopType type;
  Search({this.type});
  TopModel searchModel = TopModel();
  List<AnmieItem> searchList = [];

  Future animeSearchedData(String animeName) async {
    var animeSearchData = await searchModel.animeSearch(animeName);
    searchList.clear();

    if (animeSearchData == null) {
      return;
    } else {
      for (var searchItem in animeSearchData['results']) {
        var title = searchItem['title'];
        var img = searchItem['image_url'];
        var animeId = searchItem['mal_id'];
        var animeSearchResults =
            AnmieItem(name: title, imageURL: img, id: animeId);
        searchList.add(animeSearchResults);
      }
    }
  }

  Future mangaSearchedData(String mangaName) async {
    var mangaSearchData = await searchModel.mangaSearch(mangaName);
    searchList.clear();

    if (mangaSearchData == null) {
      return;
    } else {
      for (var searchItem in mangaSearchData['results']) {
        var title = searchItem['title'];
        var img = searchItem['image_url'];
        var mangaId = searchItem['mal_id'];
        var mangaSearchResults =
            AnmieItem(name: title, imageURL: img, id: mangaId);
        searchList.add(mangaSearchResults);
      }
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < 3) {
      return Text('Pls Enter Minimum 3 Alphabits');
    }
    return FutureBuilder(
      future: type == TopType.anime
          ? animeSearchedData(query)
          : mangaSearchedData(
              query), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading....');
            break;
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Container(
                padding: EdgeInsets.only(top: 10),
                child: GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 9 / 21),
                  itemBuilder: (context, index) {
                    return ItemWidget(
                        imgUrl: searchList[index].imageURL,
                        textTitle: searchList[index].name,
                        id: searchList[index].id,
                        tapType: type == TopType.anime
                            ? TopType.anime
                            : TopType.manga);
                  },
                  itemCount: searchList.length,
                ),
              );
            }
        }
      },
    );
  }
}
