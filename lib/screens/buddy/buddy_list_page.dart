import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valorant_hub/models/buddy_models/buddy_model.dart';

import 'package:http/http.dart' as http;

class BuddyListPage extends StatefulWidget {
  const BuddyListPage({super.key});

  @override
  State<StatefulWidget> createState() => BuddyListPageState();
}

class BuddyListPageState extends State<BuddyListPage> {
  late Future<List<BuddyModel>> buddies;

  @override
  void initState() {
    super.initState();
    buddies = fetchAgent();
  }

  Future<List<BuddyModel>> fetchAgent() async {
    final uri = Uri.parse('https://valorant-api.com/v1/buddies');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final data = BuddyListResponseModel.fromJson(jsonData);
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
          child: FutureBuilder<List<BuddyModel>>(
            future: buddies,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data?[index];
                    return Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: ListTile(
                          leading: SizedBox(
                            width: 50,
                            child: CachedNetworkImage(
                              imageUrl: item!.displayIcon,
                            ),
                          ),
                          title: Text(item.displayName),
                        ),
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
      title: const Text('Buddies'),
      titleTextStyle: GoogleFonts.sora(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      centerTitle: true,
    );
  }
}
