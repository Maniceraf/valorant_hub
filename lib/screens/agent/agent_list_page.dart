import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:http/http.dart' as http;
import 'package:valorant_hub/models/agent_models/agent_model.dart';
import 'package:valorant_hub/screens/agent/agent_detail_page.dart';
import 'package:valorant_hub/widgets/custom_snackbar.dart';

class AgentListPage extends StatefulWidget {
  const AgentListPage({super.key});

  @override
  State<AgentListPage> createState() => AgentListPageState();
}

class AgentListPageState extends State<AgentListPage> {
  late Future<List<AgentListItemModel>> agents;
  late Size _size = const Size(0, 0);
  bool _showGrid = false;

  @override
  void initState() {
    super.initState();
    agents = fetchAgents();
  }

  Future<List<AgentListItemModel>> fetchAgents() async {
    final uri = Uri.parse(
        'https://valorant-api.com/v1/agents?isPlayableCharacter=true');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final data = AgentListResponseModel.fromJson(jsonData);
      return data.data;
    } else {
      throw Exception('Failed to load agent');
    }
  }

  Widget buildContent(List<AgentListItemModel> data, Size size) {
    if (data.isEmpty) {
      return const Center(child: Text('No items'));
    } else {
      return Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 2, right: 2),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Text(
                          'All Agents',
                          style: GoogleFonts.sora(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 30.0,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      setState(() {
                        _showGrid = !_showGrid;
                      });
                    },
                    style: const ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: !_showGrid
                        ? const Icon(Icons.grid_view_rounded,
                            color: Colors.black)
                        : const Icon(Icons.view_list_rounded,
                            color: Colors.black),
                  ),
                ],
              ),
            ),
            Expanded(child: _buidAgentsList(data))
          ],
        ),
      );
    }
  }

  String addLeadingZeros(int number) {
    String numberString = number.toString();
    int length = numberString.length;
    if (length < 2) {
      String zeros = '0' * (length);
      return '$zeros$numberString';
    }
    return numberString;
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _buildAppBar(),
      body: FutureBuilder<List<AgentListItemModel>>(
        future: agents,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return buildContent(snapshot.data!, _size);
          } else if (snapshot.hasError) {
            return Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent[400],
                    foregroundColor: Colors.white),
                onPressed: () {
                  setState(() {
                    agents = fetchAgents();
                  });
                },
                child: Text(
                  "Reload",
                  style: GoogleFonts.sora(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(color: HexColor("#ff4655")),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.redAccent[400],
      title: const Text('Agents'),
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
      actions: [
        IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(snackBar1);
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ))
      ],
    );
  }

  Widget _buidAgentsList(List<AgentListItemModel> data) {
    if (_showGrid) {
      return _buildAgentsGridView(data);
    } else {
      return _buildAgentsListView(data);
    }
  }

  Widget _buildAgentsListView(List<AgentListItemModel> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return _buildAgentListViewItem(item, index + 1);
      },
    );
  }

  Widget _buildAgentListViewItem(AgentListItemModel item, int index) {
    return SizedBox(
      child: Card(
        elevation: 10,
        shadowColor: Colors.blueGrey,
        color: HexColor("#0f1923"),
        shape: const RoundedRectangleBorder(
            side: BorderSide(
                color: Colors.amber,
                style: BorderStyle.solid,
                width: 1,
                strokeAlign: BorderSide.strokeAlignInside)),
        child: InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AgentDetailPage(
                  uuid: item.uuid,
                  name: item.displayName,
                ),
              ),
            );
          },
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          addLeadingZeros(index).toUpperCase(),
                          style: GoogleFonts.sora(
                              color: HexColor("#ff4655"),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CachedNetworkImage(
                        imageUrl: item.displayIcon,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Text(
                              item.displayName.toUpperCase(),
                              style: GoogleFonts.sora(
                                  color: HexColor("#ff4655"),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(
                          height: 0.1,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 10,
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
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: CachedNetworkImage(
                                progressIndicatorBuilder:
                                    (context, url, progress) => Center(
                                  child: CircularProgressIndicator(
                                    value: progress.progress,
                                  ),
                                ),
                                imageUrl: item.role.displayIcon,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              item.role.displayName,
                              style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        )
                      ],
                    ))
                  ])),
        ),
      ),
    );
  }

  Widget _buildAgentsGridView(List<AgentListItemModel> data) {
    final double itemHeight = (_size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = _size.width / 2;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / (itemHeight - 50)),
        mainAxisSpacing: _size.height * 0.01,
        crossAxisSpacing: _size.height * 0.01,
      ),
      controller: ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return _buildAgentGridViewItem(item, index + 1);
      },
    );
  }

  Widget _buildAgentGridViewItem(AgentListItemModel item, int index) {
    return Card(
      elevation: 10,
      shadowColor: Colors.blueGrey,
      color: HexColor("#0f1923"),
      shape: const RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.amber,
              style: BorderStyle.solid,
              width: 1,
              strokeAlign: BorderSide.strokeAlignInside)),
      child: InkWell(
        enableFeedback: true,
        splashColor: Colors.white,
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AgentDetailPage(
                uuid: item.uuid,
                name: item.displayName,
              ),
            ),
          );
        },
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        addLeadingZeros(index).toUpperCase(),
                        style: GoogleFonts.sora(
                            color: HexColor("#ff4655"),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CachedNetworkImage(
                      imageUrl: item.displayIcon,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.displayName.toUpperCase(),
                            style: GoogleFonts.sora(
                                color: HexColor("#ff4655"),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        height: 0.1,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10,
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
                          SizedBox(
                            width: 15,
                            height: 15,
                            child: CachedNetworkImage(
                              imageUrl: item.role.displayIcon,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            item.role.displayName,
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      )
                    ],
                  ))
                ])),
      ),
    );
  }
}

final snackBar1 = SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.redAccent[400],
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            spreadRadius: 2.0,
            blurRadius: 8.0,
            offset: Offset(2, 4),
          )
        ],
        borderRadius: BorderRadius.zero,
      ),
      child: Text(
        "This feature is not yet developed",
        style: GoogleFonts.sora(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    ));
