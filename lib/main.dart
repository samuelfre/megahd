import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:megahd/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:megahd/app/shared/constants.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: clientKey,
      masterKey: masterKey,
      coreStore: await CoreStoreSharedPrefsImp.getInstance(),
      debug: true);
  // SystemChrome.setEnabledSystemUIOverlays([]);
  return runApp(ModularApp(module: AppModule()));
}
