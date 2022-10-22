part of 'statues_cubit.dart';

@immutable
abstract class StatuesState {}

class StatuesInitial extends StatuesState {}

class StatuesLoaded extends StatuesState {
  final List<Statue> statues;
  StatuesLoaded(this.statues);
}

class StatuesError extends StatuesState {}

class StatuePredicted extends StatuesState {
  final Statue statue;
  StatuePredicted(this.statue);
}

class StatuePredictionLoading extends StatuesState {}

class StatueNotPredicted extends StatuesState {}