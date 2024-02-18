import 'package:flutter/material.dart';
import 'package:valorant_hub/screens/agent/agent_list_page.dart';
import 'package:valorant_hub/screens/buddy/buddy_list_page.dart';
import 'package:valorant_hub/screens/bundle/bundle_list_page.dart';
import 'package:valorant_hub/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Valorant Hub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/agent_list_page': (context) => const AgentListPage(),
        '/buddy_list_page': (context) => const BuddyListPage(),
        '/bundle_list_page': (context) => const BundleListPage(),
      },
    );
  }
}
