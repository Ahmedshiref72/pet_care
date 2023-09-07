import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/screens/layout/newTabbar.dart';
import 'package:demo_project/src/screens/layout/splashscreen.dart';
import 'package:demo_project/src/screens/layout/welcome.dart';
import 'package:demo_project/src/screens/user/login/login_container_view.dart';
import 'package:demo_project/src/share_preference/preferencesKey.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'localization/language_constants.dart';



class AppScreen extends StatefulWidget {
  final SharedPreferences prefs;

  AppScreen(this.prefs);

  @override
  State<AppScreen> createState() => _AppScreenState();

 static void setLocale(BuildContext context, Locale newLocale) {
   _AppScreenState? state = context.findAncestorStateOfType<_AppScreenState>();
   state?.setLocale(newLocale);
}

}

class _AppScreenState extends State<AppScreen> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Product Sans',
        // primaryColor: appColorBlack,
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      home: _handleCurrentScreen(widget.prefs),
    );
  }

  Widget _handleCurrentScreen(SharedPreferences prefs) {
    String? data = prefs.getString(SharedPreferencesKey.LOGGED_IN_USERRDATA);
    preferences = prefs;
    return SplashScreen();
    /*if (data != null) {
      if (preferences!.containsKey("guest user")) {
        print('0');
        return WelcomeScreen();
      } else {
        print('1');
        return SplashScreen();
      }
    } else {
      print('2');
      return TabbarScreen();
    }*/
  }
}
