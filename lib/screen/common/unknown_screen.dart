import 'package:flutter/material.dart';
import 'package:storyq/screen/common/appbar.dart';

class UnknownScreen extends StatelessWidget {
  final Function() onPop;

  const UnknownScreen({super.key, required this.onPop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(isHomePage: false, title: "Error!", onPop: onPop),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Halaman tidak ditemukan',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
