import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:popular_people_app/utils/route_generator.dart';
import 'dependencies/app_container.dart' as dependancy_injection;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'features/popular_people_list/presentation/pages/popular_people_view.dart';
import 'utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  await dependancy_injection.init();
  await dotenv.load();
  Hive.init(appDocumentDir.path);
  await Hive.openBox(personBoxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Popular People App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.cairoTextTheme()
      ),
      home: const PopularPeopleView(),
      initialRoute: PopularPeopleView.routeName,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}