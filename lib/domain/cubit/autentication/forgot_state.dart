part of 'forgot_cubit.dart';

abstract class ForgotState extends Equatable {
  const ForgotState();

  @override
  List<Object> get props => [];
}

class ForgotInitial extends ForgotState {}

class ForgotError extends ForgotState {
  final String message;
  const ForgotError(this.message);

  @override
  List<Object> get props => [message];
}

class ForgotLoading extends ForgotState {}

class ForgotLoaded extends ForgotState {}
