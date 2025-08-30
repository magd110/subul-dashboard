part of 'fixed_cost_cubit.dart';

sealed class FixedCostState extends Equatable {
  const FixedCostState();

  @override
  List<Object?> get props => [];
}

final class FixedCostInitial extends FixedCostState {}
final class FixedCostLoading extends FixedCostState {}
final class FixedCostFailure extends FixedCostState {
  final String errorMessage;
  const FixedCostFailure(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}
final class FixedCostSuccess extends FixedCostState {
  final List<FixedCostModel> fixedCosts;
  const FixedCostSuccess(this.fixedCosts);
  @override
  List<Object?> get props => [fixedCosts];
}
final class FixedCostOperationSuccess extends FixedCostState {
  final String message;
  const FixedCostOperationSuccess(this.message);
  @override
  List<Object?> get props => [message];
}
