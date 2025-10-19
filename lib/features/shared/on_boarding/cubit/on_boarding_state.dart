part of 'on_boarding_cubit.dart';

class OnBoardingState extends Equatable {
  final String? onBoardingCompleted;

  const OnBoardingState({this.onBoardingCompleted});

  @override
  List<Object?> get props => [onBoardingCompleted];
}
