import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'pages/dashboard_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var firebaseConfigurado = false;
  try {
    final options = DefaultFirebaseOptions.currentPlatform;
    if (!options.apiKey.startsWith('CONFIGURE_') &&
        !options.appId.startsWith('CONFIGURE_')) {
      await Firebase.initializeApp(options: options);
      firebaseConfigurado = true;
    }
  } catch (erro) {
    debugPrint('Firebase ainda não configurado: $erro');
  }

  runApp(ProjetoHospApp(firebaseConfigurado: firebaseConfigurado));
}

class ProjetoHospApp extends StatelessWidget {
  const ProjetoHospApp({super.key, required this.firebaseConfigurado});

  final bool firebaseConfigurado;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProjetoHosp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF176B87)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F7FA),
      ),
      home: DashboardPage(firebaseConfigurado: firebaseConfigurado),
    );
  }
}
