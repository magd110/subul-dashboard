import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/data/repos/get_countries_repo_impl.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/presentation/manager/countries_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/presentation/views/widgets/countries_management_body.dart';
import 'package:subul_dashboard2/core/utils/service_locator.dart';

class CountriesManagementView extends StatefulWidget {
  const CountriesManagementView({super.key});

  @override
  State<CountriesManagementView> createState() => _CountriesManagementViewState();
}

class _CountriesManagementViewState extends State<CountriesManagementView>
    with AutomaticKeepAliveClientMixin {
  
  late final CountriesCubit _countriesCubit;

  @override
  void initState() {
    super.initState();
    _countriesCubit = CountriesCubit(getIt.get<GetCountriesRepoImpl>())..getCountries();
  }

  @override
  void dispose() {
    _countriesCubit.close();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // مهم جداً للحفاظ على الحالة
    return BlocProvider.value(
      value: _countriesCubit,
      child: const CountriesManagementBody(),
    );
  }
}

