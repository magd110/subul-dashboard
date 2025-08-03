import 'package:subul_dashboard2/Features/general_settings/countries_mangment/data/models/country_model.dart';

class CountryResponseModel {
  final bool? success;
  final int? status;
  final String? message;
  final List<CountryModel>? data;

  CountryResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory CountryResponseModel.fromJson(Map<String, dynamic> json) {
    return CountryResponseModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CountryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
