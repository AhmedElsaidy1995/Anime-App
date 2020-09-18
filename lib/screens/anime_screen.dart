import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:anime_flutter/models/anime_item.dart';
import 'package:flutter/painting.dart';
import 'package:anime_flutter/component/item_widget.dart';
import 'package:anime_flutter/services/top.dart';
import 'package:anime_flutter/component/search_bar.dart';

class AnimePage extends StatefulWidget {
  AnimePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AnimePageState createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  TopModel animeModel = TopModel();
  List<AnmieItem> items = [];

  @override
  void initState() {
    super.initState();
    getAnimeData();
  }

  void getAnimeData() async {
    var animeData = await animeModel.getTopAnime();

    setState(() {
      if (animeData == null) {
        return;
      } else {
        for (var item in animeData['top']) {
          var title = item['title'];
          var img = item['image_url'];
          var id = item['mal_id'];
          var topAnime = AnmieItem(name: title, imageURL: img, id: id);
          items.add(topAnime);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: Search(type: TopType.anime));
            },
            icon: Icon(Icons.search),
          )
        ],
        title: Text('Anime'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 9 / 21),
          itemBuilder: (context, index) {
            return ItemWidget(
                imgUrl: items[index].imageURL,
                textTitle: items[index].name,
                id: items[index].id,
                tapType: TopType.anime);
          },
          itemCount: items.length,
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
