import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/bloc_base_state.dart';
import '../../repository/device_register_repository.dart';

part 'device_register_event.dart';
part 'device_register_state.dart';
part 'device_register_bloc.freezed.dart';

class DeviceRegisterBloc
    extends Bloc<DeviceRegisterEvent, DeviceRegisterState> {
  final DeviceRegisterForPushNotificationRepository
  _deviceRegisterForPushNotificationRepository;
  DeviceRegisterBloc({
    required DeviceRegisterForPushNotificationRepository repo,
  }) : _deviceRegisterForPushNotificationRepository = repo,
       super(DeviceRegisterState.initial()) {
    on<_DeviceRegister>(_onDeviceRegister);
  }

  Future<void> _onDeviceRegister(
    _DeviceRegister event,
    Emitter<DeviceRegisterState> emit,
  ) async {
    emit(DeviceRegisterState.loading());

    final result = await _deviceRegisterForPushNotificationRepository
        .deviceRegister();

    result.fold(
      (failure) => emit(DeviceRegisterState.failure(failure)),
      (data) => emit(DeviceRegisterState.loaded(data)),
    );
  }
}
