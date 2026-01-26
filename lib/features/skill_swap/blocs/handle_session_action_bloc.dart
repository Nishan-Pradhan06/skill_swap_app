import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/features/skill_swap/repositories/skill_swap_repository.dart';

part 'handle_session_action_event.dart';
part 'handle_session_action_state.dart';
part 'handle_session_action_bloc.freezed.dart';

class HandleSessionActionBloc
    extends Bloc<HandleSessionActionEvent, HandleSessionActionState> {
  final SkillSwapRepository _repository;

  HandleSessionActionBloc({required SkillSwapRepository repository})
    : _repository = repository,
      super(const HandleSessionActionState.initial()) {
    on<_PerformAction>(_onPerformAction);
  }

  Future<void> _onPerformAction(
    _PerformAction event,
    Emitter<HandleSessionActionState> emit,
  ) async {
    emit(const HandleSessionActionState.loading());
    final result = await _repository.sessionAction(
      sessionId: event.sessionId,
      action: event.action,
    );

    result.fold(
      (failure) => emit(HandleSessionActionState.failure(failure.message)),
      (message) => emit(HandleSessionActionState.success(message)),
    );
  }
}
