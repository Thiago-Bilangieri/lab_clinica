import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lab_clinica_core/lab_clinica_core.dart';
import 'package:lab_clinica_self_service/src/model/patient_model.dart';

import './patients_repository.dart';

class PatientsRepositoryImpl implements PatientsRepository {
  PatientsRepositoryImpl({
    required this.restClient,
  });

  final RestClient restClient;
  @override
  Future<Either<RepositoryException, PatientModel?>> findPatientByDocument(
      String document) async {
    try {
      final Response(:List data) = await restClient.auth
          .get("/patients", queryParameters: {'document': document});

      if (data.isEmpty) {
        return Right(null);
      }
      return Right(PatientModel.fromJson(data.first));
    } on DioException catch (e, s) {
      log("Erro ao buscar paciente por cpf", error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }

  @override
  Future<Either<RepositoryException, Unit>> update(
      PatientModel newPatient) async {
    try {
      await restClient.auth.put(
        '/patients/${newPatient.id}',
        data: newPatient.toJson(),
      );
      return Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao Atualizar o paciente', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }

  @override
  Future<Either<RepositoryException, PatientModel>> register(
      RegisterPatientModel patient) async {
    try {
      final Response(:data) = await restClient.auth.post('/patients', data: {
          'name': patient.name,
          'email': patient.email,
          'phone_number': patient.phoneNumber,
          'document': patient.document,
          'address': {
            'cep': patient.address.cep,
            'street_address': patient.address.streetAddress,
            'state': patient.address.state,
            'city': patient.address.city,
            'number': patient.address.number,
            'district': patient.address.district,
            'address_complement': patient.address.addressComplement
          },
          'guardian': patient.guardian,
          'guardian_identification_number':
              patient.guardianIdentificationNumber
        
      });
      return Right(
        PatientModel.fromJson(data),
      );
    } on DioException catch (e, s) {
      log('Erro ao cadastrar o paciente', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}
