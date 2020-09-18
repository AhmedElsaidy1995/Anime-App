import 'package:flutter/material.dart';
import 'package:anime_flutter/component/item_widget.dart';
import 'package:anime_flutter/services/top.dart';
import 'package:anime_flutter/models/anime_item.dart';
import 'package:anime_flutter/component/search_bar.dart';

class MangaPage extends StatefulWidget {
  MangaPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MangaPageState createState() => _MangaPageState();
}

class _MangaPageState extends State<MangaPage> {
  TopModel mangaModel = TopModel();
  List<AnmieItem> items = [];

  @override
  void initState() {
    super.initState();
    getMangaData();
  }

  void getMangaData() async {
    var mangaData = await mangaModel.getTopManga();

    setState(() {
      if (mangaData == null) {
        return;
      } else {
        for (var item in mangaData['top']) {
          var title = item['title'];
          var img = item['image_url'];
          var id = item['mal_id'];
          var topManga = AnmieItem(name: title, imageURL: img, id: id);
          items.add(topManga);
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
                  context: context, delegate: Search(type: TopType.manga));
            },
            icon: Icon(Icons.search),
          )
        ],
        title: Text('Manga'),
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
                tapType: TopType.manga);
          },
          itemCount: items.length,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
