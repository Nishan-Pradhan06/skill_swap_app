import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khalti_checkout_flutter/khalti_checkout_flutter.dart';
import 'package:skill_swap/core/di/dependency_injection.dart';
import 'package:skill_swap/core/widgets/custom_toast.dart';
import 'package:skill_swap/features/profile/bloc/get_profile/get_profile_bloc.dart';

import '../blocs/purchase_point_bloc.dart';

class PurchasePointScreen extends StatefulWidget {
  const PurchasePointScreen({super.key});

  @override
  State<PurchasePointScreen> createState() => _PurchasePointScreenState();
}

class _PurchasePointScreenState extends State<PurchasePointScreen> {
  final List<Map<String, dynamic>> _packages = [
    {"points": 100, "price": 100},
    {"points": 500, "price": 400},
    {"points": 1000, "price": 750},
  ];

  late PurchasePointBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = sl<PurchasePointBloc>();
  }

  void _onPackageSelected(int priceInRs) {
    _bloc.add(
      PurchasePointEvent.initiatePayment(
        amountInRs: priceInRs,
        purchaseOrderId: "order_${DateTime.now().millisecondsSinceEpoch}",
        purchaseOrderName: "Points Package",
        customerName: "Skill Swap User",
        customerEmail: "user@example.com",
        customerPhone: "9800000000",
      ),
    );
  }

  void _launchKhalti(String pidx) async {
    final payConfig = KhaltiPayConfig(
      publicKey: "09616bd8ce254228858b0301eb64bb9b",
      pidx: pidx,
      environment: Environment.test,
    );

    final Future<Khalti> khaltiFuture = Khalti.init(
      enableDebugging: true,
      payConfig: payConfig,
      onPaymentResult: (paymentResult, khalti) {
        log('Payment Success: ${paymentResult.toString()}');
        _bloc.add(PurchasePointEvent.verifyPayment(pidx));
      },
      onMessage:
          (
            khalti, {
            description,
            statusCode,
            event,
            needsPaymentConfirmation,
          }) async {
            log(
              'Description: $description, Status Code: $statusCode, Event: $event, NeedsPaymentConfirmation: $needsPaymentConfirmation',
            );
            if (needsPaymentConfirmation == true) {
              _bloc.add(PurchasePointEvent.verifyPayment(pidx));
            }
          },
      onReturn: () => log('Successfully redirected to return_url.'),
    );

    final Khalti khaltiObj = await khaltiFuture;
    khaltiObj.open(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<PurchasePointBloc, PurchasePointState>(
        listener: (context, state) {
          state.maybeWhen(
            initiateSuccess: (pidx) {
              _launchKhalti(pidx);
            },
            verifySuccess: () {
              CustomToast.showSuccess(
                'Payment verified & points added successfully!',
              );
              context.read<GetProfileBloc>().add(
                const GetProfileEvent.getProfile(),
              );
              context.pop();
            },
            failure: (message) {
              CustomToast.showError(message);
            },
            orElse: () {},
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Purchase Points",
              style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: BackButton(onPressed: () => context.pop()),
          ),
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.1),
                      Theme.of(context).scaffoldBackgroundColor,
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        "Select a package to refill your balance.",
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Expanded(
                        child: ListView.separated(
                          itemCount: _packages.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final pkg = _packages[index];
                            return _buildPackageCard(
                              context: context,
                              points: pkg["points"],
                              price: pkg["price"],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<PurchasePointBloc, PurchasePointState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => Container(
                      color: Colors.black.withValues(alpha: 0.3),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    orElse: () => const SizedBox.shrink(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPackageCard({
    required BuildContext context,
    required int points,
    required int price,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('assets/images/coin.png', height: 40, width: 40),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$points Points",
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () => _onPackageSelected(price),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Rs $price",
              style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
