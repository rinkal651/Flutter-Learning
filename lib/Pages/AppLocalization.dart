import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_training/Pages/SharedPreferencesData.dart';

class AppLocalization extends StatelessWidget {
  const AppLocalization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'App localization',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      /*   localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: [
          Locale('en'),
          Locale('es')
        ],*/
      home: LocalizeMessagePage(),
    );
  }
}

class LocalizeMessagePage extends StatelessWidget {
  const LocalizeMessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
/*    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("App Localization"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Add the following code
            Localizations.override(
              context: context,
              locale: const Locale('es'),
              // Using a Builder to get the correct BuildContext.
              // Alternatively, you can create a new widget and Localizations.override
              // will pass the updated BuildContext to the new widget.
              child: Builder(
                builder: (context) {
                  // A toy example for an internationalized Material widget.
                  return Text("Hello! Rinkal is here");
                },
              ),
            ),
          ],
        ),
      ),
    );*/
    return Scaffold(
      appBar: AppBar(
        title: Text("app Localization"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(SharedPreferencesData.getUsername().toString()),
          SizedBox(
            height: 30,
          ),Text(AppLocalizations.of(context)!.helloWorld),
          SizedBox(
            height: 30,
          ),
          Text(AppLocalizations.of(context)!.user_status('Rinkal', 'Available'))
        ]),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {  }, child: Icon(Icons.navigate_next_sharp),
      ),
    );
  }
}
