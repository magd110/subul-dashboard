import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/data/repos/get_countries_repo_impl.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/presentation/manager/countries_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/presentation/views/widgets/countries_management_body.dart';
import 'package:subul_dashboard2/core/utils/service_locator.dart';

class CountriesManagementView extends StatelessWidget {
  const CountriesManagementView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CountriesCubit(getIt.get<GetCountriesRepoImpl>())..getCountries(),
      child: const CountriesManagementBody(),
    );
  }
}
