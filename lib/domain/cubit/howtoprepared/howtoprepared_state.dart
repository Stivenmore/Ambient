part of 'howtoprepared_cubit.dart';

abstract class HowtopreparedState extends Equatable {
  const HowtopreparedState();

  @override
  List<Object> get props => [];
}

class HowtopreparedInitial extends HowtopreparedState {}

class HowtopreparedLoading extends HowtopreparedState {}

class HowtopreparedLoaded extends HowtopreparedState {
  final List<HowToPreparedModel> howtoprepared;
  const HowtopreparedLoaded({required this.howtoprepared});

  @override
  List<Object> get props => [howtoprepared];
}

class HowtopreparedError extends HowtopreparedState {
  final String error;
  const HowtopreparedError({required this.error});

  @override
  List<Object> get props => [error];
}
