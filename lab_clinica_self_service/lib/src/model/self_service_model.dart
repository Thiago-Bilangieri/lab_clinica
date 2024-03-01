import 'package:flutter/material.dart';

import 'package:lab_clinica_self_service/src/model/patient_model.dart';

enum DocumentsType { healthInsuranceCard, medicalOrder }

final class SelfServiceModel {
  const SelfServiceModel({
    this.name,
    this.lastName,
    this.patient,
    this.documents,
  });

  final String? name;
  final String? lastName;
  final PatientModel? patient;
  final Map<DocumentsType, List<String>>? documents;

  SelfServiceModel clear() => copyWith(
        name: () => null,
        lastName: () => null,
        patient: () => null,
        documents: () => null,
      );

  SelfServiceModel copyWith({
    ValueGetter<String?>? name,
    ValueGetter<String?>? lastName,
    ValueGetter<PatientModel?>? patient,
    ValueGetter<Map<DocumentsType, List<String>>?>? documents,
  }) {
    return SelfServiceModel(
      name: name != null ? name() : this.name,
      lastName: lastName != null ? lastName() : this.lastName,
      patient: patient != null ? patient() : this.patient,
      documents: documents != null ? documents() : this.documents,
    );
  }

}
