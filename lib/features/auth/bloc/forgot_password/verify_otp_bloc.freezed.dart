// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_otp_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VerifyOtpEvent {

 String get email; String get otp;
/// Create a copy of VerifyOtpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyOtpEventCopyWith<VerifyOtpEvent> get copyWith => _$VerifyOtpEventCopyWithImpl<VerifyOtpEvent>(this as VerifyOtpEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpEvent&&(identical(other.email, email) || other.email == email)&&(identical(other.otp, otp) || other.otp == otp));
}


@override
int get hashCode => Object.hash(runtimeType,email,otp);

@override
String toString() {
  return 'VerifyOtpEvent(email: $email, otp: $otp)';
}


}

/// @nodoc
abstract mixin class $VerifyOtpEventCopyWith<$Res>  {
  factory $VerifyOtpEventCopyWith(VerifyOtpEvent value, $Res Function(VerifyOtpEvent) _then) = _$VerifyOtpEventCopyWithImpl;
@useResult
$Res call({
 String email, String otp
});




}
/// @nodoc
class _$VerifyOtpEventCopyWithImpl<$Res>
    implements $VerifyOtpEventCopyWith<$Res> {
  _$VerifyOtpEventCopyWithImpl(this._self, this._then);

  final VerifyOtpEvent _self;
  final $Res Function(VerifyOtpEvent) _then;

/// Create a copy of VerifyOtpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? otp = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyOtpEvent].
extension VerifyOtpEventPatterns on VerifyOtpEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _VerifyOTP value)?  verifyOTP,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyOTP() when verifyOTP != null:
return verifyOTP(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _VerifyOTP value)  verifyOTP,}){
final _that = this;
switch (_that) {
case _VerifyOTP():
return verifyOTP(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _VerifyOTP value)?  verifyOTP,}){
final _that = this;
switch (_that) {
case _VerifyOTP() when verifyOTP != null:
return verifyOTP(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String email,  String otp)?  verifyOTP,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyOTP() when verifyOTP != null:
return verifyOTP(_that.email,_that.otp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String email,  String otp)  verifyOTP,}) {final _that = this;
switch (_that) {
case _VerifyOTP():
return verifyOTP(_that.email,_that.otp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String email,  String otp)?  verifyOTP,}) {final _that = this;
switch (_that) {
case _VerifyOTP() when verifyOTP != null:
return verifyOTP(_that.email,_that.otp);case _:
  return null;

}
}

}

/// @nodoc


class _VerifyOTP implements VerifyOtpEvent {
  const _VerifyOTP({required this.email, required this.otp});
  

@override final  String email;
@override final  String otp;

/// Create a copy of VerifyOtpEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyOTPCopyWith<_VerifyOTP> get copyWith => __$VerifyOTPCopyWithImpl<_VerifyOTP>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyOTP&&(identical(other.email, email) || other.email == email)&&(identical(other.otp, otp) || other.otp == otp));
}


@override
int get hashCode => Object.hash(runtimeType,email,otp);

@override
String toString() {
  return 'VerifyOtpEvent.verifyOTP(email: $email, otp: $otp)';
}


}

/// @nodoc
abstract mixin class _$VerifyOTPCopyWith<$Res> implements $VerifyOtpEventCopyWith<$Res> {
  factory _$VerifyOTPCopyWith(_VerifyOTP value, $Res Function(_VerifyOTP) _then) = __$VerifyOTPCopyWithImpl;
@override @useResult
$Res call({
 String email, String otp
});




}
/// @nodoc
class __$VerifyOTPCopyWithImpl<$Res>
    implements _$VerifyOTPCopyWith<$Res> {
  __$VerifyOTPCopyWithImpl(this._self, this._then);

  final _VerifyOTP _self;
  final $Res Function(_VerifyOTP) _then;

/// Create a copy of VerifyOtpEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? otp = null,}) {
  return _then(_VerifyOTP(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
