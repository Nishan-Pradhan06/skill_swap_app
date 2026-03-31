import 'package:dartz/dartz.dart';
import '../../../../core/network/api_services.dart';
import '../../../../common/error/failure.dart';
import '../../../../common/error/error_handler.dart';

abstract class PurchasePointRepository {
  Future<Either<Failure, String>> initiatePayment({
    required int amountInRs,
    required String purchaseOrderId,
    required String purchaseOrderName,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
  });

  Future<Either<Failure, bool>> verifyPayment(String pidx);
}

class PurchasePointRepositoryImpl implements PurchasePointRepository {
  final ApiService _apiService;

  PurchasePointRepositoryImpl({required ApiService apiService}) : _apiService = apiService;

  @override
  Future<Either<Failure, String>> initiatePayment({
    required int amountInRs,
    required String purchaseOrderId,
    required String purchaseOrderName,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
  }) async {
    try {
      final response = await _apiService.post(
        '/khalti/initiate/',
        data: {
          "amount": amountInRs,
          "customer_name": customerName,
          "customer_email": customerEmail,
          "customer_phone": customerPhone,
        },
      );

      return response.fold(
        (failure) => Left(failure),
        (data) {
          if (data['pidx'] != null) {
            return Right(data['pidx'] as String);
          }
          return Left(
              ServerFailure(message: data['error'] ?? "Failed to initiate payment"));
        },
      );
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyPayment(String pidx) async {
    try {
      final response = await _apiService.post(
        '/khalti/verify/',
        data: {
          "pidx": pidx,
        },
      );

      return response.fold(
        (failure) => Left(failure),
        (data) {
          if (data['success'] == true) {
            return const Right(true);
          }
          return const Right(false);
        },
      );
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }
}
