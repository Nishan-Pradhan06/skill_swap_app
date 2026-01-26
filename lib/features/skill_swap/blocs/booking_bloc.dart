import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/features/skill_swap/repositories/skill_swap_repository.dart';

part 'booking_bloc.freezed.dart';

@freezed
abstract class BookingEvent with _$BookingEvent {
  const factory BookingEvent.book({
    required int mentorId,
    required int slotId,
    required String skill,
    required int points,
    required DateTime scheduledTime,
    required int durationMinutes,
  }) = _Book;
}

@freezed
class BookingState with _$BookingState {
  const factory BookingState.initial() = _Initial;
  const factory BookingState.loading() = _Loading;
  const factory BookingState.success(String message) = _Success;
  const factory BookingState.failure(String message) = _Failure;
}

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final SkillSwapRepository _repository;

  BookingBloc({required SkillSwapRepository repository})
    : _repository = repository,
      super(const BookingState.initial()) {
    on<_Book>(_onBook);
  }

  Future<void> _onBook(_Book event, Emitter<BookingState> emit) async {
    emit(const BookingState.loading());
    final result = await _repository.bookSession(
      mentorId: event.mentorId,
      slotId: event.slotId,
      skill: event.skill,
      points: event.points,
      scheduledTime: event.scheduledTime,
      durationMinutes: event.durationMinutes,
    );
    result.fold(
      (failure) => emit(BookingState.failure(failure.message)),
      (message) => emit(BookingState.success(message)),
    );
  }
}
