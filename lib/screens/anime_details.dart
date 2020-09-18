import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AnimeDetails extends StatelessWidget {
  AnimeDetails({this.animeData});
  final animeData;

  String getVideoId(String url) {
    String result =
        url.substring(url.indexOf('/embed/'), url.indexOf('?enable'));
    result = result.replaceAll('/embed/', '');
    return result;
  }

  int getGenresCount() {
    var genres = animeData['genres'] as List;
    return genres.length;
  }

  String getLicensors() {
    String cacheLisensor = '';
    for (var x in animeData['licensors']) {
      cacheLisensor += '${x['name']}, ';
    }
    return cacheLisensor;
  }

  Widget trailerImg() {
    if (animeData['trailer_url'] != null) {
      return GestureDetector(
        child: ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xFF001359), Colors.transparent],
            ).createShader(Rect.fromLTRB(0, 150, rect.width, rect.height));
          },
          blendMode: BlendMode.srcOver,
          child: Image.network(
            "https://img.youtube.com/vi/${getVideoId(animeData['trailer_url'])}/0.jpg",
            height: 215,
            fit: BoxFit.fitWidth,
            width: double.infinity,
          ),
        ),
        onTap: () async {
          var url =
              'https://www.youtube.com/watch?v=${getVideoId(animeData['trailer_url'])}';
          await launch(url);
        },
      );
    } else {
      return SizedBox();
    }
  }

  bool isProducerEmpty() {
    var producer = animeData['producer'] as List;
    return producer == null;
  }

  bool isStudioEmpty() {
    var studio = animeData['studios'] as List;
    return studio.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              trailerImg(),
              Container(
                padding: EdgeInsets.all(20),
                color: Color(0xFF001359),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AutoSizeText(
                            animeData['title'],
                            style: TextStyle(color: Colors.white, fontSize: 40),
                            maxLines: 2,
                            minFontSize: 25,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                animeData['premiered'] != null
                                    ? animeData['premiered']
                                    : 'Unknown',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                animeData['type'],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              AutoSizeText(
                                !isStudioEmpty()
                                    ? animeData['studios'][0]['name']
                                    : 'N/A',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Card(
                        elevation: 10,
                        margin: EdgeInsets.only(left: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              width: double.infinity,
                              color: Colors.black,
                              child: Text(
                                'Score',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              animeData['score'] != null
                                  ? animeData['score'].toString()
                                  : 'N/A',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: AutoSizeText(
                                animeData['scored_by'] != null
                                    ? animeData['scored_by'].toString()
                                    : 'N/A',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: <Widget>[
                    Image.network(
                      animeData['image_url'],
                      scale: 1.6,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        height: 220,
                        child: Column(
                          children: <Widget>[
                            Card(
                              margin: EdgeInsets.only(right: 10),
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: SizedBox(
                                height: 40,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Text(
                                          '${animeData['genres'][index]['name']}   ');
                                    },
                                    itemCount: getGenresCount(),
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: Card(
                                margin: EdgeInsets.only(right: 10, top: 2),
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 17, bottom: 10, left: 10),
                                      child: RichText(
                                        text: TextSpan(
                                            text: 'Ranked : ',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: animeData['rank'] != null
                                                    ? animeData['rank']
                                                        .toString()
                                                    : 'N/A',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 10, bottom: 20, left: 10),
                                      child: RichText(
                                        text: TextSpan(
                                            text: 'Popularity : ',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: animeData['popularity'] !=
                                                        null
                                                    ? animeData['popularity']
                                                        .toString()
                                                    : 'N/A',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 10, left: 10),
                                      child: RichText(
                                        text: TextSpan(
                                            text: 'Members : ',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    animeData['members'] != null
                                                        ? animeData['members']
                                                            .toString()
                                                        : 'N/A',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 10),
                        child: Text(
                          'Synopsis :',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15, top: 10, right: 15, bottom: 15),
                        child: Text(
                          animeData['synopsis'] != null
                              ? animeData['synopsis']
                              : 'Not Available',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 15,
              ),
              Card(
                margin: EdgeInsets.only(left: 10, right: 10),
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 10),
                      child: Text(
                        'Information :',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        animeData['episdoes'] == null
                            ? 'Episodes : Unknown'
                            : 'Episodes :${animeData['episodes'].toString()}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Status : ${animeData['status'] != null ? animeData['status'] : 'N/A'}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Aired : ${animeData['aired']['string'] != null ? animeData['aired']['string'] : 'N/A'}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Producers : ${!isProducerEmpty() ? animeData['producers'][0]['name'] : 'N/A'}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Licensors : ${getLicensors()}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Duration : ${animeData['duration'] != null ? animeData['duration'] : 'N/A'}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 10),
                      child: Text(
                        'Rating : ${animeData['rating'] != null ? animeData['rating'] : 'N/A'}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Card(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 15),
                        child: Text(
                          'For More Info :',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10, left: 15),
                        child: InkWell(
                          child: Text(
                            'Visit MyAnimeList',
                            style: TextStyle(color: Colors.blue[700]),
                          ),
                          onTap: () async {
                            var url = animeData['url'];
                            await launch(url);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
