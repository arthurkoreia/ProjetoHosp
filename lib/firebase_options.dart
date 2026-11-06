// Configuração provisória do Firebase.
// No diretório raiz do projeto, execute:
//   dart pub global activate flutterfire_cli
//   flutterfire configure
// Selecione o projeto projetohosp-eec49 e a plataforma Web.
// O FlutterFire CLI substituirá este arquivo pelos valores corretos.
// Não utilize esta configuração provisória para gravar dados.

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'O Firebase ainda não foi configurado para esta plataforma.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'CONFIGURE_COM_FLUTTERFIRE',
    appId: 'CONFIGURE_COM_FLUTTERFIRE',
    messagingSenderId: 'CONFIGURE_COM_FLUTTERFIRE',
    projectId: 'projetohosp-eec49',
  );

  static const FirebaseOptions android = web;
  static const FirebaseOptions ios = web;
}
