import 'package:flutter/material.dart';
import 'package:megahd/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:megahd/app/shared/constants.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: clientKey,
      masterKey: masterKey,
      coreStore: await CoreStoreSharedPrefsImp.getInstance(),
      debug: true);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('id')) {
    prefs.setString('id', Uuid().v1());
  }
  // SystemChrome.setEnabledSystemUIOverlays([]);
  return runApp(ModularApp(module: AppModule()));
}
