import 'package:lab_clinica_core/lab_clinica_core.dart';

abstract interface class UserLoginService {
  Future<Either<ServiceException, Unit>> execute(String email, String password);
}