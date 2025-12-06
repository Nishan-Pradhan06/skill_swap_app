import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/core/state/bloc_base_state.dart';
import 'package:skill_swap/features/reward/repository/reward_repository.dart';

part 'daily_reward_event.dart';
part 'daily_reward_state.dart';
part 'daily_reward_bloc.freezed.dart';

class DailyRewardBloc extends Bloc<DailyRewardEvent, DailyRewardState> {
  final RewardRepository _rewardRepository;
  DailyRewardBloc({required RewardRepository repo})
    : _rewardRepository = repo,
      super(DailyRewardState.initial()) {
    on<_DailyRewardE>(_onGetDailyReward);
  }

  Future<void> _onGetDailyReward(
    _DailyRewardE event,
    Emitter<DailyRewardState> emit,
  ) async {
    emit(DailyRewardState.loading());
    final result = await _rewardRepository.dailyReward();

    result.fold(
      (failure) => emit(DailyRewardState.failure(failure)),
      (data) => emit(DailyRewardState.loaded(data)),
    );
  }
}
