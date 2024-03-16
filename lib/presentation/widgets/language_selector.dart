import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reservas_app/main.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    final initialLocale = AuthenticationWrapper.getLocale(context);
    _selectedLanguage = initialLocale?.languageCode ??
        AppLocalizations.supportedLocales[0].languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedLanguage,
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedLanguage = newValue;
            _changeLocale(newValue);
          });
        }
      },
      items: AppLocalizations.supportedLocales.map((Locale locale) {
        return DropdownMenuItem<String>(
          value: locale.languageCode,
          child: Text(locale.languageCode.toUpperCase()),
        );
      }).toList(),
    );
  }

  void _changeLocale(String languageCode) {
    Locale newLocale = Locale(languageCode);
    AppLocalizations.delegate.load(newLocale);
    AuthenticationWrapper.setLocale(context, newLocale);
  }
}
