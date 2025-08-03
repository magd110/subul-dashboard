import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/data/repos/get_countries_repo.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/presentation/manager/countries_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  final GetCountriesRepo _getCountriesRepo;

  CountriesCubit(this._getCountriesRepo) : super(CountriesInitial());

  Future<void> getCountries() async {
    emit(CountriesLoading());
    final result = await _getCountriesRepo.getCountries();
    result.fold(
      (failure) => emit(CountriesFailure(failure.eerMessage)),
      (countries) => emit(CountriesSuccess(countries)),
    );
  }
}
