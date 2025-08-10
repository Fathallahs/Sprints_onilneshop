import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/providers/locale_provider.dart';

Future<void> showLanguagePicker(BuildContext context) async {
  final locale = context.read<LocaleProvider>().locale;
  await showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('English'),
              trailing: locale.languageCode == 'en' ? const Icon(Icons.check) : null,
              onTap: () {
                context.read<LocaleProvider>().setLocale(const Locale('en'));
                Navigator.of(ctx).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('العربية'),
              trailing: locale.languageCode == 'ar' ? const Icon(Icons.check) : null,
              onTap: () {
                context.read<LocaleProvider>().setLocale(const Locale('ar'));
                Navigator.of(ctx).pop();
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      );
    },
  );
}
