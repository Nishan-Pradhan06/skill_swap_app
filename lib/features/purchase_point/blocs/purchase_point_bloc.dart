import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../repositories/purchase_point_repository.dart';

part 'purchase_point_bloc.freezed.dart';
part 'purchase_point_event.dart';
part 'purchase_point_state.dart';

class PurchasePointBloc extends Bloc<PurchasePointEvent, PurchasePointState> {
  final PurchasePointRepository _repository;

  PurchasePointBloc({required PurchasePointRepository repository})
      : _repository = repository,
        super(const PurchasePointState.initial()) {
    on<_InitiatePayment>(_onInitiatePayment);
    on<_VerifyPayment>(_onVerifyPayment);
  }

  Future<void> _onInitiatePayment(
    _InitiatePayment event,
    Emitter<PurchasePointState> emit,
  ) async {
    emit(const PurchasePointState.loading());

    final result = await _repository.initiatePayment(
      amountInRs: event.amountInRs,
      purchaseOrderId: event.purchaseOrderId,
      purchaseOrderName: event.purchaseOrderName,
      customerName: event.customerName,
      customerEmail: event.customerEmail,
      customerPhone: event.customerPhone,
    );

    result.fold(
      (failure) => emit(PurchasePointState.failure(failure.message)),
      (pidx) => emit(PurchasePointState.initiateSuccess(pidx)),
    );
  }

  Future<void> _onVerifyPayment(
    _VerifyPayment event,
    Emitter<PurchasePointState> emit,
  ) async {
    emit(const PurchasePointState.loading());

    final result = await _repository.verifyPayment(event.pidx);

    result.fold(
      (failure) => emit(PurchasePointState.failure(failure.message)),
      (isSuccess) {
        if (isSuccess) {
          emit(const PurchasePointState.verifySuccess());
        } else {
          emit(const PurchasePointState.failure("Payment verification failed"));
        }
      },
    );
  }
}
