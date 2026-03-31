part of 'purchase_point_bloc.dart';

@freezed
class PurchasePointEvent with _$PurchasePointEvent {
  const factory PurchasePointEvent.initiatePayment({
    required int amountInRs,
    required String purchaseOrderId,
    required String purchaseOrderName,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
  }) = _InitiatePayment;

  const factory PurchasePointEvent.verifyPayment(String pidx) = _VerifyPayment;
}
