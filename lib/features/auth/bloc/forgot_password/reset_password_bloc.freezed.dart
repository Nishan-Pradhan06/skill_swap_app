// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reset_password_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ResetPasswordEvent {

 String get email; String get code; String get newPassword; String get confirmPassword;
/// Create a copy of ResetPasswordEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordEventCopyWith<ResetPasswordEvent> get copyWith => _$ResetPasswordEventCopyWithImpl<ResetPasswordEvent>(this as ResetPasswordEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordEvent&&(identical(other.email, email) || other.email == email)&&(identical(other.code, code) || other.code == code)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword));
}


@override
int get hashCode => Object.hash(runtimeType,email,code,newPassword,confirmPassword);

@override
String toString() {
  return 'ResetPasswordEvent(email: $email, code: $code, newPassword: $newPassword, confirmPassword: $confirmPassword)';
}


}

/// @nodoc
abstract mixin class $ResetPasswordEventCopyWith<$Res>  {
  factory $ResetPasswordEventCopyWith(ResetPasswordEvent value, $Res Function(ResetPasswordEvent) _then) = _$ResetPasswordEventCopyWithImpl;
@useResult
$Res call({
 String email, String code, String newPassword, String confirmPassword
});




}
/// @nodoc
class _$ResetPasswordEventCopyWithImpl<$Res>
    implements $ResetPasswordEventCopyWith<$Res> {
  _$ResetPasswordEventCopyWithImpl(this._self, this._then);

  final ResetPasswordEvent _self;
  final $Res Function(ResetPasswordEvent) _then;

/// Create a copy of ResetPasswordEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? code = null,Object? newPassword = null,Object? confirmPassword = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ResetPasswordEvent].
extension ResetPasswordEventPatterns on ResetPasswordEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Reset value)  reset,}){
final _that = this;
switch (_that) {
case _Reset():
return reset(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Reset value)?  reset,}){
final _that = this;
switch (_that) {
case _Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String email,  String code,  String newPassword,  String confirmPassword)?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Reset() when reset != null:
return reset(_that.email,_that.code,_that.newPassword,_that.confirmPassword);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String email,  String code,  String newPassword,  String confirmPassword)  reset,}) {final _that = this;
switch (_that) {
case _Reset():
return reset(_that.email,_that.code,_that.newPassword,_that.confirmPassword);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String email,  String code,  String newPassword,  String confirmPassword)?  reset,}) {final _that = this;
switch (_that) {
case _Reset() when reset != null:
return reset(_that.email,_that.code,_that.newPassword,_that.confirmPassword);case _:
  return null;

}
}

}

/// @nodoc


class _Reset implements ResetPasswordEvent {
  const _Reset({required this.email, required this.code, required this.newPassword, required this.confirmPassword});
  

@override final  String email;
@override final  String code;
@override final  String newPassword;
@override final  String confirmPassword;

/// Create a copy of ResetPasswordEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResetCopyWith<_Reset> get copyWith => __$ResetCopyWithImpl<_Reset>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reset&&(identical(other.email, email) || other.email == email)&&(identical(other.code, code) || other.code == code)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword));
}


@override
int get hashCode => Object.hash(runtimeType,email,code,newPassword,confirmPassword);

@override
String toString() {
  return 'ResetPasswordEvent.reset(email: $email, code: $code, newPassword: $newPassword, confirmPassword: $confirmPassword)';
}


}

/// @nodoc
abstract mixin class _$ResetCopyWith<$Res> implements $ResetPasswordEventCopyWith<$Res> {
  factory _$ResetCopyWith(_Reset value, $Res Function(_Reset) _then) = __$ResetCopyWithImpl;
@override @useResult
$Res call({
 String email, String code, String newPassword, String confirmPassword
});




}
/// @nodoc
class __$ResetCopyWithImpl<$Res>
    implements _$ResetCopyWith<$Res> {
  __$ResetCopyWithImpl(this._self, this._then);

  final _Reset _self;
  final $Res Function(_Reset) _then;

/// Create a copy of ResetPasswordEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? code = null,Object? newPassword = null,Object? confirmPassword = null,}) {
  return _then(_Reset(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
