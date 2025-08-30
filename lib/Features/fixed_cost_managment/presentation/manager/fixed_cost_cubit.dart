import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:subul_dashboard2/Features/fixed_cost_managment/data/models/fixed_cost_model.dart';
import 'package:subul_dashboard2/Features/fixed_cost_managment/data/repos/fixed_cost_repo.dart';

part 'fixed_cost_state.dart';

class FixedCostCubit extends Cubit<FixedCostState> {
  final FixedCostRepo _repo;

  FixedCostCubit(this._repo) : super(FixedCostInitial());

  Future<void> fetchFixedCosts() async {
  emit(FixedCostLoading());
  print("🚀 Starting fetchFixedCosts...");

  final result = await _repo.getFixedCosts();
  
  result.fold(
    (failure) {
      print("❌ Error in fetchFixedCosts: ${failure.eerMessage}");
      emit(FixedCostFailure(failure.eerMessage));
    },
    (fixedCosts) {
      print("✅ fetchFixedCosts successful");
      print("📦 Count: ${fixedCosts.length}");
      for (var cost in fixedCosts) {
        print("   - ID: ${cost.id}, Name: ${cost.name}, Value: ${cost.value}, Active: ${cost.isActive}");
      }
      emit(FixedCostSuccess(fixedCosts));
    },
  );
}


 Future<void> updateFixedCost({
  required int id,
  required String value,
}) async {
  emit(FixedCostLoading());
  final result = await _repo.updateFixedCost(
    id,
    value: value,
  );

  result.fold(
    (failure) => emit(FixedCostFailure(failure.eerMessage)),
    (response) async {
      await fetchFixedCosts();
      
      print("✅ Fixed cost updated successfully");
    },
  );
}

}
