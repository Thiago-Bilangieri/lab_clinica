import 'package:json_annotation/json_annotation.dart';

part 'patient_address_model.g.dart';

@JsonSerializable()
class PatientAddressModel {
  PatientAddressModel({
    required this.cep,
    required this.streetAddress,
    required this.state,
    required this.number,
    required this.city,
    required this.district,
    required this.addressComplement,
  });

  final String cep;
  @JsonKey(name: 'street_address')
  final String streetAddress;
  final String state;
  final String city;
  final String number;
  final String district;
  @JsonKey(name: 'address_complement', defaultValue: "")
  final String addressComplement;

  factory PatientAddressModel.fromJson(Map<String, dynamic> json) =>
      _$PatientAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientAddressModelToJson(this);

  PatientAddressModel copyWith({
    String? cep,
    String? streetAddress,
    String? state,
    String? city,
    String? number,
    String? district,
    String? addressComplement,
  }) {
    return PatientAddressModel(
      cep: cep ?? this.cep,
      streetAddress: streetAddress ?? this.streetAddress,
      state: state ?? this.state,
      city: city ?? this.city,
      number: number ?? this.number,
      district: district ?? this.district,
      addressComplement: addressComplement ?? this.addressComplement,
    );
  }
}
