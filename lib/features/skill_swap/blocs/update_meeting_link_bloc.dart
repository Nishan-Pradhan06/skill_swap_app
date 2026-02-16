import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_swap/features/skill_swap/repositories/skill_swap_repository.dart';
import 'update_meeting_link_event.dart';
import 'update_meeting_link_state.dart';

class UpdateMeetingLinkBloc
    extends Bloc<UpdateMeetingLinkEvent, UpdateMeetingLinkState> {
  final SkillSwapRepository _repository;

  UpdateMeetingLinkBloc({required SkillSwapRepository repository})
    : _repository = repository,
      super(const UpdateMeetingLinkState.initial()) {
    on<UpdateMeetingLinkEvent>(_onUpdate);
  }

  Future<void> _onUpdate(
    UpdateMeetingLinkEvent event,
    Emitter<UpdateMeetingLinkState> emit,
  ) async {
    emit(const UpdateMeetingLinkState.loading());

    String? skill;
    String? meetingLink;

    event.whenOrNull(
      update: (s, m) {
        skill = s;
        meetingLink = m;
      },
    );

    if (skill == null || meetingLink == null) return;

    final result = await _repository.updateMeetingLink(
      skill: skill!,
      meetingLink: meetingLink!,
    );

    result.fold(
      (failure) => emit(UpdateMeetingLinkState.failure(failure.message)),
      (message) => emit(UpdateMeetingLinkState.success(message)),
    );
  }
}
