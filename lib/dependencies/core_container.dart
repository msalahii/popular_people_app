import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:popular_people_app/dependencies/service_locator.dart';
import '../core/network/network_info.dart';

class CoreContainer extends ServiceLocator {
  CoreContainer() {
    init();
  }

  @override
  void init() async {
    serviceLocator.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImplementation(serviceLocator()));
    serviceLocator.registerLazySingleton(() => http.Client());
    serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
  }
}
