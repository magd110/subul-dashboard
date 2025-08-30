import 'package:equatable/equatable.dart';

class ShipmentModel extends Equatable {
  final int id;
  final String trackingNumber;
  final String type;
  final String customerName;
  final String status;
  final int declaredParcelsCount;
  final String createdAt;

  const ShipmentModel({
    required this.id,
    required this.trackingNumber,
    required this.type,
    required this.customerName,
    required this.status,
    required this.declaredParcelsCount,
    required this.createdAt,
  });

  factory ShipmentModel.fromJson(Map<String, dynamic> json) {
    return ShipmentModel(
      id: json['id'] as int? ?? 0,
      trackingNumber: json['tracking_number'] as String? ?? "",
      type: json['type'] as String? ?? "",
      customerName: json['customer_name'] as String? ?? "",
      status: json['status'] as String? ?? "",
      declaredParcelsCount: json['declared_parcels_count'] as int? ?? 0,
      createdAt: json['created_at'] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "tracking_number": trackingNumber,
        "type": type,
        "customer_name": customerName,
        "status": status,
        "declared_parcels_count": declaredParcelsCount,
        "created_at": createdAt,
      };

  @override
  List<Object?> get props => [
        id,
        trackingNumber,
        type,
        customerName,
        status,
        declaredParcelsCount,
        createdAt,
      ];
}
