// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manage_skill_post_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ManageSkillPostEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManageSkillPostEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ManageSkillPostEvent()';
}


}

/// @nodoc
class $ManageSkillPostEventCopyWith<$Res>  {
$ManageSkillPostEventCopyWith(ManageSkillPostEvent _, $Res Function(ManageSkillPostEvent) __);
}


/// Adds pattern-matching-related methods to [ManageSkillPostEvent].
extension ManageSkillPostEventPatterns on ManageSkillPostEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Create value)?  create,TResult Function( _Update value)?  update,TResult Function( _Delete value)?  delete,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Create() when create != null:
return create(_that);case _Update() when update != null:
return update(_that);case _Delete() when delete != null:
return delete(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Create value)  create,required TResult Function( _Update value)  update,required TResult Function( _Delete value)  delete,}){
final _that = this;
switch (_that) {
case _Create():
return create(_that);case _Update():
return update(_that);case _Delete():
return delete(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Create value)?  create,TResult? Function( _Update value)?  update,TResult? Function( _Delete value)?  delete,}){
final _that = this;
switch (_that) {
case _Create() when create != null:
return create(_that);case _Update() when update != null:
return update(_that);case _Delete() when delete != null:
return delete(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String title,  String description,  int categoryId,  String skillToLearn,  int pointsCost,  Map<String, dynamic>? availability,  List<Map<String, dynamic>>? availabilities)?  create,TResult Function( int postId,  String? title,  String? description,  int? categoryId,  String? skillToLearn,  int? pointsCost,  bool? isActive,  Map<String, dynamic>? availability,  List<Map<String, dynamic>>? availabilities)?  update,TResult Function( int postId)?  delete,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Create() when create != null:
return create(_that.title,_that.description,_that.categoryId,_that.skillToLearn,_that.pointsCost,_that.availability,_that.availabilities);case _Update() when update != null:
return update(_that.postId,_that.title,_that.description,_that.categoryId,_that.skillToLearn,_that.pointsCost,_that.isActive,_that.availability,_that.availabilities);case _Delete() when delete != null:
return delete(_that.postId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String title,  String description,  int categoryId,  String skillToLearn,  int pointsCost,  Map<String, dynamic>? availability,  List<Map<String, dynamic>>? availabilities)  create,required TResult Function( int postId,  String? title,  String? description,  int? categoryId,  String? skillToLearn,  int? pointsCost,  bool? isActive,  Map<String, dynamic>? availability,  List<Map<String, dynamic>>? availabilities)  update,required TResult Function( int postId)  delete,}) {final _that = this;
switch (_that) {
case _Create():
return create(_that.title,_that.description,_that.categoryId,_that.skillToLearn,_that.pointsCost,_that.availability,_that.availabilities);case _Update():
return update(_that.postId,_that.title,_that.description,_that.categoryId,_that.skillToLearn,_that.pointsCost,_that.isActive,_that.availability,_that.availabilities);case _Delete():
return delete(_that.postId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String title,  String description,  int categoryId,  String skillToLearn,  int pointsCost,  Map<String, dynamic>? availability,  List<Map<String, dynamic>>? availabilities)?  create,TResult? Function( int postId,  String? title,  String? description,  int? categoryId,  String? skillToLearn,  int? pointsCost,  bool? isActive,  Map<String, dynamic>? availability,  List<Map<String, dynamic>>? availabilities)?  update,TResult? Function( int postId)?  delete,}) {final _that = this;
switch (_that) {
case _Create() when create != null:
return create(_that.title,_that.description,_that.categoryId,_that.skillToLearn,_that.pointsCost,_that.availability,_that.availabilities);case _Update() when update != null:
return update(_that.postId,_that.title,_that.description,_that.categoryId,_that.skillToLearn,_that.pointsCost,_that.isActive,_that.availability,_that.availabilities);case _Delete() when delete != null:
return delete(_that.postId);case _:
  return null;

}
}

}

/// @nodoc


class _Create implements ManageSkillPostEvent {
  const _Create({required this.title, required this.description, required this.categoryId, required this.skillToLearn, required this.pointsCost, final  Map<String, dynamic>? availability, final  List<Map<String, dynamic>>? availabilities}): _availability = availability,_availabilities = availabilities;
  

 final  String title;
 final  String description;
 final  int categoryId;
 final  String skillToLearn;
 final  int pointsCost;
 final  Map<String, dynamic>? _availability;
 Map<String, dynamic>? get availability {
  final value = _availability;
  if (value == null) return null;
  if (_availability is EqualUnmodifiableMapView) return _availability;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<Map<String, dynamic>>? _availabilities;
 List<Map<String, dynamic>>? get availabilities {
  final value = _availabilities;
  if (value == null) return null;
  if (_availabilities is EqualUnmodifiableListView) return _availabilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ManageSkillPostEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateCopyWith<_Create> get copyWith => __$CreateCopyWithImpl<_Create>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Create&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.skillToLearn, skillToLearn) || other.skillToLearn == skillToLearn)&&(identical(other.pointsCost, pointsCost) || other.pointsCost == pointsCost)&&const DeepCollectionEquality().equals(other._availability, _availability)&&const DeepCollectionEquality().equals(other._availabilities, _availabilities));
}


@override
int get hashCode => Object.hash(runtimeType,title,description,categoryId,skillToLearn,pointsCost,const DeepCollectionEquality().hash(_availability),const DeepCollectionEquality().hash(_availabilities));

@override
String toString() {
  return 'ManageSkillPostEvent.create(title: $title, description: $description, categoryId: $categoryId, skillToLearn: $skillToLearn, pointsCost: $pointsCost, availability: $availability, availabilities: $availabilities)';
}


}

/// @nodoc
abstract mixin class _$CreateCopyWith<$Res> implements $ManageSkillPostEventCopyWith<$Res> {
  factory _$CreateCopyWith(_Create value, $Res Function(_Create) _then) = __$CreateCopyWithImpl;
@useResult
$Res call({
 String title, String description, int categoryId, String skillToLearn, int pointsCost, Map<String, dynamic>? availability, List<Map<String, dynamic>>? availabilities
});




}
/// @nodoc
class __$CreateCopyWithImpl<$Res>
    implements _$CreateCopyWith<$Res> {
  __$CreateCopyWithImpl(this._self, this._then);

  final _Create _self;
  final $Res Function(_Create) _then;

/// Create a copy of ManageSkillPostEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? categoryId = null,Object? skillToLearn = null,Object? pointsCost = null,Object? availability = freezed,Object? availabilities = freezed,}) {
  return _then(_Create(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,skillToLearn: null == skillToLearn ? _self.skillToLearn : skillToLearn // ignore: cast_nullable_to_non_nullable
as String,pointsCost: null == pointsCost ? _self.pointsCost : pointsCost // ignore: cast_nullable_to_non_nullable
as int,availability: freezed == availability ? _self._availability : availability // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,availabilities: freezed == availabilities ? _self._availabilities : availabilities // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,
  ));
}


}

/// @nodoc


class _Update implements ManageSkillPostEvent {
  const _Update({required this.postId, this.title, this.description, this.categoryId, this.skillToLearn, this.pointsCost, this.isActive, final  Map<String, dynamic>? availability, final  List<Map<String, dynamic>>? availabilities}): _availability = availability,_availabilities = availabilities;
  

 final  int postId;
 final  String? title;
 final  String? description;
 final  int? categoryId;
 final  String? skillToLearn;
 final  int? pointsCost;
 final  bool? isActive;
 final  Map<String, dynamic>? _availability;
 Map<String, dynamic>? get availability {
  final value = _availability;
  if (value == null) return null;
  if (_availability is EqualUnmodifiableMapView) return _availability;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<Map<String, dynamic>>? _availabilities;
 List<Map<String, dynamic>>? get availabilities {
  final value = _availabilities;
  if (value == null) return null;
  if (_availabilities is EqualUnmodifiableListView) return _availabilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ManageSkillPostEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateCopyWith<_Update> get copyWith => __$UpdateCopyWithImpl<_Update>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Update&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.skillToLearn, skillToLearn) || other.skillToLearn == skillToLearn)&&(identical(other.pointsCost, pointsCost) || other.pointsCost == pointsCost)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other._availability, _availability)&&const DeepCollectionEquality().equals(other._availabilities, _availabilities));
}


@override
int get hashCode => Object.hash(runtimeType,postId,title,description,categoryId,skillToLearn,pointsCost,isActive,const DeepCollectionEquality().hash(_availability),const DeepCollectionEquality().hash(_availabilities));

@override
String toString() {
  return 'ManageSkillPostEvent.update(postId: $postId, title: $title, description: $description, categoryId: $categoryId, skillToLearn: $skillToLearn, pointsCost: $pointsCost, isActive: $isActive, availability: $availability, availabilities: $availabilities)';
}


}

/// @nodoc
abstract mixin class _$UpdateCopyWith<$Res> implements $ManageSkillPostEventCopyWith<$Res> {
  factory _$UpdateCopyWith(_Update value, $Res Function(_Update) _then) = __$UpdateCopyWithImpl;
@useResult
$Res call({
 int postId, String? title, String? description, int? categoryId, String? skillToLearn, int? pointsCost, bool? isActive, Map<String, dynamic>? availability, List<Map<String, dynamic>>? availabilities
});




}
/// @nodoc
class __$UpdateCopyWithImpl<$Res>
    implements _$UpdateCopyWith<$Res> {
  __$UpdateCopyWithImpl(this._self, this._then);

  final _Update _self;
  final $Res Function(_Update) _then;

/// Create a copy of ManageSkillPostEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? postId = null,Object? title = freezed,Object? description = freezed,Object? categoryId = freezed,Object? skillToLearn = freezed,Object? pointsCost = freezed,Object? isActive = freezed,Object? availability = freezed,Object? availabilities = freezed,}) {
  return _then(_Update(
postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,skillToLearn: freezed == skillToLearn ? _self.skillToLearn : skillToLearn // ignore: cast_nullable_to_non_nullable
as String?,pointsCost: freezed == pointsCost ? _self.pointsCost : pointsCost // ignore: cast_nullable_to_non_nullable
as int?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,availability: freezed == availability ? _self._availability : availability // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,availabilities: freezed == availabilities ? _self._availabilities : availabilities // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,
  ));
}


}

/// @nodoc


class _Delete implements ManageSkillPostEvent {
  const _Delete(this.postId);
  

 final  int postId;

/// Create a copy of ManageSkillPostEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteCopyWith<_Delete> get copyWith => __$DeleteCopyWithImpl<_Delete>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Delete&&(identical(other.postId, postId) || other.postId == postId));
}


@override
int get hashCode => Object.hash(runtimeType,postId);

@override
String toString() {
  return 'ManageSkillPostEvent.delete(postId: $postId)';
}


}

/// @nodoc
abstract mixin class _$DeleteCopyWith<$Res> implements $ManageSkillPostEventCopyWith<$Res> {
  factory _$DeleteCopyWith(_Delete value, $Res Function(_Delete) _then) = __$DeleteCopyWithImpl;
@useResult
$Res call({
 int postId
});




}
/// @nodoc
class __$DeleteCopyWithImpl<$Res>
    implements _$DeleteCopyWith<$Res> {
  __$DeleteCopyWithImpl(this._self, this._then);

  final _Delete _self;
  final $Res Function(_Delete) _then;

/// Create a copy of ManageSkillPostEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? postId = null,}) {
  return _then(_Delete(
null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ManageSkillPostState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManageSkillPostState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ManageSkillPostState()';
}


}

/// @nodoc
class $ManageSkillPostStateCopyWith<$Res>  {
$ManageSkillPostStateCopyWith(ManageSkillPostState _, $Res Function(ManageSkillPostState) __);
}


/// Adds pattern-matching-related methods to [ManageSkillPostState].
extension ManageSkillPostStatePatterns on ManageSkillPostState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Success value)?  success,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Success value)  success,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Success():
return success(_that);case _Failure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Success value)?  success,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String message)?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.message);case _Failure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String message)  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Success():
return success(_that.message);case _Failure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String message)?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.message);case _Failure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ManageSkillPostState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ManageSkillPostState.initial()';
}


}




/// @nodoc


class _Loading implements ManageSkillPostState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ManageSkillPostState.loading()';
}


}




/// @nodoc


class _Success implements ManageSkillPostState {
  const _Success(this.message);
  

 final  String message;

/// Create a copy of ManageSkillPostState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ManageSkillPostState.success(message: $message)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $ManageSkillPostStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of ManageSkillPostState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Success(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Failure implements ManageSkillPostState {
  const _Failure(this.message);
  

 final  String message;

/// Create a copy of ManageSkillPostState
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
  return 'ManageSkillPostState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $ManageSkillPostStateCopyWith<$Res> {
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

/// Create a copy of ManageSkillPostState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Failure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
