import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:subul_dashboard2/Features/auth/data/repos/auth_repo.dart';
import 'package:subul_dashboard2/Features/auth/data/repos/auth_repo_impl.dart';
import 'package:subul_dashboard2/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:subul_dashboard2/Features/complaint_details_managment/data/repos/complaint_details_repo.dart';
import 'package:subul_dashboard2/Features/complaint_details_managment/data/repos/complaint_details_repo_impl.dart';
import 'package:subul_dashboard2/Features/complaint_details_managment/presentation/manager/complaint_details_cubit.dart';
import 'package:subul_dashboard2/Features/dashboard/data/repos/get_dashboard_repo_impl.dart';
import 'package:subul_dashboard2/Features/dashboard/presentation/manager/dashboard_cubit.dart';
import 'package:subul_dashboard2/Features/fixed_cost_managment/data/repos/fixed_cost_repo.dart';
import 'package:subul_dashboard2/Features/fixed_cost_managment/data/repos/fixed_cost_repo_Impl.dart';
import 'package:subul_dashboard2/Features/fixed_cost_managment/presentation/manager/fixed_cost_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/data/repos/complaints_repo.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/data/repos/complaints_repo_impl.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/presentation/manager/complaints_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/data/repos/get_countries_repo_impl.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/data/repos/delivery_staff_repo%20.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/data/repos/delivery_staff_repo_impl.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/presentation/manager/delivery_staff_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/data/repos/parcels_repo.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/data/repos/parcels_repo_impl.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/presentation/manager/parcel_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/data/repos/user_repo%20.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/data/repos/user_repo_impl.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/presentation/manager/user_cubit.dart';
import 'package:subul_dashboard2/Features/shipments/data/repos/shipment_repo.dart';
import 'package:subul_dashboard2/Features/shipments/data/repos/shipment_repo_Impl.dart';
import 'package:subul_dashboard2/Features/shipments/presentation/manager/shipment_cubit.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/data/repos/supplier_repo.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/data/repos/supplier_repo_impl.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/presentation/manager/create_supplier_cubit.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/presentation/manager/suppliers_cubit.dart';
import 'package:subul_dashboard2/core/utils/api_service.dart';

final getIt = GetIt.instance;

void setupCountriesFeatureLocator() {
  if (!getIt.isRegistered<ApiService>()) {
    getIt.registerSingleton<ApiService>(ApiService(Dio()));
  }

  getIt.registerSingleton<GetCountriesRepoImpl>(
    GetCountriesRepoImpl(getIt.get<ApiService>()),
  );
}

void setupParcelsFeatureLocator() {
  if (!getIt.isRegistered<ParcelsRepo>()) {
    getIt.registerSingleton<ParcelsRepo>(ParcelsRepoImpl(getIt<ApiService>()));
  }

  if (!getIt.isRegistered<ParcelCubit>()) {
    getIt.registerFactory<ParcelCubit>(() => ParcelCubit(getIt<ParcelsRepo>()));
  }
}

void setupDeliveryStaffLocator() {
  if (!getIt.isRegistered<ApiService>()) {
    getIt.registerSingleton<ApiService>(ApiService(Dio()));
  }

  if (!getIt.isRegistered<DeliveryStaffRepo>()) {
    getIt.registerSingleton<DeliveryStaffRepo>(
      DeliveryStaffRepoImpl(getIt<ApiService>()),
    );
  }

  if (!getIt.isRegistered<DeliveryStaffCubit>()) {
    getIt.registerFactory<DeliveryStaffCubit>(
      () => DeliveryStaffCubit(getIt<DeliveryStaffRepo>()),
    );
  }
}

void setupUserFeatureLocator() {
  if (!getIt.isRegistered<ApiService>()) {
    getIt.registerSingleton<ApiService>(ApiService(Dio()));
  }

  if (!getIt.isRegistered<UserRepo>()) {
    getIt.registerSingleton<UserRepo>(
      UserRepoImpl(getIt<ApiService>()),
    );
  }

  if (!getIt.isRegistered<UserCubit>()) {
    getIt.registerFactory<UserCubit>(
      () => UserCubit(getIt<UserRepo>()),
    );
  }
}

void setupComplaintsFeatureLocator() {
  if (!getIt.isRegistered<ComplaintsRepo>()) {
    getIt.registerSingleton<ComplaintsRepo>(
      ComplaintsRepoImpl(getIt<ApiService>()),
    );
  }

  if (!getIt.isRegistered<ComplaintsCubit>()) {
    getIt.registerFactory<ComplaintsCubit>(
      () => ComplaintsCubit(getIt<ComplaintsRepo>()),
    );
  }
}

void setupComplaintDetailsFeatureLocator() {
  if (!getIt.isRegistered<ComplaintDetailsRepo>()) {
    getIt.registerSingleton<ComplaintDetailsRepo>(
      ComplaintDetailsRepoImpl(getIt<ApiService>()),
    );
  }

  if (!getIt.isRegistered<ComplaintDetailsCubit>()) {
    getIt.registerFactory<ComplaintDetailsCubit>(
      () => ComplaintDetailsCubit(getIt<ComplaintDetailsRepo>()),
    );
  }
}

void setupAuthFeatureLocator() {
  if (!getIt.isRegistered<ApiService>()) {
    getIt.registerSingleton<ApiService>(ApiService(Dio()));
  }

  if (!getIt.isRegistered<AuthRepo>()) {
    getIt.registerSingleton<AuthRepo>(
      AuthRepoImpl(getIt<ApiService>()),
    );
  }

  if (!getIt.isRegistered<AuthCubit>()) {
    getIt.registerFactory<AuthCubit>(
      () => AuthCubit(getIt<AuthRepo>()),
    );
  }
}

void setupDashboardFeatureLocator() {
  if (!getIt.isRegistered<ApiService>()) {
    getIt.registerSingleton<ApiService>(ApiService(Dio()));
  }

  if (!getIt.isRegistered<GetDashboardRepoImpl>()) {
    getIt.registerSingleton<GetDashboardRepoImpl>(
      GetDashboardRepoImpl(getIt<ApiService>()),
    );
  }

  if (!getIt.isRegistered<DashboardCubit>()) {
    getIt.registerFactory<DashboardCubit>(
      () => DashboardCubit(getIt<GetDashboardRepoImpl>()),
    );
  }
}

void setupFixedCostFeatureLocator() {
  if (!getIt.isRegistered<ApiService>()) {
    getIt.registerSingleton<ApiService>(ApiService(Dio()));
  }

  if (!getIt.isRegistered<FixedCostRepo>()) {
    getIt.registerSingleton<FixedCostRepo>(
      FixedCostRepoImpl(getIt<ApiService>()),
    );
  }

  if (!getIt.isRegistered<FixedCostCubit>()) {
    getIt.registerFactory<FixedCostCubit>(
      () => FixedCostCubit(getIt<FixedCostRepo>()),
    );
  }
}

void setupShipmentFeatureLocator() {
  if (!getIt.isRegistered<ApiService>()) {
    getIt.registerSingleton<ApiService>(ApiService(Dio()));
  }

  if (!getIt.isRegistered<ShipmentRepo>()) {
    getIt.registerSingleton<ShipmentRepo>(
      ShipmentRepoImpl(getIt<ApiService>()),
    );
  }

  if (!getIt.isRegistered<ShipmentCubit>()) {
    getIt.registerFactory<ShipmentCubit>(
      () => ShipmentCubit(getIt<ShipmentRepo>()),
    );
  }
}

void setupSuppliersFeatureLocator() {
  if (!getIt.isRegistered<ApiService>()) {
    getIt.registerSingleton<ApiService>(ApiService(Dio()));
  }

  if (!getIt.isRegistered<SupplierRepo>()) {
    getIt.registerSingleton<SupplierRepo>(SupplierRepoImpl(getIt<ApiService>()));
  }

  if (!getIt.isRegistered<SuppliersCubit>()) {
    getIt.registerFactory<SuppliersCubit>(() => SuppliersCubit(getIt<SupplierRepo>()));
  }

  // ✅ تسجيل CreateSupplierCubit
  if (!getIt.isRegistered<CreateSupplierCubit>()) {
    getIt.registerFactory<CreateSupplierCubit>(
      () => CreateSupplierCubit(getIt<SupplierRepo>()),
    );
  }
}
