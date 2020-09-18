import 'network_helper.dart';

const animeURL = 'https://api.jikan.moe/v3/top/anime/1/airing';
const mangaURL = 'https://api.jikan.moe/v3/top/manga/1/manga';
const animeTapURL = 'https://api.jikan.moe/v3/anime/';
const mangaTapURL = 'https://api.jikan.moe/v3/manga/';

class TopModel {
  Future<dynamic> getTopAnime() async {
    NetworkHelper networkHelper = NetworkHelper(animeURL);
    var animeData = await networkHelper.getData();
    return animeData;
  }

  Future<dynamic> getTopManga() async {
    NetworkHelper networkHelper = NetworkHelper(mangaURL);
    var mangaData = await networkHelper.getData();
    return mangaData;
  }

  Future<dynamic> animeSearch(String animeSearchName) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.jikan.moe/v3/search/anime?q=$animeSearchName');
    var animeSearchData = await networkHelper.getData();
    return animeSearchData;
  }

  Future<dynamic> mangaSearch(String mangaSearchName) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.jikan.moe/v3/search/manga?q=$mangaSearchName');
    var mangaSearchData = await networkHelper.getData();
    return mangaSearchData;
  }

  Future<dynamic> animeTap(int animeID) async {
    NetworkHelper networkHelper =
        NetworkHelper('https://api.jikan.moe/v3/anime/$animeID');
    var animeTapData = await networkHelper.getData();
    return animeTapData;
  }

  Future<dynamic> mangaTap(int mangaID) async {
    NetworkHelper networkHelper =
        NetworkHelper('https://api.jikan.moe/v3/manga/$mangaID');
    var mangaTapData = await networkHelper.getData();
    return mangaTapData;
  }
}
