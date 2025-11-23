import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/core/state/bloc_base_state.dart';
import 'package:skill_swap/features/profile/model/profile_model.dart';
import 'package:skill_swap/features/profile/repository/profile_repository.dart';

part 'get_profile_event.dart';
part 'get_profile_state.dart';
part 'get_profile_bloc.freezed.dart';

class GetProfileBloc extends Bloc<GetProfileEvent, GetProfileState> {
  final ProfileRepository _profileRepository;
  GetProfileBloc({required ProfileRepository repo})
    : _profileRepository = repo,
      super(GetProfileState.initial()) {
    on<_GetProfileE>(_onGetProfile);
  }

  Future<void> _onGetProfile(
    _GetProfileE event,
    Emitter<GetProfileState> emit,
  ) async {
    emit(GetProfileState.loading());

    final result = await _profileRepository.getProfile();

    result.fold(
      (failure) => emit(GetProfileState.failure(failure)),
      (data) => emit(GetProfileState.loaded(data)),
    );
  }
}
