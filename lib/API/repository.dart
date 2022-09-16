import 'package:weather/API/parsingWilayah.dart';
import 'package:weather/weather.dart';

class Repository {
  List<Map> getAll() => wilayahData;

  getidlokasibynama(String nama) => wilayahData
      .map((map) => Wilayah.fromJson(map))
      .where((item) => item.kota == nama)
      .map((item) => item.id)
      .toList();

  List getnama() => wilayahData
      .map((map) => Wilayah.fromJson(map))
      .map((item) => item.kota)
      .toList();
}
