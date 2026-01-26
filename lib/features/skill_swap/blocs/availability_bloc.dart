import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/features/skill_swap/models/availability_slot_model.dart';
import 'package:skill_swap/features/skill_swap/repositories/skill_swap_repository.dart';

part 'availability_bloc.freezed.dart';

@freezed
abstract class AvailabilityEvent with _$AvailabilityEvent {
  const factory AvailabilityEvent.load({int? mentorId, int? postId}) = _Load;
  const factory AvailabilityEvent.set({
    required DateTime startTime,
    required DateTime endTime,
    required int durationMinutes,
    int? postId,
  }) = _Set;
}

@freezed
class AvailabilityState with _$AvailabilityState {
  const factory AvailabilityState.initial() = _Initial;
  const factory AvailabilityState.loading() = _Loading;
  const factory AvailabilityState.loaded(List<AvailabilitySlotModel> slots) =
      _Loaded;
  const factory AvailabilityState.success(String message) =
      _Success; // for Set action
  const factory AvailabilityState.failure(String message) = _Failure;
}

class AvailabilityBloc extends Bloc<AvailabilityEvent, AvailabilityState> {
  final SkillSwapRepository _repository;

  AvailabilityBloc({required SkillSwapRepository repository})
    : _repository = repository,
      super(const AvailabilityState.initial()) {
    on<_Load>(_onLoad);
    on<_Set>(_onSet);
  }

  Future<void> _onLoad(_Load event, Emitter<AvailabilityState> emit) async {
    emit(const AvailabilityState.loading());
    final result = await _repository.getAvailability(
      mentorId: event.mentorId,
      postId: event.postId,
    );
    result.fold(
      (failure) => emit(AvailabilityState.failure(failure.message)),
      (slots) => emit(AvailabilityState.loaded(slots)),
    );
  }

  Future<void> _onSet(_Set event, Emitter<AvailabilityState> emit) async {
    emit(const AvailabilityState.loading());
    final result = await _repository.setAvailability(
      startTime: event.startTime,
      endTime: event.endTime,
      durationMinutes: event.durationMinutes,
      postId: event.postId,
    );
    result.fold((failure) => emit(AvailabilityState.failure(failure.message)), (
      message,
    ) {
      emit(AvailabilityState.success(message));
      add(AvailabilityEvent.load(postId: event.postId)); // Reload after setting
    });
  }
}
