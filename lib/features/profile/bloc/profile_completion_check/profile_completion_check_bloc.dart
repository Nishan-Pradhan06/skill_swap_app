import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/core/state/bloc_base_state.dart';
import 'package:skill_swap/features/profile/model/profile_completion_model.dart';
import 'package:skill_swap/features/profile/repository/profile_repository.dart';

part 'profile_completion_check_event.dart';
part 'profile_completion_check_state.dart';
part 'profile_completion_check_bloc.freezed.dart';

class ProfileCompletionCheckBloc
    extends Bloc<ProfileCompletionCheckEvent, ProfileCompletionCheckState> {
  final ProfileRepository _profileRepository;

  ProfileCompletionCheckBloc({required ProfileRepository repo})
    : _profileRepository = repo,
      super(ProfileCompletionCheckState.initial()) {
    on<_CheckProfileCompletion>(_onCheckProfileCompletion);
  }

  Future<void> _onCheckProfileCompletion(
    _CheckProfileCompletion event,
    Emitter<ProfileCompletionCheckState> emit,
  ) async {
    emit(ProfileCompletionCheckState.loading());

    final result = await _profileRepository.checkProfileCompletion();

    result.fold(
      (failure) => emit(ProfileCompletionCheckState.failure(failure)),
      (data) => emit(ProfileCompletionCheckState.loaded(data)),
    );
  }
}
