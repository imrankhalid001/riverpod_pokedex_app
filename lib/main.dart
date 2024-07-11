import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_pokedex_app/pages/home_page.dart';
import 'package:riverpod_pokedex_app/services/http_service.dart';

void main() async {

  await _setUpService();
  runApp(const MainApp());
}

Future<void> _setUpService() async{

GetIt.instance.registerSingleton<HTTPService>(
  HTTPService(),
);

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Poke Dex',
        theme:   ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
          useMaterial3: true,
          textTheme: GoogleFonts.quattrocentoSansTextTheme(),
      
          
      
        ),
      
      
      
        home: HomePage(
        ),
      ),
    );
  }
}
