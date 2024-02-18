import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:http/http.dart' as http;
import 'package:valorant_hub/models/bundle_models/bundle_model.dart';

class BundleListPage extends StatefulWidget {
  const BundleListPage({super.key});

  @override
  State<BundleListPage> createState() => BundleListPageState();
}

class BundleListPageState extends State<BundleListPage> {
  late Future<List<BundleModel>> bundles;

  @override
  void initState() {
    super.initState();
    bundles = fetchBundles();
  }

  Future<List<BundleModel>> fetchBundles() async {
    final uri = Uri.parse('https://valorant-api.com/v1/bundles');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final data = BundleListResponseModel.fromJson(jsonData);
      return data.data;
    } else {
      throw Exception('Failed to load buddy.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<List<BundleModel>>(
            future: bundles,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data?[index];
                    return Card(
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignInside),
                          borderRadius: BorderRadius.zero),
                      elevation: 2,
                      child: Column(
                        children: [
                          SizedBox(
                            child: CachedNetworkImage(
                              imageUrl: item!.displayIcon,
                              placeholder: (context, url) {
                                return const Padding(
                                  padding: EdgeInsets.all(30),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                              errorWidget: (context, url, error) =>
                                  const Padding(
                                padding: EdgeInsets.all(30),
                                child: Icon(Icons.error),
                              ),
                              fadeInDuration: const Duration(seconds: 1),
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                item.displayName,
                                style: GoogleFonts.sora(
                                    color: HexColor("#ff4655"),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.redAccent[400],
      title: const Text('Bundles'),
      titleTextStyle: GoogleFonts.sora(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      centerTitle: true,
    );
  }
}
