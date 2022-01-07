import 'dart:io';

import 'package:flutter_application_1/server/server.dart';
import 'package:flutter_application_1/ui/detail_produk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProdukView extends StatelessWidget {
  final String apiUrl = UrlServer + "produk/get";
  void showSnakbar(BuildContext context, Message, color) {
    final snackBar = SnackBar(content: Text(Message), backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    List<dynamic>? fecthDataProduk;
  }

  Future<List<dynamic>> getLists() async {
    var response = await http.get(Uri.parse(apiUrl));
    try {
      var decodedResponse = json.decode(response.body)['data'];
      print(decodedResponse);
      return decodedResponse;
    } on SocketException catch (_) {}
    return [];
  }

  void setDetail(BuildContext context, id, namaProduk, jenis, stok, harga,
      deskripsi) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('_id', id);
    await prefs.setString('namaProduk', namaProduk);
    await prefs.setString('jenis', jenis);
    await prefs.setString('stok', stok);
    await prefs.setString('harga', harga);
    await prefs.setString('deskripsi', deskripsi);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => detail_produk_view(
                id: id,
                namaProduk: namaProduk,
                jenis: jenis,
                stok: stok,
                harga: harga,
                deskripsi: deskripsi)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Daftar Produk Skincare'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: getLists(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(5),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => setDetail(
                        context,
                        snapshot.data[index]['_id'],
                        snapshot.data[index]['namaProduk'],
                        snapshot.data[index]['jenis'],
                        snapshot.data[index]['stok'],
                        snapshot.data[index]['harga'],
                        snapshot.data[index]['deskripsi'],
                      ),
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 1.0,
                              child: Image.asset('assets/product.jpg'),
                              // child: Image.network("http://pasar.pptik.id/" +
                              //     snapshot.data[index]['IMAGE']),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 0.0, 2.0, 0.0),
                                child: ListTile(
                                  title: Text(
                                    snapshot.data[index]['namaProduk'],
                                    style: const TextStyle(
                                        color: Colors.pink,
                                        fontSize: 20,
                                        fontStyle: FontStyle.normal),
                                  ),
                                  subtitle: Text("Jenis              : " +
                                      snapshot.data[index]['jenis'] +
                                      "" +
                                      "                                                                  " +
                                      "Stok                : " +
                                      snapshot.data[index]['stok'] +
                                      "" +
                                      "                                                                  " +
                                      "Harga             : Rp." +
                                      snapshot.data[index]['harga'] +
                                      " ,-" +
                                      "                                                              " +
                                      "Deskripsi       : " +
                                      snapshot.data[index]['deskripsi']),

                                  // Text(),

                                  // author: author,
                                  // publishDate: publishDate,
                                  // readDuration: readDuration,
                                ),
                              ),
                            ),
                            // child:Card(),

                            // child:Text('Detail'),
                            // Expanded(child: Text)
                            // widget(child:)
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
