import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/API/api.dart';
import 'package:weather/API/repository.dart';

List<Map<String, dynamic>> wilayahData = [];
dynamic pilihWilayah;
String? suhu;

class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  Repository repo = Repository();
  Future loadWilayah() async {
    var url = Uri.parse(endpointWilayah);
    var jsonString = await http.get(
      url,
    );
    var jsonResponse = json.decode(jsonString.body);
    if (mounted) {
      int jumlah = jsonResponse.length;
      for (int i = 0; i < jumlah; i++) {
        String id = jsonResponse[i]['id'];
        String propinsi = jsonResponse[i]['propinsi'];
        String kota = jsonResponse[i]['kota'];
        String kecamatan = jsonResponse[i]['kecamatan'];
        String lat = jsonResponse[i]['lat'];
        String lon = jsonResponse[i]['lon'];
        Map<String, dynamic> data = {
          "id": id,
          "propinsi": propinsi,
          "kota": kota,
          "kecamatan": kecamatan,
          "lat": lat,
          "lon": lon,
        };
        wilayahData.add(data);
        print(wilayahData);
      }
      Future.delayed(const Duration(seconds: 1), () {});
    }
  }

  Future loadWeather(String kodelokasi) async {
    var url = Uri.parse(
        'https://ibnux.github.io/BMKG-importer/cuaca/$kodelokasi.json');
    var jsonString = await http.get(
      url,
    );
    var jsonResponse = json.decode(jsonString.body);
    // ignore: avoid_print
    print(jsonResponse);
    if (mounted) {}
  }

  @override
  void initState() {
    loadWilayah();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 74, 168, 215),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                height: 50,
                width: 200,
                child: DropdownButton(
                    value: pilihWilayah,
                    isExpanded: true,
                    icon: const Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xff186962),
                      ),
                    ),
                    iconSize: 13,
                    underline: const SizedBox(),
                    onChanged: (val) {
                      _selectedWilayah(val.toString());
                      if (mounted) setState(() {});
                    },
                    hint: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Pilih Wilayah',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    items: wilayahData.map((detail) {
                      return DropdownMenuItem<String>(
                        value: detail['kota'],
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "$detail['kota']",
                            style: const TextStyle(
                              fontSize: 13,
                              fontFamily: "Kohi",
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList()),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // ignore: prefer_const_constructors
            const Center(
                child: SizedBox(
                    child: Text(
              "Cerah Berawan",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ))),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: suhu == null
                  ? const Text(
                      "data",
                      style: TextStyle(fontSize: 30),
                    )
                  : Text(
                      suhu!,
                      style: const TextStyle(fontSize: 30),
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(child: Image.asset('asset/img/sun.png')),
            const SizedBox(
              height: 150,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 350,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'asset/img/cloud.png',
                          height: 10,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "17",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'asset/img/cloud.png',
                          height: 10,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "17",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'asset/img/cloud.png',
                          height: 10,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "17",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'asset/img/cloud.png',
                          height: 10,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "17",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
  void _selectedWilayah(String value) {
    if (mounted) {
      setState(() {
        var lokasi = repo.getidlokasibynama(value);
        loadWeather(lokasi);
        print(lokasi);
      });
    }
  }
}
