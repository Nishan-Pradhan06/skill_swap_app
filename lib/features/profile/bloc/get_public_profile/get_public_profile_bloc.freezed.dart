// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_public_profile_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GetPublicProfileEvent {

 int get userId;
/// Create a copy of GetPublicProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetPublicProfileEventCopyWith<GetPublicProfileEvent> get copyWith => _$GetPublicProfileEventCopyWithImpl<GetPublicProfileEvent>(this as GetPublicProfileEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetPublicProfileEvent&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'GetPublicProfileEvent(userId: $userId)';
}


}

/// @nodoc
abstract mixin class $GetPublicProfileEventCopyWith<$Res>  {
  factory $GetPublicProfileEventCopyWith(GetPublicProfileEvent value, $Res Function(GetPublicProfileEvent) _then) = _$GetPublicProfileEventCopyWithImpl;
@useResult
$Res call({
 int userId
});




}
/// @nodoc
class _$GetPublicProfileEventCopyWithImpl<$Res>
    implements $GetPublicProfileEventCopyWith<$Res> {
  _$GetPublicProfileEventCopyWithImpl(this._self, this._then);

  final GetPublicProfileEvent _self;
  final $Res Function(GetPublicProfileEvent) _then;

/// Create a copy of GetPublicProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GetPublicProfileEvent].
extension GetPublicProfileEventPatterns on GetPublicProfileEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _GetProfile value)?  getProfile,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetProfile() when getProfile != null:
return getProfile(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _GetProfile value)  getProfile,}){
final _that = this;
switch (_that) {
case _GetProfile():
return getProfile(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _GetProfile value)?  getProfile,}){
final _that = this;
switch (_that) {
case _GetProfile() when getProfile != null:
return getProfile(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int userId)?  getProfile,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetProfile() when getProfile != null:
return getProfile(_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int userId)  getProfile,}) {final _that = this;
switch (_that) {
case _GetProfile():
return getProfile(_that.userId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int userId)?  getProfile,}) {final _that = this;
switch (_that) {
case _GetProfile() when getProfile != null:
return getProfile(_that.userId);case _:
  return null;

}
}

}

/// @nodoc


class _GetProfile implements GetPublicProfileEvent {
  const _GetProfile(this.userId);
  

@override final  int userId;

/// Create a copy of GetPublicProfileEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetProfileCopyWith<_GetProfile> get copyWith => __$GetProfileCopyWithImpl<_GetProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetProfile&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'GetPublicProfileEvent.getProfile(userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$GetProfileCopyWith<$Res> implements $GetPublicProfileEventCopyWith<$Res> {
  factory _$GetProfileCopyWith(_GetProfile value, $Res Function(_GetProfile) _then) = __$GetProfileCopyWithImpl;
@override @useResult
$Res call({
 int userId
});




}
/// @nodoc
class __$GetProfileCopyWithImpl<$Res>
    implements _$GetProfileCopyWith<$Res> {
  __$GetProfileCopyWithImpl(this._self, this._then);

  final _GetProfile _self;
  final $Res Function(_GetProfile) _then;

/// Create a copy of GetPublicProfileEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,}) {
  return _then(_GetProfile(
null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
