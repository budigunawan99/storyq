import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storyq/common.dart';
import 'package:storyq/provider/auth/auth_provider.dart';
import 'package:storyq/provider/settings/theme_provider.dart';
import 'package:storyq/screen/common/appbar.dart';
import 'package:storyq/screen/common/theme_switcher.dart';
import 'package:storyq/screen/settings/flag_icon_widget.dart';
import 'package:storyq/static/logout_result_state.dart';

class SettingsScreen extends StatefulWidget {
  final Function() onLogout;
  final Function() onPop;

  const SettingsScreen({
    super.key,
    required this.onLogout,
    required this.onPop,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        isHomePage: false,
        title: AppLocalizations.of(context)!.settingsMenu,
        onPop: widget.onPop,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      context.watch<ThemeProvider>().isDarkMode
                          ? AppLocalizations.of(context)!.darkModeText
                          : AppLocalizations.of(context)!.lightModeText,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Flexible(flex: 1, child: ThemeSwitcher()),
                ],
              ),
            ),
            Divider(height: 2, thickness: 0.5),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      AppLocalizations.of(context)!.languageMenu,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Flexible(flex: 1, child: FlagIconWidget()),
                ],
              ),
            ),
            Divider(height: 2, thickness: 0.5),
            Padding(
              padding: const EdgeInsets.all(10),
              child:
                  context.watch<AuthProvider>().logoutResultState
                          is LogoutLoadingState
                      ? const CircularProgressIndicator()
                      : SizedBox(
                        width: 200,
                        height: 42,
                        child: TextButton(
                          onPressed: () async {
                            final authRead = context.read<AuthProvider>();
                            final result = await authRead.logout();
                            if (result) widget.onLogout();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.onSurface,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.logout,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              Text(
                                AppLocalizations.of(context)!.logoutMenu,
                                style: Theme.of(
                                  context,
                                ).textTheme.titleSmall?.copyWith(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
