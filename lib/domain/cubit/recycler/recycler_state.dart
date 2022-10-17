part of 'recycler_cubit.dart';

abstract class RecyclerState extends Equatable {
  const RecyclerState();

  @override
  List<Object> get props => [];
}

class RecyclerLoading extends RecyclerState {}

class RecyclerSuccess extends RecyclerState {
  final List<RecyclerModel> recyclerModelList;
  const RecyclerSuccess(this.recyclerModelList);

  @override
  List<Object> get props => [recyclerModelList];
}

class RecyclerError extends RecyclerState {}
