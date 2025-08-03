import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/data/repos/get_countries_repo.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/presentation/manager/country_create_state.dart';

class CountryCreateCubit extends Cubit<CountryCreateState> {
  final GetCountriesRepo _repo;

  CountryCreateCubit(this._repo) : super(CountryCreateInitial());

  Future<void> createCountry({
    required String name,
    required String code,
  }) async {
    print(21);
    emit(CountryCreateLoading());
    print(22);

    final result = await _repo.createCountry(name: name, code: code);
    print(23);
    print("____");
    print(result);
    print(24);
    result.fold(
      (failure) {
        print('Failure: ${failure.eerMessage}');

        emit(CountryCreateFailure(failure.eerMessage));
      },
      (country) => emit(CountryCreateSuccess(country)),
    );
  }
}
