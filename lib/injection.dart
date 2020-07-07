import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.iconfig.dart';

final getIt = GetIt.instance;

@injectableInit
void configureInjection(env) => $initGetIt(getIt, environment: env);

abstract class Env {
  static const String dev = 'dev';
  static const String prod = 'prod';
  static const String mock = 'mock';

  static const devEnv = const Environment(dev);
  static const prodEnv = const Environment(prod);
  static const mockEnv = const Environment(mock);
}