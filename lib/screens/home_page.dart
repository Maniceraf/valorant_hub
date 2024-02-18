import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:valorant_hub/models/item_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late List<ItemModel> items;
  @override
  void initState() {
    items = [
      ItemModel(
          link: '/agent_list_page',
          imageUrl:
              'https://images.contentstack.io/v3/assets/bltb6530b271fddd0b1/bltc655d62fc92e4acd/649bdd9094be10f2698941ed/071123_Val_EP7_China_CG_Banner.jpg',
          title: 'Agents',
          subTile: 'Unraveling Valorant\'s Agent Arsenal.'),
      ItemModel(
          link: '/buddy_list_page',
          imageUrl: 'https://pbs.twimg.com/media/FMcAfmTXMAUbf9-.jpg',
          title: 'Buddies',
          subTile: 'Weapon Accessories'),
      ItemModel(
          link: '/bundle_list_page',
          imageUrl:
              'https://cdn.oneesports.vn/cdn-data/sites/4/2024/01/Valorant-bundle-Kuronami.jpg',
          title: 'Bundles',
          subTile: 'All Bundles')
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[400],
        title: const Text('Valorant Hub'),
        titleTextStyle: GoogleFonts.sora(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "All Items",
                    style: GoogleFonts.sora(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: items.map((e) => _buildItem(e)).toList(),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildItem(ItemModel data) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: HexColor("#ff4655"),
                style: BorderStyle.solid,
                width: 1,
                strokeAlign: BorderSide.strokeAlignInside),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            SizedBox(
              child: CachedNetworkImage(
                imageUrl: data.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: ListTile(
                  title: Text(
                    data.title,
                    style: GoogleFonts.sora(
                        color: HexColor("#ff4655"),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    data.subTile,
                    style: GoogleFonts.sora(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 30.0,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.arrow_circle_right_rounded),
                    onPressed: () {
                      Navigator.pushNamed(context, data.link);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
