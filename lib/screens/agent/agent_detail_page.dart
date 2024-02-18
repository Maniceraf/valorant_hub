import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:valorant_hub/models/ability.dart';
import 'package:valorant_hub/models/agent_models/agent_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class AgentDetailPage extends StatefulWidget {
  final String uuid;
  final String name;
  const AgentDetailPage({super.key, required this.uuid, required this.name});

  @override
  State<AgentDetailPage> createState() => AgentDetailPageState();
}

class AgentDetailPageState extends State<AgentDetailPage> {
  late Future<AgentModel> agent;

  @override
  void initState() {
    super.initState();
    agent = fetchAgent();
  }

  Future<AgentModel> fetchAgent() async {
    final uri = Uri.parse('https://valorant-api.com/v1/agents/${widget.uuid}');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final data = AgentResponseModel.fromJson(jsonData);
      return data.data;
    } else {
      throw Exception('Failed to load agent');
    }
  }

  Future<void> _downloadImage(BuildContext context, String url) async {
    String? message;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      final uri = Uri.parse(url);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final imageName = path.basename(url);
        bool dirDownloadExists = true;
        var directory = "/storage/emulated/0/Download/";

        dirDownloadExists = await Directory(directory).exists();
        if (dirDownloadExists) {
          directory = "/storage/emulated/0/Download/";
        } else {
          directory = "/storage/emulated/0/Downloads/";
        }
        final localPath = path.join(directory, imageName);

        // Downloading
        final imageFile = File(localPath);
        await imageFile.writeAsBytes(response.bodyBytes);

        message = 'Image saved to disk';
      } else {
        message = 'An error occurred while saving the image';
      }
    } catch (e) {
      message = 'An error occurred while saving the image';
    }

    scaffoldMessenger.showSnackBar(SnackBar(
        content: Text(
      message,
      style: GoogleFonts.sora(
          color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#0f1923"),
      appBar: AppBar(
        backgroundColor: Colors.redAccent[400],
        title: Text('${widget.name}\'s Info'),
        titleTextStyle: GoogleFonts.sora(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            )),
      ),
      body: FutureBuilder<AgentModel>(
        future: agent,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return _buildBody(snapshot.data!);
          } else if (snapshot.hasError) {
            return Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent[400],
                    foregroundColor: Colors.white),
                onPressed: () {
                  setState(() {
                    agent = fetchAgent();
                  });
                },
                child: Text(
                  "Reload",
                  style: GoogleFonts.sora(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            );
          } else {
            return _buildLoading();
          }
        },
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(color: HexColor("#ff4655")),
    );
  }

  Widget _buildBody(AgentModel data) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => _downloadImage(context, data.displayIcon),
                    icon: const Icon(Icons.download),
                    color: Colors.white,
                  ),
                ],
              ),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: CachedNetworkImage(
                      imageUrl: data.displayIcon,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.displayName.toUpperCase(),
                    style: GoogleFonts.sora(
                        color: HexColor("#ff4655"),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 0.1,
                color: Colors.blueGrey,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "ROLE",
                style: GoogleFonts.sora(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Text(
                    data.role.displayName,
                    style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 15,
                    height: 15,
                    child: CachedNetworkImage(
                      imageUrl: data.role.displayIcon,
                      fit: BoxFit.contain,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                data.role.description,
                style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 0.1,
                color: Colors.blueGrey,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "BIOGRAPHY",
                style: GoogleFonts.sora(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                data.description,
                style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 0.1,
                color: Colors.blueGrey,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "SPECIAL ABILITIES",
                style: GoogleFonts.sora(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                child: Column(
                  children:
                      data.abilities.map((e) => _buildAbilityItem(e)).toList(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 0.1,
                color: Colors.blueGrey,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "IMAGE 1",
                style: GoogleFonts.sora(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => _downloadImage(context, data.fullPortrait),
                    icon: const Icon(Icons.download),
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(
                child: CachedNetworkImage(
                  imageUrl: data.fullPortrait,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 0.1,
                color: Colors.blueGrey,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "IMAGE 2",
                style: GoogleFonts.sora(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () =>
                        _downloadImage(context, data.killfeedPortrait),
                    icon: const Icon(Icons.download),
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(
                child: CachedNetworkImage(
                  imageUrl: data.killfeedPortrait,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 0.1,
                color: Colors.blueGrey,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "IMAGE 3",
                style: GoogleFonts.sora(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => _downloadImage(context, data.background),
                    icon: const Icon(Icons.download),
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(
                child: CachedNetworkImage(
                  imageUrl: data.background,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAbilityItem(Ability data) {
    return Card(
      shape: const RoundedRectangleBorder(),
      color: HexColor("#0f1923"),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CachedNetworkImage(
                imageUrl: data.displayIcon,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
                child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${data.slot.toUpperCase()}: ${data.displayName}',
                  style: GoogleFonts.sora(
                      color: HexColor("#ff4655"),
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  data.description,
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
