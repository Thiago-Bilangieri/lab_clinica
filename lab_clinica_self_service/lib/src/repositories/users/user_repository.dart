import 'package:lab_clinica_core/lab_clinica_core.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String passwortd);

}