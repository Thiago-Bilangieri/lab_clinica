import 'package:lab_clinica_core/lab_clinica_core.dart';
import 'package:lab_clinica_self_service/src/model/patient_model.dart';



typedef RegisterPatientAddressModel = ({
  String cep,
  String streetAddress,
  String state,
  String city,
  String number,
  String district,
  String addressComplement,
});

typedef RegisterPatientModel = ({
  String name,
  String email,
  String document,
  String phoneNumber,
  RegisterPatientAddressModel address,
  String guardian,
  String guardianIdentificationNumber,
});

abstract interface class PatientsRepository {
  Future<Either<RepositoryException, PatientModel?>> findPatientByDocument(
      String document);

  Future<Either<RepositoryException, Unit>> update(PatientModel newPatient);
  
  
  Future<Either<RepositoryException, PatientModel>> register(RegisterPatientModel newPatient);


}
