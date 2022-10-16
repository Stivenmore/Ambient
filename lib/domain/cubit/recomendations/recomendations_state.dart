part of 'recomendations_cubit.dart';

abstract class RecomendationsState extends Equatable {
  const RecomendationsState();

  @override
  List<Object> get props => [];
}

class RecomendationsLoading extends RecomendationsState {}

class RecomendationsSuccess extends RecomendationsState {
  final List<RecomendationsModel> _list;

  const RecomendationsSuccess(this._list);

  @override
  List<Object> get props => [_list];
}

class RecomendationsError extends RecomendationsState {}
