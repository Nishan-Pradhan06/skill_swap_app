// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignUpEvent {

 SignUpModel get signUpModel;
/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpEventCopyWith<SignUpEvent> get copyWith => _$SignUpEventCopyWithImpl<SignUpEvent>(this as SignUpEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpEvent&&(identical(other.signUpModel, signUpModel) || other.signUpModel == signUpModel));
}


@override
int get hashCode => Object.hash(runtimeType,signUpModel);

@override
String toString() {
  return 'SignUpEvent(signUpModel: $signUpModel)';
}


}

/// @nodoc
abstract mixin class $SignUpEventCopyWith<$Res>  {
  factory $SignUpEventCopyWith(SignUpEvent value, $Res Function(SignUpEvent) _then) = _$SignUpEventCopyWithImpl;
@useResult
$Res call({
 SignUpModel signUpModel
});




}
/// @nodoc
class _$SignUpEventCopyWithImpl<$Res>
    implements $SignUpEventCopyWith<$Res> {
  _$SignUpEventCopyWithImpl(this._self, this._then);

  final SignUpEvent _self;
  final $Res Function(SignUpEvent) _then;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? signUpModel = null,}) {
  return _then(_self.copyWith(
signUpModel: null == signUpModel ? _self.signUpModel : signUpModel // ignore: cast_nullable_to_non_nullable
as SignUpModel,
  ));
}

}


/// Adds pattern-matching-related methods to [SignUpEvent].
extension SignUpEventPatterns on SignUpEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SignUpE value)?  signUp,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignUpE() when signUp != null:
return signUp(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SignUpE value)  signUp,}){
final _that = this;
switch (_that) {
case _SignUpE():
return signUp(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SignUpE value)?  signUp,}){
final _that = this;
switch (_that) {
case _SignUpE() when signUp != null:
return signUp(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( SignUpModel signUpModel)?  signUp,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignUpE() when signUp != null:
return signUp(_that.signUpModel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( SignUpModel signUpModel)  signUp,}) {final _that = this;
switch (_that) {
case _SignUpE():
return signUp(_that.signUpModel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( SignUpModel signUpModel)?  signUp,}) {final _that = this;
switch (_that) {
case _SignUpE() when signUp != null:
return signUp(_that.signUpModel);case _:
  return null;

}
}

}

/// @nodoc


class _SignUpE implements SignUpEvent {
  const _SignUpE(this.signUpModel);
  

@override final  SignUpModel signUpModel;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignUpECopyWith<_SignUpE> get copyWith => __$SignUpECopyWithImpl<_SignUpE>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignUpE&&(identical(other.signUpModel, signUpModel) || other.signUpModel == signUpModel));
}


@override
int get hashCode => Object.hash(runtimeType,signUpModel);

@override
String toString() {
  return 'SignUpEvent.signUp(signUpModel: $signUpModel)';
}


}

/// @nodoc
abstract mixin class _$SignUpECopyWith<$Res> implements $SignUpEventCopyWith<$Res> {
  factory _$SignUpECopyWith(_SignUpE value, $Res Function(_SignUpE) _then) = __$SignUpECopyWithImpl;
@override @useResult
$Res call({
 SignUpModel signUpModel
});




}
/// @nodoc
class __$SignUpECopyWithImpl<$Res>
    implements _$SignUpECopyWith<$Res> {
  __$SignUpECopyWithImpl(this._self, this._then);

  final _SignUpE _self;
  final $Res Function(_SignUpE) _then;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? signUpModel = null,}) {
  return _then(_SignUpE(
null == signUpModel ? _self.signUpModel : signUpModel // ignore: cast_nullable_to_non_nullable
as SignUpModel,
  ));
}


}

// dart format on
