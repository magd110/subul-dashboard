import 'shipment_model.dart';

class ShipmentResponseModel {
  final bool? success;
  final int? status;
  final String? message;
  final List<ShipmentModel> data;

  ShipmentResponseModel({
    this.success,
    this.status,
    this.message,
    required this.data,
  });

  factory ShipmentResponseModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    List<ShipmentModel> shipments = [];

    if (rawData is List) {
      shipments = rawData
          .map((e) => ShipmentModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return ShipmentResponseModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: shipments,
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "data": data.map((e) => e.toJson()).toList(),
      };
}
