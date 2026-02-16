// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_meeting_link_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UpdateMeetingLinkEvent {

 String get skill; String get meetingLink;
/// Create a copy of UpdateMeetingLinkEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateMeetingLinkEventCopyWith<UpdateMeetingLinkEvent> get copyWith => _$UpdateMeetingLinkEventCopyWithImpl<UpdateMeetingLinkEvent>(this as UpdateMeetingLinkEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateMeetingLinkEvent&&(identical(other.skill, skill) || other.skill == skill)&&(identical(other.meetingLink, meetingLink) || other.meetingLink == meetingLink));
}


@override
int get hashCode => Object.hash(runtimeType,skill,meetingLink);

@override
String toString() {
  return 'UpdateMeetingLinkEvent(skill: $skill, meetingLink: $meetingLink)';
}


}

/// @nodoc
abstract mixin class $UpdateMeetingLinkEventCopyWith<$Res>  {
  factory $UpdateMeetingLinkEventCopyWith(UpdateMeetingLinkEvent value, $Res Function(UpdateMeetingLinkEvent) _then) = _$UpdateMeetingLinkEventCopyWithImpl;
@useResult
$Res call({
 String skill, String meetingLink
});




}
/// @nodoc
class _$UpdateMeetingLinkEventCopyWithImpl<$Res>
    implements $UpdateMeetingLinkEventCopyWith<$Res> {
  _$UpdateMeetingLinkEventCopyWithImpl(this._self, this._then);

  final UpdateMeetingLinkEvent _self;
  final $Res Function(UpdateMeetingLinkEvent) _then;

/// Create a copy of UpdateMeetingLinkEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? skill = null,Object? meetingLink = null,}) {
  return _then(_self.copyWith(
skill: null == skill ? _self.skill : skill // ignore: cast_nullable_to_non_nullable
as String,meetingLink: null == meetingLink ? _self.meetingLink : meetingLink // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateMeetingLinkEvent].
extension UpdateMeetingLinkEventPatterns on UpdateMeetingLinkEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Update value)?  update,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Update() when update != null:
return update(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Update value)  update,}){
final _that = this;
switch (_that) {
case _Update():
return update(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Update value)?  update,}){
final _that = this;
switch (_that) {
case _Update() when update != null:
return update(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String skill,  String meetingLink)?  update,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Update() when update != null:
return update(_that.skill,_that.meetingLink);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String skill,  String meetingLink)  update,}) {final _that = this;
switch (_that) {
case _Update():
return update(_that.skill,_that.meetingLink);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String skill,  String meetingLink)?  update,}) {final _that = this;
switch (_that) {
case _Update() when update != null:
return update(_that.skill,_that.meetingLink);case _:
  return null;

}
}

}

/// @nodoc


class _Update implements UpdateMeetingLinkEvent {
  const _Update({required this.skill, required this.meetingLink});
  

@override final  String skill;
@override final  String meetingLink;

/// Create a copy of UpdateMeetingLinkEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateCopyWith<_Update> get copyWith => __$UpdateCopyWithImpl<_Update>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Update&&(identical(other.skill, skill) || other.skill == skill)&&(identical(other.meetingLink, meetingLink) || other.meetingLink == meetingLink));
}


@override
int get hashCode => Object.hash(runtimeType,skill,meetingLink);

@override
String toString() {
  return 'UpdateMeetingLinkEvent.update(skill: $skill, meetingLink: $meetingLink)';
}


}

/// @nodoc
abstract mixin class _$UpdateCopyWith<$Res> implements $UpdateMeetingLinkEventCopyWith<$Res> {
  factory _$UpdateCopyWith(_Update value, $Res Function(_Update) _then) = __$UpdateCopyWithImpl;
@override @useResult
$Res call({
 String skill, String meetingLink
});




}
/// @nodoc
class __$UpdateCopyWithImpl<$Res>
    implements _$UpdateCopyWith<$Res> {
  __$UpdateCopyWithImpl(this._self, this._then);

  final _Update _self;
  final $Res Function(_Update) _then;

/// Create a copy of UpdateMeetingLinkEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? skill = null,Object? meetingLink = null,}) {
  return _then(_Update(
skill: null == skill ? _self.skill : skill // ignore: cast_nullable_to_non_nullable
as String,meetingLink: null == meetingLink ? _self.meetingLink : meetingLink // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
