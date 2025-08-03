import 'package:equatable/equatable.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/data/models/country_model.dart';

sealed class CountriesState extends Equatable {
  const CountriesState();

  @override
  List<Object?> get props => [];
}

final class CountriesInitial extends CountriesState {}

final class CountriesLoading extends CountriesState {}

final class CountriesFailure extends CountriesState {
  final String errorMessage;

  const CountriesFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

final class CountriesSuccess extends CountriesState {
  final List<CountryModel> countries;

  const CountriesSuccess(this.countries);

  @override
  List<Object?> get props => [countries];
}
