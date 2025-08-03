import 'package:equatable/equatable.dart';

class ShipmentsByMonth extends Equatable {
  final String month;
  final int count;

  const ShipmentsByMonth({
    required this.month,
    required this.count,
  });

  factory ShipmentsByMonth.fromJson(Map<String, dynamic> json) {
    return ShipmentsByMonth(
      month: json['month'] as String,
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'month': month,
        'count': count,
      };

  @override
  List<Object?> get props => [month, count];
}

class ShipmentsByWeightRange extends Equatable {
  final String range;
  final int count;

  const ShipmentsByWeightRange({
    required this.range,
    required this.count,
  });

  factory ShipmentsByWeightRange.fromJson(Map<String, dynamic> json) {
    return ShipmentsByWeightRange(
      range: json['range'] as String,
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'range': range,
        'count': count,
      };

  @override
  List<Object?> get props => [range, count];
}

class ShipmentsByStatusPie extends Equatable {
  final String? status;
  final int count;

  const ShipmentsByStatusPie({
    required this.status,
    required this.count,
  });

  factory ShipmentsByStatusPie.fromJson(Map<String, dynamic> json) {
    return ShipmentsByStatusPie(
      status: json['status'] as String?,
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'count': count,
      };

  @override
  List<Object?> get props => [status, count];
}

class DashboardStatisticsModel extends Equatable {
  final int driversCount;
  final int shipmentsToday;
  final int shipmentsThisWeek;
  final int completedShipments;
  final List<ShipmentsByMonth> shipmentsByMonth;
  final List<ShipmentsByWeightRange> shipmentsByWeightRange;
  final List<ShipmentsByStatusPie> shipmentsByStatusPie;

  const DashboardStatisticsModel({
    required this.driversCount,
    required this.shipmentsToday,
    required this.shipmentsThisWeek,
    required this.completedShipments,
    required this.shipmentsByMonth,
    required this.shipmentsByWeightRange,
    required this.shipmentsByStatusPie,
  });

  factory DashboardStatisticsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatisticsModel(
      driversCount: json['drivers_count'] as int,
      shipmentsToday: json['shipments_today'] as int,
      shipmentsThisWeek: json['shipments_this_week'] as int,
      completedShipments: json['completed_shipments'] as int,
      shipmentsByMonth: (json['shipments_by_month'] as List<dynamic>)
          .map((e) => ShipmentsByMonth.fromJson(e))
          .toList(),
      shipmentsByWeightRange: (json['shipments_by_weight_range'] as List<dynamic>)
          .map((e) => ShipmentsByWeightRange.fromJson(e))
          .toList(),
      shipmentsByStatusPie: (json['shipments_by_status_pie'] as List<dynamic>)
          .map((e) => ShipmentsByStatusPie.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'drivers_count': driversCount,
        'shipments_today': shipmentsToday,
        'shipments_this_week': shipmentsThisWeek,
        'completed_shipments': completedShipments,
        'shipments_by_month': shipmentsByMonth.map((e) => e.toJson()).toList(),
        'shipments_by_weight_range':
            shipmentsByWeightRange.map((e) => e.toJson()).toList(),
        'shipments_by_status_pie':
            shipmentsByStatusPie.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        driversCount,
        shipmentsToday,
        shipmentsThisWeek,
        completedShipments,
        shipmentsByMonth,
        shipmentsByWeightRange,
        shipmentsByStatusPie,
      ];
}
