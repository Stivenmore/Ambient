part of 'general_cubit.dart';

enum GeneralStateUserPhoto { success, error, loading, none }

enum GeneralStateUserUpdate { success, error, loading, none }

class GeneralState extends Equatable {
  late final String term;
  late final String priv;
  late final GeneralStateUserPhoto generalStateUserPhoto;
  late final GeneralStateUserUpdate update;
  GeneralState(
      {GeneralStateUserPhoto? generalStateUserPhoto,
      GeneralStateUserUpdate? update}) {
    this.generalStateUserPhoto =
        generalStateUserPhoto ?? GeneralStateUserPhoto.none;
    this.update = update ?? GeneralStateUserUpdate.none;
  }

  GeneralState copyWith(
      {GeneralStateUserPhoto? generalStateUserPhoto,
      GeneralStateUserUpdate? update}) {
    return GeneralState(
        generalStateUserPhoto:
            generalStateUserPhoto ?? this.generalStateUserPhoto,
        update: update ?? this.update);
  }

  @override
  List<Object> get props => [generalStateUserPhoto, update];
}

class GeneralInitial extends GeneralState {}
