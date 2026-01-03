// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'switch_role_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SwitchRoleEvent {

 RolesModel get roles;
/// Create a copy of SwitchRoleEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SwitchRoleEventCopyWith<SwitchRoleEvent> get copyWith => _$SwitchRoleEventCopyWithImpl<SwitchRoleEvent>(this as SwitchRoleEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SwitchRoleEvent&&(identical(other.roles, roles) || other.roles == roles));
}


@override
int get hashCode => Object.hash(runtimeType,roles);

@override
String toString() {
  return 'SwitchRoleEvent(roles: $roles)';
}


}

/// @nodoc
abstract mixin class $SwitchRoleEventCopyWith<$Res>  {
  factory $SwitchRoleEventCopyWith(SwitchRoleEvent value, $Res Function(SwitchRoleEvent) _then) = _$SwitchRoleEventCopyWithImpl;
@useResult
$Res call({
 RolesModel roles
});




}
/// @nodoc
class _$SwitchRoleEventCopyWithImpl<$Res>
    implements $SwitchRoleEventCopyWith<$Res> {
  _$SwitchRoleEventCopyWithImpl(this._self, this._then);

  final SwitchRoleEvent _self;
  final $Res Function(SwitchRoleEvent) _then;

/// Create a copy of SwitchRoleEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roles = null,}) {
  return _then(_self.copyWith(
roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as RolesModel,
  ));
}

}


/// Adds pattern-matching-related methods to [SwitchRoleEvent].
extension SwitchRoleEventPatterns on SwitchRoleEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SwitchRoleE value)?  switchRole,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SwitchRoleE() when switchRole != null:
return switchRole(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SwitchRoleE value)  switchRole,}){
final _that = this;
switch (_that) {
case _SwitchRoleE():
return switchRole(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SwitchRoleE value)?  switchRole,}){
final _that = this;
switch (_that) {
case _SwitchRoleE() when switchRole != null:
return switchRole(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( RolesModel roles)?  switchRole,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SwitchRoleE() when switchRole != null:
return switchRole(_that.roles);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( RolesModel roles)  switchRole,}) {final _that = this;
switch (_that) {
case _SwitchRoleE():
return switchRole(_that.roles);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( RolesModel roles)?  switchRole,}) {final _that = this;
switch (_that) {
case _SwitchRoleE() when switchRole != null:
return switchRole(_that.roles);case _:
  return null;

}
}

}

/// @nodoc


class _SwitchRoleE implements SwitchRoleEvent {
  const _SwitchRoleE(this.roles);
  

@override final  RolesModel roles;

/// Create a copy of SwitchRoleEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SwitchRoleECopyWith<_SwitchRoleE> get copyWith => __$SwitchRoleECopyWithImpl<_SwitchRoleE>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SwitchRoleE&&(identical(other.roles, roles) || other.roles == roles));
}


@override
int get hashCode => Object.hash(runtimeType,roles);

@override
String toString() {
  return 'SwitchRoleEvent.switchRole(roles: $roles)';
}


}

/// @nodoc
abstract mixin class _$SwitchRoleECopyWith<$Res> implements $SwitchRoleEventCopyWith<$Res> {
  factory _$SwitchRoleECopyWith(_SwitchRoleE value, $Res Function(_SwitchRoleE) _then) = __$SwitchRoleECopyWithImpl;
@override @useResult
$Res call({
 RolesModel roles
});




}
/// @nodoc
class __$SwitchRoleECopyWithImpl<$Res>
    implements _$SwitchRoleECopyWith<$Res> {
  __$SwitchRoleECopyWithImpl(this._self, this._then);

  final _SwitchRoleE _self;
  final $Res Function(_SwitchRoleE) _then;

/// Create a copy of SwitchRoleEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roles = null,}) {
  return _then(_SwitchRoleE(
null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as RolesModel,
  ));
}


}

// dart format on
