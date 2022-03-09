import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobsheet4_praktik1/widget/input.dart';
import 'package:jobsheet4_praktik1/widget/convert.dart';
import 'package:jobsheet4_praktik1/widget/result.dart';
import 'package:jobsheet4_praktik1/widget/RiwayatKonversi.dart';
import 'package:jobsheet4_praktik1/widget/Perhitungan.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _counter = 0;
  TextEditingController etInput = TextEditingController();
  double _inputUser = 0;
  double _result = 0.0;
  String selectedDropdown = 'Kelvin';
  List<String> listSatuanSuhu = ['Kelvin', 'Reamur', 'Fahrenheit'];
  List<String> listHasil = [];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _konverterSuhu() {
    return setState(() {
      if (etInput.text.isNotEmpty) {
        switch (selectedDropdown) {
          case 'Kelvin':
            _result = int.parse(etInput.text) + 273.15;

            break;
          case 'Reamur':
            _result = int.parse(etInput.text) * 4 / 5;

            break;
          case 'Fahrenheit':
            _result = (int.parse(etInput.text) * 9 / 5) + 32;

            break;
        }
        listHasil.add(etInput.text +
            ' Celcius ke ' +
            selectedDropdown +
            ' hasilnya adalah : ' +
            _result.toString());
      }
    });
  }

  onDropdownChanged(Object? value) {
    setState(() {
      selectedDropdown = value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Jobsheet4",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('konverter suhu'),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              input(etInput: etInput),
              SizedBox(height: 10),
              Perhitungan(
                selectedDropdown: selectedDropdown,
                listSatuanSuhu: listSatuanSuhu,
                onDropdownChanged: onDropdownChanged,
              ),
              SizedBox(height: 10),
              Text(
                'Hasil',
                style: TextStyle(fontSize: 20),
              ),
              result(result: _result),
              convert(
                onPressed: _konverterSuhu,
              ),
              SizedBox(height: 10),
              Text(
                'Riwayat Konversi',
                style: TextStyle(fontSize: 20),
              ),
              RiwayatKonversi(listHasil: listHasil),
            ],
          ),
        ),
      ),
    );
  }
}
