import 'package:flutter/material.dart';
import 'package:storyq/screen/common/appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(isHomePage: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: "Tambah cerita",
        child: const Icon(Icons.add, size: 28),
      ),
      body: Center(child: Text("Hello world")),
    );
  }
}
