
import 'package:equatable/equatable.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/data/models/country_model.dart';

sealed class CountryCreateState extends Equatable {
  const CountryCreateState();

  @override
  List<Object?> get props => [];
}

final class CountryCreateInitial extends CountryCreateState {}

final class CountryCreateLoading extends CountryCreateState {}

final class CountryCreateFailure extends CountryCreateState {
  final String errorMessage;

  const CountryCreateFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

final class CountryCreateSuccess extends CountryCreateState {
  final CountryModel country;

  const CountryCreateSuccess(this.country);

  @override
  List<Object?> get props => [country];
}
