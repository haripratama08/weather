// ignore: file_names
class Weather {
  String? jamCuaca;
  String? kodeCuaca;
  String? cuaca;
  String? humidity;
  String? tempC;
  String? tempF;

  Weather(
      {this.jamCuaca,
      this.kodeCuaca,
      this.cuaca,
      this.humidity,
      this.tempC,
      this.tempF});

  Weather.fromJson(Map<String, dynamic> json) {
    jamCuaca = json['jamCuaca'];
    kodeCuaca = json['kodeCuaca'];
    cuaca = json['cuaca'];
    humidity = json['humidity'];
    tempC = json['tempC'];
    tempF = json['tempF'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['jamCuaca'] = jamCuaca;
    data['kodeCuaca'] = kodeCuaca;
    data['cuaca'] = cuaca;
    data['humidity'] = humidity;
    data['tempC'] = tempC;
    data['tempF'] = tempF;
    return data;
  }
}
