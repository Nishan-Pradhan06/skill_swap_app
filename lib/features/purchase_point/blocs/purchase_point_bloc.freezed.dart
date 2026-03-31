// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_point_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PurchasePointEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchasePointEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PurchasePointEvent()';
}


}

/// @nodoc
class $PurchasePointEventCopyWith<$Res>  {
$PurchasePointEventCopyWith(PurchasePointEvent _, $Res Function(PurchasePointEvent) __);
}


/// Adds pattern-matching-related methods to [PurchasePointEvent].
extension PurchasePointEventPatterns on PurchasePointEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _InitiatePayment value)?  initiatePayment,TResult Function( _VerifyPayment value)?  verifyPayment,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InitiatePayment() when initiatePayment != null:
return initiatePayment(_that);case _VerifyPayment() when verifyPayment != null:
return verifyPayment(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _InitiatePayment value)  initiatePayment,required TResult Function( _VerifyPayment value)  verifyPayment,}){
final _that = this;
switch (_that) {
case _InitiatePayment():
return initiatePayment(_that);case _VerifyPayment():
return verifyPayment(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _InitiatePayment value)?  initiatePayment,TResult? Function( _VerifyPayment value)?  verifyPayment,}){
final _that = this;
switch (_that) {
case _InitiatePayment() when initiatePayment != null:
return initiatePayment(_that);case _VerifyPayment() when verifyPayment != null:
return verifyPayment(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int amountInRs,  String purchaseOrderId,  String purchaseOrderName,  String customerName,  String customerEmail,  String customerPhone)?  initiatePayment,TResult Function( String pidx)?  verifyPayment,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InitiatePayment() when initiatePayment != null:
return initiatePayment(_that.amountInRs,_that.purchaseOrderId,_that.purchaseOrderName,_that.customerName,_that.customerEmail,_that.customerPhone);case _VerifyPayment() when verifyPayment != null:
return verifyPayment(_that.pidx);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int amountInRs,  String purchaseOrderId,  String purchaseOrderName,  String customerName,  String customerEmail,  String customerPhone)  initiatePayment,required TResult Function( String pidx)  verifyPayment,}) {final _that = this;
switch (_that) {
case _InitiatePayment():
return initiatePayment(_that.amountInRs,_that.purchaseOrderId,_that.purchaseOrderName,_that.customerName,_that.customerEmail,_that.customerPhone);case _VerifyPayment():
return verifyPayment(_that.pidx);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int amountInRs,  String purchaseOrderId,  String purchaseOrderName,  String customerName,  String customerEmail,  String customerPhone)?  initiatePayment,TResult? Function( String pidx)?  verifyPayment,}) {final _that = this;
switch (_that) {
case _InitiatePayment() when initiatePayment != null:
return initiatePayment(_that.amountInRs,_that.purchaseOrderId,_that.purchaseOrderName,_that.customerName,_that.customerEmail,_that.customerPhone);case _VerifyPayment() when verifyPayment != null:
return verifyPayment(_that.pidx);case _:
  return null;

}
}

}

/// @nodoc


class _InitiatePayment implements PurchasePointEvent {
  const _InitiatePayment({required this.amountInRs, required this.purchaseOrderId, required this.purchaseOrderName, required this.customerName, required this.customerEmail, required this.customerPhone});
  

 final  int amountInRs;
 final  String purchaseOrderId;
 final  String purchaseOrderName;
 final  String customerName;
 final  String customerEmail;
 final  String customerPhone;

/// Create a copy of PurchasePointEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitiatePaymentCopyWith<_InitiatePayment> get copyWith => __$InitiatePaymentCopyWithImpl<_InitiatePayment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InitiatePayment&&(identical(other.amountInRs, amountInRs) || other.amountInRs == amountInRs)&&(identical(other.purchaseOrderId, purchaseOrderId) || other.purchaseOrderId == purchaseOrderId)&&(identical(other.purchaseOrderName, purchaseOrderName) || other.purchaseOrderName == purchaseOrderName)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerEmail, customerEmail) || other.customerEmail == customerEmail)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone));
}


@override
int get hashCode => Object.hash(runtimeType,amountInRs,purchaseOrderId,purchaseOrderName,customerName,customerEmail,customerPhone);

@override
String toString() {
  return 'PurchasePointEvent.initiatePayment(amountInRs: $amountInRs, purchaseOrderId: $purchaseOrderId, purchaseOrderName: $purchaseOrderName, customerName: $customerName, customerEmail: $customerEmail, customerPhone: $customerPhone)';
}


}

/// @nodoc
abstract mixin class _$InitiatePaymentCopyWith<$Res> implements $PurchasePointEventCopyWith<$Res> {
  factory _$InitiatePaymentCopyWith(_InitiatePayment value, $Res Function(_InitiatePayment) _then) = __$InitiatePaymentCopyWithImpl;
@useResult
$Res call({
 int amountInRs, String purchaseOrderId, String purchaseOrderName, String customerName, String customerEmail, String customerPhone
});




}
/// @nodoc
class __$InitiatePaymentCopyWithImpl<$Res>
    implements _$InitiatePaymentCopyWith<$Res> {
  __$InitiatePaymentCopyWithImpl(this._self, this._then);

  final _InitiatePayment _self;
  final $Res Function(_InitiatePayment) _then;

/// Create a copy of PurchasePointEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? amountInRs = null,Object? purchaseOrderId = null,Object? purchaseOrderName = null,Object? customerName = null,Object? customerEmail = null,Object? customerPhone = null,}) {
  return _then(_InitiatePayment(
amountInRs: null == amountInRs ? _self.amountInRs : amountInRs // ignore: cast_nullable_to_non_nullable
as int,purchaseOrderId: null == purchaseOrderId ? _self.purchaseOrderId : purchaseOrderId // ignore: cast_nullable_to_non_nullable
as String,purchaseOrderName: null == purchaseOrderName ? _self.purchaseOrderName : purchaseOrderName // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerEmail: null == customerEmail ? _self.customerEmail : customerEmail // ignore: cast_nullable_to_non_nullable
as String,customerPhone: null == customerPhone ? _self.customerPhone : customerPhone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _VerifyPayment implements PurchasePointEvent {
  const _VerifyPayment(this.pidx);
  

 final  String pidx;

/// Create a copy of PurchasePointEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyPaymentCopyWith<_VerifyPayment> get copyWith => __$VerifyPaymentCopyWithImpl<_VerifyPayment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyPayment&&(identical(other.pidx, pidx) || other.pidx == pidx));
}


@override
int get hashCode => Object.hash(runtimeType,pidx);

@override
String toString() {
  return 'PurchasePointEvent.verifyPayment(pidx: $pidx)';
}


}

/// @nodoc
abstract mixin class _$VerifyPaymentCopyWith<$Res> implements $PurchasePointEventCopyWith<$Res> {
  factory _$VerifyPaymentCopyWith(_VerifyPayment value, $Res Function(_VerifyPayment) _then) = __$VerifyPaymentCopyWithImpl;
@useResult
$Res call({
 String pidx
});




}
/// @nodoc
class __$VerifyPaymentCopyWithImpl<$Res>
    implements _$VerifyPaymentCopyWith<$Res> {
  __$VerifyPaymentCopyWithImpl(this._self, this._then);

  final _VerifyPayment _self;
  final $Res Function(_VerifyPayment) _then;

/// Create a copy of PurchasePointEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pidx = null,}) {
  return _then(_VerifyPayment(
null == pidx ? _self.pidx : pidx // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$PurchasePointState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchasePointState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PurchasePointState()';
}


}

/// @nodoc
class $PurchasePointStateCopyWith<$Res>  {
$PurchasePointStateCopyWith(PurchasePointState _, $Res Function(PurchasePointState) __);
}


/// Adds pattern-matching-related methods to [PurchasePointState].
extension PurchasePointStatePatterns on PurchasePointState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _InitiateSuccess value)?  initiateSuccess,TResult Function( _VerifySuccess value)?  verifySuccess,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _InitiateSuccess() when initiateSuccess != null:
return initiateSuccess(_that);case _VerifySuccess() when verifySuccess != null:
return verifySuccess(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _InitiateSuccess value)  initiateSuccess,required TResult Function( _VerifySuccess value)  verifySuccess,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _InitiateSuccess():
return initiateSuccess(_that);case _VerifySuccess():
return verifySuccess(_that);case _Failure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _InitiateSuccess value)?  initiateSuccess,TResult? Function( _VerifySuccess value)?  verifySuccess,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _InitiateSuccess() when initiateSuccess != null:
return initiateSuccess(_that);case _VerifySuccess() when verifySuccess != null:
return verifySuccess(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String pidx)?  initiateSuccess,TResult Function()?  verifySuccess,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _InitiateSuccess() when initiateSuccess != null:
return initiateSuccess(_that.pidx);case _VerifySuccess() when verifySuccess != null:
return verifySuccess();case _Failure() when failure != null:
return failure(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String pidx)  initiateSuccess,required TResult Function()  verifySuccess,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _InitiateSuccess():
return initiateSuccess(_that.pidx);case _VerifySuccess():
return verifySuccess();case _Failure():
return failure(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String pidx)?  initiateSuccess,TResult? Function()?  verifySuccess,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _InitiateSuccess() when initiateSuccess != null:
return initiateSuccess(_that.pidx);case _VerifySuccess() when verifySuccess != null:
return verifySuccess();case _Failure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements PurchasePointState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PurchasePointState.initial()';
}


}




/// @nodoc


class _Loading implements PurchasePointState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PurchasePointState.loading()';
}


}




/// @nodoc


class _InitiateSuccess implements PurchasePointState {
  const _InitiateSuccess(this.pidx);
  

 final  String pidx;

/// Create a copy of PurchasePointState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitiateSuccessCopyWith<_InitiateSuccess> get copyWith => __$InitiateSuccessCopyWithImpl<_InitiateSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InitiateSuccess&&(identical(other.pidx, pidx) || other.pidx == pidx));
}


@override
int get hashCode => Object.hash(runtimeType,pidx);

@override
String toString() {
  return 'PurchasePointState.initiateSuccess(pidx: $pidx)';
}


}

/// @nodoc
abstract mixin class _$InitiateSuccessCopyWith<$Res> implements $PurchasePointStateCopyWith<$Res> {
  factory _$InitiateSuccessCopyWith(_InitiateSuccess value, $Res Function(_InitiateSuccess) _then) = __$InitiateSuccessCopyWithImpl;
@useResult
$Res call({
 String pidx
});




}
/// @nodoc
class __$InitiateSuccessCopyWithImpl<$Res>
    implements _$InitiateSuccessCopyWith<$Res> {
  __$InitiateSuccessCopyWithImpl(this._self, this._then);

  final _InitiateSuccess _self;
  final $Res Function(_InitiateSuccess) _then;

/// Create a copy of PurchasePointState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pidx = null,}) {
  return _then(_InitiateSuccess(
null == pidx ? _self.pidx : pidx // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _VerifySuccess implements PurchasePointState {
  const _VerifySuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifySuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PurchasePointState.verifySuccess()';
}


}




/// @nodoc


class _Failure implements PurchasePointState {
  const _Failure(this.message);
  

 final  String message;

/// Create a copy of PurchasePointState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PurchasePointState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $PurchasePointStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of PurchasePointState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Failure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
