import 'package:lab_clinica_core/lab_clinica_core.dart';
import 'package:lab_clinica_self_service/src/model/self_service_model.dart';

abstract interface class InformationFormRepository {
  Future<Either<RepositoryException, Unit>> register (SelfServiceModel model);
 
}