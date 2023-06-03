part of 'data_bloc.dart';

abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object> get props => [DataLoaded];
}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataLoaded extends DataState {
  final CharactersModel charactersModel;
  const DataLoaded({required this.charactersModel});

  @override
  List<Object> get props => [charactersModel.results];
}

class DataError extends DataState {
  final String message;
  final DioError? error;

  const DataError({
    required this.message,
    required this.error,
  });

  @override
  List<Object> get props => [message];
}
