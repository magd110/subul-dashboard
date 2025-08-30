import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/presentation/manager/create_supplier_cubit.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/presentation/manager/suppliers_cubit.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/presentation/views/widgets/suppliers_management_body.dart';
import 'package:subul_dashboard2/core/utils/service_locator.dart';

class SuppliersManagementView extends StatelessWidget {
  const SuppliersManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<SuppliersCubit>()..getSuppliers(),
        ),
        BlocProvider(
          create: (context) => getIt<CreateSupplierCubit>(), // ✅ هنا Cubit موجود
        ),
      ],
      child: SuppliersManagementBody(), // AddButton داخل هذا الـ Widget
    );
  }
}

