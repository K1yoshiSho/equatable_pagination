import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:equatable_pagination/src/models/person.dart';
import 'package:equatable_pagination/src/resource/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  AppRepository repository = const AppRepository();
  DataBloc() : super(DataInitial()) {
    on<GetList>((event, emit) => repository.getList(event, emit, state));
  }
}
