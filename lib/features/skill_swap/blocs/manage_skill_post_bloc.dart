import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/features/skill_swap/repositories/skill_swap_repository.dart';

part 'manage_skill_post_bloc.freezed.dart';

@freezed
class ManageSkillPostEvent with _$ManageSkillPostEvent {
  const factory ManageSkillPostEvent.create({
    required String title,
    required String description,
    required int categoryId,
    required String skillOffered,
    required String skillWanted,
    required int pointsReward,
    required int pointsCost,
    Map<String, dynamic>? availability,
  }) = _Create;

  const factory ManageSkillPostEvent.update({
    required int postId,
    String? title,
    String? description,
    int? categoryId,
    String? skillOffered,
    String? skillWanted,
    int? pointsReward,
    int? pointsCost,
    Map<String, dynamic>? availability,
  }) = _Update;

  const factory ManageSkillPostEvent.delete(int postId) = _Delete;
}

@freezed
class ManageSkillPostState with _$ManageSkillPostState {
  const factory ManageSkillPostState.initial() = _Initial;
  const factory ManageSkillPostState.loading() = _Loading;
  const factory ManageSkillPostState.success(String message) = _Success;
  const factory ManageSkillPostState.failure(String message) = _Failure;
}

class ManageSkillPostBloc
    extends Bloc<ManageSkillPostEvent, ManageSkillPostState> {
  final SkillSwapRepository _repository;

  ManageSkillPostBloc({required SkillSwapRepository repository})
    : _repository = repository,
      super(const ManageSkillPostState.initial()) {
    on<_Create>(_onCreate);
    on<_Update>(_onUpdate);
    on<_Delete>(_onDelete);
  }

  Future<void> _onCreate(
    _Create event,
    Emitter<ManageSkillPostState> emit,
  ) async {
    emit(const ManageSkillPostState.loading());
    final result = await _repository.createPost(
      title: event.title,
      description: event.description,
      categoryId: event.categoryId,
      skillOffered: event.skillOffered,
      skillWanted: event.skillWanted,
      pointsReward: event.pointsReward,
      pointsCost: event.pointsCost,
      availability: event.availability,
    );
    result.fold(
      (failure) => emit(ManageSkillPostState.failure(failure.message)),
      (message) => emit(ManageSkillPostState.success(message)),
    );
  }

  Future<void> _onUpdate(
    _Update event,
    Emitter<ManageSkillPostState> emit,
  ) async {
    emit(const ManageSkillPostState.loading());
    final result = await _repository.updatePost(
      postId: event.postId,
      title: event.title,
      description: event.description,
      categoryId: event.categoryId,
      skillOffered: event.skillOffered,
      skillWanted: event.skillWanted,
      pointsReward: event.pointsReward,
      pointsCost: event.pointsCost,
      availability: event.availability,
    );
    result.fold(
      (failure) => emit(ManageSkillPostState.failure(failure.message)),
      (message) => emit(ManageSkillPostState.success(message)),
    );
  }

  Future<void> _onDelete(
    _Delete event,
    Emitter<ManageSkillPostState> emit,
  ) async {
    emit(const ManageSkillPostState.loading());
    final result = await _repository.deletePost(event.postId);
    result.fold(
      (failure) => emit(ManageSkillPostState.failure(failure.message)),
      (message) => emit(ManageSkillPostState.success(message)),
    );
  }
}
