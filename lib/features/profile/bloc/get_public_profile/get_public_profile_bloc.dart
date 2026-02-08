import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/core/state/bloc_base_state.dart';
import 'package:skill_swap/features/profile/model/profile_model.dart';
import 'package:skill_swap/features/profile/repository/profile_repository.dart';

part 'get_public_profile_event.dart';
part 'get_public_profile_state.dart';
part 'get_public_profile_bloc.freezed.dart';

class GetPublicProfileBloc
    extends Bloc<GetPublicProfileEvent, GetPublicProfileState> {
  final ProfileRepository _profileRepository;

  GetPublicProfileBloc({required ProfileRepository repo})
    : _profileRepository = repo,
      super(GetPublicProfileState.initial()) {
    on<_GetProfile>(_onGetProfile);
  }

  Future<void> _onGetProfile(
    _GetProfile event,
    Emitter<GetPublicProfileState> emit,
  ) async {
    emit(GetPublicProfileState.loading());

    final result = await _profileRepository.getPublicProfile(event.userId);

    result.fold(
      (failure) => emit(GetPublicProfileState.failure(failure)),
      (data) => emit(GetPublicProfileState.loaded(data)),
    );
  }
}
