import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env.dev')
abstract class Env {
  @EnviedField(varName: 'LD_MOBILE_TOKEN')
  static const String mobileToken = _Env.mobileToken;
}