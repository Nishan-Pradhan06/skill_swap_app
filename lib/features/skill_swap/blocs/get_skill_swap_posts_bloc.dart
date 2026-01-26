import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/features/skill_swap/models/skill_swap_post_model.dart';
import 'package:skill_swap/features/skill_swap/repositories/skill_swap_repository.dart';

part 'get_skill_swap_posts_bloc.freezed.dart';

@freezed
class GetSkillSwapPostsEvent with _$GetSkillSwapPostsEvent {
  const factory GetSkillSwapPostsEvent.getPosts() = _GetPosts;
}

@freezed
class GetSkillSwapPostsState with _$GetSkillSwapPostsState {
  const factory GetSkillSwapPostsState.initial() = _Initial;
  const factory GetSkillSwapPostsState.loading() = _Loading;
  const factory GetSkillSwapPostsState.loaded(List<SkillSwapPostModel> posts) =
      _Loaded;
  const factory GetSkillSwapPostsState.failure(String message) = _Failure;
}

class GetSkillSwapPostsBloc
    extends Bloc<GetSkillSwapPostsEvent, GetSkillSwapPostsState> {
  final SkillSwapRepository _repository;

  GetSkillSwapPostsBloc({required SkillSwapRepository repository})
    : _repository = repository,
      super(const GetSkillSwapPostsState.initial()) {
    on<_GetPosts>(_onGetPosts);
  }

  Future<void> _onGetPosts(
    _GetPosts event,
    Emitter<GetSkillSwapPostsState> emit,
  ) async {
    emit(const GetSkillSwapPostsState.loading());
    final result = await _repository.getSkillSwapPosts();
    result.fold(
      (failure) => emit(GetSkillSwapPostsState.failure(failure.message)),
      (posts) => emit(GetSkillSwapPostsState.loaded(posts)),
    );
  }
}
