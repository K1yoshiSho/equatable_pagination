part of 'data_bloc.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();

  @override
  List<Object> get props => [GetList];
}

class GetList extends DataEvent {
  final int index;
  const GetList({required this.index});
}
