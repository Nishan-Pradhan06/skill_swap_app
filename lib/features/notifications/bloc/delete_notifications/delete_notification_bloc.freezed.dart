// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_notification_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeleteNotificationEvent {

 int get notificationId;
/// Create a copy of DeleteNotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteNotificationEventCopyWith<DeleteNotificationEvent> get copyWith => _$DeleteNotificationEventCopyWithImpl<DeleteNotificationEvent>(this as DeleteNotificationEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteNotificationEvent&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId));
}


@override
int get hashCode => Object.hash(runtimeType,notificationId);

@override
String toString() {
  return 'DeleteNotificationEvent(notificationId: $notificationId)';
}


}

/// @nodoc
abstract mixin class $DeleteNotificationEventCopyWith<$Res>  {
  factory $DeleteNotificationEventCopyWith(DeleteNotificationEvent value, $Res Function(DeleteNotificationEvent) _then) = _$DeleteNotificationEventCopyWithImpl;
@useResult
$Res call({
 int notificationId
});




}
/// @nodoc
class _$DeleteNotificationEventCopyWithImpl<$Res>
    implements $DeleteNotificationEventCopyWith<$Res> {
  _$DeleteNotificationEventCopyWithImpl(this._self, this._then);

  final DeleteNotificationEvent _self;
  final $Res Function(DeleteNotificationEvent) _then;

/// Create a copy of DeleteNotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notificationId = null,}) {
  return _then(_self.copyWith(
notificationId: null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DeleteNotificationEvent].
extension DeleteNotificationEventPatterns on DeleteNotificationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _DeleteNotificationE value)?  deleteNotification,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeleteNotificationE() when deleteNotification != null:
return deleteNotification(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _DeleteNotificationE value)  deleteNotification,}){
final _that = this;
switch (_that) {
case _DeleteNotificationE():
return deleteNotification(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _DeleteNotificationE value)?  deleteNotification,}){
final _that = this;
switch (_that) {
case _DeleteNotificationE() when deleteNotification != null:
return deleteNotification(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int notificationId)?  deleteNotification,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeleteNotificationE() when deleteNotification != null:
return deleteNotification(_that.notificationId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int notificationId)  deleteNotification,}) {final _that = this;
switch (_that) {
case _DeleteNotificationE():
return deleteNotification(_that.notificationId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int notificationId)?  deleteNotification,}) {final _that = this;
switch (_that) {
case _DeleteNotificationE() when deleteNotification != null:
return deleteNotification(_that.notificationId);case _:
  return null;

}
}

}

/// @nodoc


class _DeleteNotificationE implements DeleteNotificationEvent {
  const _DeleteNotificationE({required this.notificationId});
  

@override final  int notificationId;

/// Create a copy of DeleteNotificationEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteNotificationECopyWith<_DeleteNotificationE> get copyWith => __$DeleteNotificationECopyWithImpl<_DeleteNotificationE>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteNotificationE&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId));
}


@override
int get hashCode => Object.hash(runtimeType,notificationId);

@override
String toString() {
  return 'DeleteNotificationEvent.deleteNotification(notificationId: $notificationId)';
}


}

/// @nodoc
abstract mixin class _$DeleteNotificationECopyWith<$Res> implements $DeleteNotificationEventCopyWith<$Res> {
  factory _$DeleteNotificationECopyWith(_DeleteNotificationE value, $Res Function(_DeleteNotificationE) _then) = __$DeleteNotificationECopyWithImpl;
@override @useResult
$Res call({
 int notificationId
});




}
/// @nodoc
class __$DeleteNotificationECopyWithImpl<$Res>
    implements _$DeleteNotificationECopyWith<$Res> {
  __$DeleteNotificationECopyWithImpl(this._self, this._then);

  final _DeleteNotificationE _self;
  final $Res Function(_DeleteNotificationE) _then;

/// Create a copy of DeleteNotificationEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notificationId = null,}) {
  return _then(_DeleteNotificationE(
notificationId: null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
