// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignInEvent {

 SignInModel get signInModel;
/// Create a copy of SignInEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInEventCopyWith<SignInEvent> get copyWith => _$SignInEventCopyWithImpl<SignInEvent>(this as SignInEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInEvent&&(identical(other.signInModel, signInModel) || other.signInModel == signInModel));
}


@override
int get hashCode => Object.hash(runtimeType,signInModel);

@override
String toString() {
  return 'SignInEvent(signInModel: $signInModel)';
}


}

/// @nodoc
abstract mixin class $SignInEventCopyWith<$Res>  {
  factory $SignInEventCopyWith(SignInEvent value, $Res Function(SignInEvent) _then) = _$SignInEventCopyWithImpl;
@useResult
$Res call({
 SignInModel signInModel
});




}
/// @nodoc
class _$SignInEventCopyWithImpl<$Res>
    implements $SignInEventCopyWith<$Res> {
  _$SignInEventCopyWithImpl(this._self, this._then);

  final SignInEvent _self;
  final $Res Function(SignInEvent) _then;

/// Create a copy of SignInEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? signInModel = null,}) {
  return _then(_self.copyWith(
signInModel: null == signInModel ? _self.signInModel : signInModel // ignore: cast_nullable_to_non_nullable
as SignInModel,
  ));
}

}


/// Adds pattern-matching-related methods to [SignInEvent].
extension SignInEventPatterns on SignInEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SignInE value)?  signIn,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignInE() when signIn != null:
return signIn(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SignInE value)  signIn,}){
final _that = this;
switch (_that) {
case _SignInE():
return signIn(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SignInE value)?  signIn,}){
final _that = this;
switch (_that) {
case _SignInE() when signIn != null:
return signIn(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( SignInModel signInModel)?  signIn,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignInE() when signIn != null:
return signIn(_that.signInModel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( SignInModel signInModel)  signIn,}) {final _that = this;
switch (_that) {
case _SignInE():
return signIn(_that.signInModel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( SignInModel signInModel)?  signIn,}) {final _that = this;
switch (_that) {
case _SignInE() when signIn != null:
return signIn(_that.signInModel);case _:
  return null;

}
}

}

/// @nodoc


class _SignInE implements SignInEvent {
  const _SignInE(this.signInModel);
  

@override final  SignInModel signInModel;

/// Create a copy of SignInEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInECopyWith<_SignInE> get copyWith => __$SignInECopyWithImpl<_SignInE>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInE&&(identical(other.signInModel, signInModel) || other.signInModel == signInModel));
}


@override
int get hashCode => Object.hash(runtimeType,signInModel);

@override
String toString() {
  return 'SignInEvent.signIn(signInModel: $signInModel)';
}


}

/// @nodoc
abstract mixin class _$SignInECopyWith<$Res> implements $SignInEventCopyWith<$Res> {
  factory _$SignInECopyWith(_SignInE value, $Res Function(_SignInE) _then) = __$SignInECopyWithImpl;
@override @useResult
$Res call({
 SignInModel signInModel
});




}
/// @nodoc
class __$SignInECopyWithImpl<$Res>
    implements _$SignInECopyWith<$Res> {
  __$SignInECopyWithImpl(this._self, this._then);

  final _SignInE _self;
  final $Res Function(_SignInE) _then;

/// Create a copy of SignInEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? signInModel = null,}) {
  return _then(_SignInE(
null == signInModel ? _self.signInModel : signInModel // ignore: cast_nullable_to_non_nullable
as SignInModel,
  ));
}


}

// dart format on
