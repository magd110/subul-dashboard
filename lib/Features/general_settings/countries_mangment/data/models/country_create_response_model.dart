import 'package:subul_dashboard2/Features/general_settings/countries_mangment/data/models/country_model.dart';

class CountryCreateResponseModel {
  final bool? success;
  final int? status;
  final String? message;
  final CountryModel? data;

  CountryCreateResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory CountryCreateResponseModel.fromJson(Map<String, dynamic> json) {
    return CountryCreateResponseModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? CountryModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}
