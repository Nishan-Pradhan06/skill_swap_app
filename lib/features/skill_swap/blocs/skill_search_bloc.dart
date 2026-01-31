import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/features/skill_swap/models/skill_swap_post_model.dart';
import 'package:skill_swap/features/skill_swap/repositories/skill_swap_repository.dart';

part 'skill_search_bloc.freezed.dart';

@freezed
sealed class SkillSearchEvent with _$SkillSearchEvent {
  const factory SkillSearchEvent.searchQueryChanged(String query) =
      _SearchQueryChanged;
}

@freezed
class SkillSearchState with _$SkillSearchState {
  const factory SkillSearchState.initial() = _Initial;
  const factory SkillSearchState.loading() = _Loading;
  const factory SkillSearchState.loaded(List<SkillSwapPostModel> posts) =
      _Loaded;
  const factory SkillSearchState.failure(String message) = _Failure;
}

class SkillSearchBloc extends Bloc<SkillSearchEvent, SkillSearchState> {
  final SkillSwapRepository _repository;

  SkillSearchBloc({required SkillSwapRepository repository})
    : _repository = repository,
      super(const SkillSearchState.initial()) {
    on<_SearchQueryChanged>(_onSearchQueryChanged);
  }

  Future<void> _onSearchQueryChanged(
    _SearchQueryChanged event,
    Emitter<SkillSearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(const SkillSearchState.initial());
      return;
    }

    emit(const SkillSearchState.loading());
    final result = await _repository.searchSkillSwapPosts(event.query);
    result.fold(
      (failure) => emit(SkillSearchState.failure(failure.message)),
      (posts) => emit(SkillSearchState.loaded(posts)),
    );
  }
}
