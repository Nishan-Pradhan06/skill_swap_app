import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/features/skill_swap/repositories/skill_swap_repository.dart';

part 'get_sessions_event.dart';
part 'get_sessions_state.dart';
part 'get_sessions_bloc.freezed.dart';

class GetSessionsBloc extends Bloc<GetSessionsEvent, GetSessionsState> {
  final SkillSwapRepository _repository;

  GetSessionsBloc({required SkillSwapRepository repository})
    : _repository = repository,
      super(const GetSessionsState.initial()) {
    on<_Fetch>(_onFetch);
  }

  Future<void> _onFetch(_Fetch event, Emitter<GetSessionsState> emit) async {
    emit(const GetSessionsState.loading());
    final result = await _repository.getSessions(role: event.role);

    result.fold(
      (failure) => emit(GetSessionsState.failure(failure.message)),
      (data) => emit(GetSessionsState.success(data)),
    );
  }
}
