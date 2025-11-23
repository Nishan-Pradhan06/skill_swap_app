// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_setup_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileSetupEvent {

 UserProfileSetUpModel get userProfileSetUp;
/// Create a copy of ProfileSetupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileSetupEventCopyWith<ProfileSetupEvent> get copyWith => _$ProfileSetupEventCopyWithImpl<ProfileSetupEvent>(this as ProfileSetupEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSetupEvent&&(identical(other.userProfileSetUp, userProfileSetUp) || other.userProfileSetUp == userProfileSetUp));
}


@override
int get hashCode => Object.hash(runtimeType,userProfileSetUp);

@override
String toString() {
  return 'ProfileSetupEvent(userProfileSetUp: $userProfileSetUp)';
}


}

/// @nodoc
abstract mixin class $ProfileSetupEventCopyWith<$Res>  {
  factory $ProfileSetupEventCopyWith(ProfileSetupEvent value, $Res Function(ProfileSetupEvent) _then) = _$ProfileSetupEventCopyWithImpl;
@useResult
$Res call({
 UserProfileSetUpModel userProfileSetUp
});




}
/// @nodoc
class _$ProfileSetupEventCopyWithImpl<$Res>
    implements $ProfileSetupEventCopyWith<$Res> {
  _$ProfileSetupEventCopyWithImpl(this._self, this._then);

  final ProfileSetupEvent _self;
  final $Res Function(ProfileSetupEvent) _then;

/// Create a copy of ProfileSetupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userProfileSetUp = null,}) {
  return _then(_self.copyWith(
userProfileSetUp: null == userProfileSetUp ? _self.userProfileSetUp : userProfileSetUp // ignore: cast_nullable_to_non_nullable
as UserProfileSetUpModel,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileSetupEvent].
extension ProfileSetupEventPatterns on ProfileSetupEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _UserProfileSetupE value)?  userProfileSetUp,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfileSetupE() when userProfileSetUp != null:
return userProfileSetUp(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _UserProfileSetupE value)  userProfileSetUp,}){
final _that = this;
switch (_that) {
case _UserProfileSetupE():
return userProfileSetUp(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _UserProfileSetupE value)?  userProfileSetUp,}){
final _that = this;
switch (_that) {
case _UserProfileSetupE() when userProfileSetUp != null:
return userProfileSetUp(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( UserProfileSetUpModel userProfileSetUp)?  userProfileSetUp,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileSetupE() when userProfileSetUp != null:
return userProfileSetUp(_that.userProfileSetUp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( UserProfileSetUpModel userProfileSetUp)  userProfileSetUp,}) {final _that = this;
switch (_that) {
case _UserProfileSetupE():
return userProfileSetUp(_that.userProfileSetUp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( UserProfileSetUpModel userProfileSetUp)?  userProfileSetUp,}) {final _that = this;
switch (_that) {
case _UserProfileSetupE() when userProfileSetUp != null:
return userProfileSetUp(_that.userProfileSetUp);case _:
  return null;

}
}

}

/// @nodoc


class _UserProfileSetupE implements ProfileSetupEvent {
  const _UserProfileSetupE(this.userProfileSetUp);
  

@override final  UserProfileSetUpModel userProfileSetUp;

/// Create a copy of ProfileSetupEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileSetupECopyWith<_UserProfileSetupE> get copyWith => __$UserProfileSetupECopyWithImpl<_UserProfileSetupE>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileSetupE&&(identical(other.userProfileSetUp, userProfileSetUp) || other.userProfileSetUp == userProfileSetUp));
}


@override
int get hashCode => Object.hash(runtimeType,userProfileSetUp);

@override
String toString() {
  return 'ProfileSetupEvent.userProfileSetUp(userProfileSetUp: $userProfileSetUp)';
}


}

/// @nodoc
abstract mixin class _$UserProfileSetupECopyWith<$Res> implements $ProfileSetupEventCopyWith<$Res> {
  factory _$UserProfileSetupECopyWith(_UserProfileSetupE value, $Res Function(_UserProfileSetupE) _then) = __$UserProfileSetupECopyWithImpl;
@override @useResult
$Res call({
 UserProfileSetUpModel userProfileSetUp
});




}
/// @nodoc
class __$UserProfileSetupECopyWithImpl<$Res>
    implements _$UserProfileSetupECopyWith<$Res> {
  __$UserProfileSetupECopyWithImpl(this._self, this._then);

  final _UserProfileSetupE _self;
  final $Res Function(_UserProfileSetupE) _then;

/// Create a copy of ProfileSetupEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userProfileSetUp = null,}) {
  return _then(_UserProfileSetupE(
null == userProfileSetUp ? _self.userProfileSetUp : userProfileSetUp // ignore: cast_nullable_to_non_nullable
as UserProfileSetUpModel,
  ));
}


}

// dart format on
