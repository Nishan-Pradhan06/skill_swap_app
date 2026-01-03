import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/core/state/bloc_base_state.dart';
import 'package:skill_swap/features/profile/model/roles_model.dart';
import 'package:skill_swap/features/profile/repository/profile_repository.dart';

part 'switch_role_event.dart';
part 'switch_role_state.dart';
part 'switch_role_bloc.freezed.dart';

class SwitchRoleBloc extends Bloc<SwitchRoleEvent, SwitchRoleState> {
  final ProfileRepository _profileRepository;
  SwitchRoleBloc({required ProfileRepository repo})
    : _profileRepository = repo,
      super(SwitchRoleState.initial()) {
    on<_SwitchRoleE>(_onSwitchRole);
  }

  Future<void> _onSwitchRole(
    _SwitchRoleE event,
    Emitter<SwitchRoleState> emit,
  ) async {
    emit(SwitchRoleState.loading());

    final result = await _profileRepository.switchRole(roles: event.roles);

    result.fold(
      (failure) => emit(SwitchRoleState.failure(failure)),
      (data) => emit(SwitchRoleState.loaded(data)),
    );
  }
}
