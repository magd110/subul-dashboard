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
import 'package:subul_dashboard2/core/utils/api_service.dart';

final getIt = GetIt.instance;

void setupCountriesFeatureLocator() {
  // 1. سجل ApiService (لو لم يكن مسجلاً سابقًا)
  if (!getIt.isRegistered<ApiService>()) {
    getIt.registerSingleton<ApiService>(ApiService(Dio()));
  }

  // 2. سجل الريبو الخاص بCountries
  getIt.registerSingleton<GetCountriesRepoImpl>(
    GetCountriesRepoImpl(getIt.get<ApiService>()),
  );
}

void setupParcelsFeatureLocator() {
  // 1. تسجيل ParcelRepo (لو لم يكن مسجلاً)
  if (!getIt.isRegistered<ParcelsRepo>()) {
    getIt.registerSingleton<ParcelsRepo>(ParcelsRepoImpl(getIt<ApiService>()));
  }

  // 2. تسجيل ParcelCubit
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
  // أولاً: تأكد أن ApiService موجود
  if (!getIt.isRegistered<ApiService>()) {
    getIt.registerSingleton<ApiService>(ApiService(Dio()));
  }

  // ثانياً: سجل UserRepo إذا لم يكن مسجلاً
  if (!getIt.isRegistered<UserRepo>()) {
    getIt.registerSingleton<UserRepo>(
      UserRepoImpl(getIt<ApiService>()),
    );
  }

  // ثالثاً: سجل UserCubit
  if (!getIt.isRegistered<UserCubit>()) {
    getIt.registerFactory<UserCubit>(
      () => UserCubit(getIt<UserRepo>()),
    );
  }
}

void setupComplaintsFeatureLocator() {
  // ✅ سجل ComplaintsRepo
  if (!getIt.isRegistered<ComplaintsRepo>()) {
    getIt.registerSingleton<ComplaintsRepo>(
      ComplaintsRepoImpl(getIt<ApiService>()),
    );
  }

  // ✅ سجل ComplaintsCubit
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
  // تأكد من تسجيل ApiService
  if (!getIt.isRegistered<ApiService>()) {
    getIt.registerSingleton<ApiService>(ApiService(Dio()));
  }

  // سجل AuthRepo إذا كان لديك AuthRepo
  if (!getIt.isRegistered<AuthRepo>()) {
    getIt.registerSingleton<AuthRepo>(
      AuthRepoImpl(getIt<ApiService>()),
    );
  }

  // سجل AuthCubit
  if (!getIt.isRegistered<AuthCubit>()) {
    getIt.registerFactory<AuthCubit>(
      () => AuthCubit(getIt<AuthRepo>()),
    );
  }
}

void setupDashboardFeatureLocator() {
  // 1. تأكد من أن ApiService مسجل
  if (!getIt.isRegistered<ApiService>()) {
    getIt.registerSingleton<ApiService>(ApiService(Dio()));
  }

  // 2. سجل DashboardRepoImpl
  if (!getIt.isRegistered<GetDashboardRepoImpl>()) {
    getIt.registerSingleton<GetDashboardRepoImpl>(
      GetDashboardRepoImpl(getIt<ApiService>()),
    );
  }

  // 3. سجل DashboardCubit
  if (!getIt.isRegistered<DashboardCubit>()) {
    getIt.registerFactory<DashboardCubit>(
      () => DashboardCubit(getIt<GetDashboardRepoImpl>()),
    );
  }
}

