import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/features/skill_swap/models/skill_swap_post_model.dart';
import 'package:skill_swap/features/skill_swap/repositories/skill_swap_repository.dart';

part 'get_mentor_posts_bloc.freezed.dart';

@freezed
class GetMentorPostsEvent with _$GetMentorPostsEvent {
  const factory GetMentorPostsEvent.getPosts() = _GetPosts;
}

@freezed
class GetMentorPostsState with _$GetMentorPostsState {
  const factory GetMentorPostsState.initial() = _Initial;
  const factory GetMentorPostsState.loading() = _Loading;
  const factory GetMentorPostsState.loaded(List<SkillSwapPostModel> posts) =
      _Loaded;
  const factory GetMentorPostsState.failure(String message) = _Failure;
}

class GetMentorPostsBloc
    extends Bloc<GetMentorPostsEvent, GetMentorPostsState> {
  final SkillSwapRepository _repository;

  GetMentorPostsBloc({required SkillSwapRepository repository})
    : _repository = repository,
      super(const GetMentorPostsState.initial()) {
    on<_GetPosts>(_onGetPosts);
  }

  Future<void> _onGetPosts(
    _GetPosts event,
    Emitter<GetMentorPostsState> emit,
  ) async {
    emit(const GetMentorPostsState.loading());
    final result = await _repository.getMentorPosts();
    result.fold(
      (failure) => emit(GetMentorPostsState.failure(failure.message)),
      (posts) => emit(GetMentorPostsState.loaded(posts)),
    );
  }
}
