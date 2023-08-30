import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:store_fake_api/constant/constant.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List> _getProduct() async {
    var url = Uri.parse(kProductUrl);
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    return data;
  }

  @override
  void initState() {
    _getProduct();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
        ),
        body: FutureBuilder<List>(

            future: _getProduct(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.data == null) {
                return Text("No data");
              }
              if (snapshot.data!.isEmpty) {
                return Text("Data Emthy");
              }
              return GridView.builder(
                padding: EdgeInsets.all(15),
                itemCount: snapshot.data!.length,
                itemBuilder: (contex, index) {
                  return Column(
                    children: [
                      Container(
                        child:Image.network(
                          snapshot.data![index]['image'] ,width: 100,
                        ),
                      )
                    ],
                  );
                },gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              );
            }),
      ),
    );
  }
}
