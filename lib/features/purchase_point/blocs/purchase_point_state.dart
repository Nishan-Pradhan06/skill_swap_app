part of 'purchase_point_bloc.dart';

@freezed
class PurchasePointState with _$PurchasePointState {
  const factory PurchasePointState.initial() = _Initial;
  const factory PurchasePointState.loading() = _Loading;
  const factory PurchasePointState.initiateSuccess(String pidx) = _InitiateSuccess;
  const factory PurchasePointState.verifySuccess() = _VerifySuccess;
  const factory PurchasePointState.failure(String message) = _Failure;
}
