import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MangaDetails extends StatelessWidget {
  MangaDetails({this.mangaData});
  final mangaData;

  int getGenresCount() {
    var genres = mangaData['genres'] as List;
    return genres.length;
  }

  String getLicensors() {
    String cacheLisensor = '';
    for (var x in mangaData['licensors']) {
      cacheLisensor += '${x['name']}, ';
    }
    return cacheLisensor;
  }

  bool isSerializationsEmpty() {
    var serializations = mangaData['serializations'] as List;
    return serializations == null;
  }

  bool isAuthorEmpty() {
    var author = mangaData['authors'] as List;
    return author == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
                            mangaData['title'],
                            style: TextStyle(color: Colors.white, fontSize: 40),
                            maxLines: 2,
                            minFontSize: 25,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Text(
                              //   mangaData['type'],
                              //   style: TextStyle(
                              //       color: Colors.white, fontSize: 15),
                              // ),
                              // SizedBox(
                              //   width: 10,
                              // ),
                              Text(
                                !isSerializationsEmpty()
                                    ? mangaData['serializations'][0]['name']
                                    : 'N/A',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              AutoSizeText(
                                !isAuthorEmpty()
                                    ? mangaData['authors'][0]['name']
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
                              mangaData['score'] != null
                                  ? mangaData['score'].toString()
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
                                mangaData['scored_by'] != null
                                    ? mangaData['scored_by'].toString()
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
                      mangaData['image_url'],
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
                                          '${mangaData['genres'][index]['name']}   ');
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
                                                text: mangaData['rank'] != null
                                                    ? mangaData['rank']
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
                                                text: mangaData['popularity'] !=
                                                        null
                                                    ? mangaData['popularity']
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
                                                    mangaData['members'] != null
                                                        ? mangaData['members']
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
                          mangaData['synopsis'] != null
                              ? mangaData['synopsis']
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
                        mangaData['volumes'] == null
                            ? 'volumes : Unknown'
                            : 'volumes :${mangaData['volumes'].toString()}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        mangaData['chapters'] == null
                            ? 'chapters : Unknown'
                            : 'chapters :${mangaData['chapters'].toString()}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Status : ${mangaData['status'] != null ? mangaData['status'] : 'N/A'}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Published : ${mangaData['published'] != null ? mangaData['published']['string'] : 'N/A'}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
                            var url = mangaData['url'];
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
