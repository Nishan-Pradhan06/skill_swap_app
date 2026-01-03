part of 'switch_role_bloc.dart';

@freezed
abstract class SwitchRoleEvent with _$SwitchRoleEvent {
  const factory SwitchRoleEvent.switchRole(RolesModel roles) = _SwitchRoleE;
}