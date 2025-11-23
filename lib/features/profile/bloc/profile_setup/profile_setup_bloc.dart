import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/core/state/bloc_base_state.dart';
import 'package:skill_swap/features/profile/model/profile_setup_model.dart';
import 'package:skill_swap/features/profile/repository/profile_repository.dart';

part 'profile_setup_event.dart';
part 'profile_setup_state.dart';
part 'profile_setup_bloc.freezed.dart';

class ProfileSetupBloc extends Bloc<ProfileSetupEvent, ProfileSetupState> {
  final ProfileRepository _profileRepository;
  ProfileSetupBloc({required ProfileRepository repo})
    : _profileRepository = repo,
      super(ProfileSetupState.initial()) {
    on<_UserProfileSetupE>(_onUserProfileSetUp);
  }

  Future<void> _onUserProfileSetUp(
    _UserProfileSetupE event,
    Emitter<ProfileSetupState> emit,
  ) async {
    emit(ProfileSetupState.loading());

    final result = await _profileRepository.setUpProfile(
      profileSetUpModel: event.userProfileSetUp,
    );

    result.fold(
      (failure) => emit(ProfileSetupState.failure(failure)),
      (data) => emit(ProfileSetupState.loaded(data)),
    );
  }
}
