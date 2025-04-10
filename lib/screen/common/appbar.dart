import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storyq/provider/settings/theme_provider.dart';
import 'package:storyq/screen/common/theme_switcher.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHomePage;
  final String? title;
  const Appbar({super.key, required this.isHomePage, this.title});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return AppBar(
          title: titleOptions(title, themeProvider),
          leading: leadingOptions(context),
          actions: [ThemeSwitcher()],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Widget? leadingOptions(context) {
    if (isHomePage) {
      return null;
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 11.0, right: 11.0),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 20,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      );
    }
  }

  Widget titleOptions(title, themeProvider) {
    if (title == null) {
      return themeProvider.isDarkMode
          ? Image.asset("assets/images/storyq_dark.png", width: 150, height: 40)
          : Image.asset(
            "assets/images/storyq_light.png",
            width: 150,
            height: 40,
          );
    } else {
      return Text(title);
    }
  }
}
