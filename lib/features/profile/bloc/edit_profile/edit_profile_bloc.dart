import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/features/profile/repository/profile_repository.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';
part 'edit_profile_bloc.freezed.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final ProfileRepository _repository;

  EditProfileBloc({required ProfileRepository repository})
    : _repository = repository,
      super(const EditProfileState.initial()) {
    on<_Submit>(_onSubmit);
  }

  Future<void> _onSubmit(_Submit event, Emitter<EditProfileState> emit) async {
    emit(const EditProfileState.loading());
    final result = await _repository.updateProfile(
      data: event.data,
      profileImagePath: event.profileImagePath,
      bannerImagePath: event.bannerImagePath,
    );
    result.fold(
      (failure) => emit(EditProfileState.failure(failure.message)),
      (message) => emit(EditProfileState.success(message)),
    );
  }
}
