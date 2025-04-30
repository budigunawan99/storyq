import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storyq/common.dart';
import 'package:storyq/provider/settings/localizations_provider.dart';
import 'package:storyq/static/localization.dart';

class FlagIconWidget extends StatelessWidget {
  const FlagIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        icon: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0),
          child: Icon(
            Icons.flag,
            size: 25,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        items:
            AppLocalizations.supportedLocales.map((Locale locale) {
              final flag = Localization.getFlag(locale.languageCode);
              return DropdownMenuItem(
                value: locale,
                child: Center(
                  child: Text(
                    flag,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                onTap: () {
                  context.read<LocalizationProvider>().setLocale(locale);
                },
              );
            }).toList(),
        onChanged: (_) {},
      ),
    );
  }
}
