import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skill_swap/features/skill_swap/models/skill_swap_post_model.dart';
import 'package:skill_swap/features/skill_swap/repositories/skill_swap_repository.dart';

part 'get_categories_bloc.freezed.dart';

@freezed
class GetCategoriesEvent with _$GetCategoriesEvent {
  const factory GetCategoriesEvent.getCategories() = _GetCategories;
}

@freezed
class GetCategoriesState with _$GetCategoriesState {
  const factory GetCategoriesState.initial() = _Initial;
  const factory GetCategoriesState.loading() = _Loading;
  const factory GetCategoriesState.loaded(List<PostCategoryModel> categories) =
      _Loaded;
  const factory GetCategoriesState.failure(String message) = _Failure;
}

class GetCategoriesBloc extends Bloc<GetCategoriesEvent, GetCategoriesState> {
  final SkillSwapRepository _repository;

  GetCategoriesBloc({required SkillSwapRepository repository})
    : _repository = repository,
      super(const GetCategoriesState.initial()) {
    on<_GetCategories>(_onGetCategories);
  }

  Future<void> _onGetCategories(
    _GetCategories event,
    Emitter<GetCategoriesState> emit,
  ) async {
    emit(const GetCategoriesState.loading());
    final result = await _repository.getCategories();
    result.fold(
      (failure) => emit(GetCategoriesState.failure(failure.message)),
      (categories) => emit(GetCategoriesState.loaded(categories)),
    );
  }
}
