import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../repository/reward_repository.dart';

part 'reward_bloc.freezed.dart';

@freezed
class RewardEvent with _$RewardEvent {
  const factory RewardEvent.claimReward() = _ClaimReward;
}

@freezed
class RewardState with _$RewardState {
  const factory RewardState.initial() = _Initial;
  const factory RewardState.loading() = _Loading;
  const factory RewardState.success(String message) = _Success;
  const factory RewardState.failure(String message) = _Failure;
}

class RewardBloc extends Bloc<RewardEvent, RewardState> {
  final RewardRepository _repository;

  RewardBloc({required RewardRepository repository})
    : _repository = repository,
      super(const RewardState.initial()) {
    on<_ClaimReward>(_onClaimReward);
  }

  Future<void> _onClaimReward(
    _ClaimReward event,
    Emitter<RewardState> emit,
  ) async {
    emit(const RewardState.loading());
    final result = await _repository.dailyReward();
    result.fold(
      (failure) => emit(RewardState.failure(failure.message)),
      (message) => emit(RewardState.success(message)),
    );
  }
}
