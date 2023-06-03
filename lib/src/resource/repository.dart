import 'package:dio/dio.dart';
import 'package:equatable_pagination/src/bloc/data_bloc.dart';
import 'package:equatable_pagination/src/models/person.dart';
import 'package:equatable_pagination/src/service/get_it.dart';
import 'package:equatable_pagination/src/service/http_query.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';

abstract class Repository {
  const Repository();

  Future<void> getList(GetList event, Emitter<DataState> emit, DataState state);
}

class AppRepository implements Repository {
  const AppRepository();

  @override
  Future<void> getList(GetList event, Emitter<DataState> emit, DataState state) async {
    try {
      if (state is! DataLoaded) {
        emit(DataLoading());
      }

      dynamic response = await HttpQuery().get(
        url: "character/?page=${event.index}",
      );
      if (response is DioError) {
        DioError e = response;
        getIt<Talker>().handle(e, e.stackTrace);
        emit(DataError(message: e.message ?? "", error: e));
      } else {
        emit(DataLoaded(
          charactersModel: CharactersModel.fromJson(response),
        ));
      }
    } on DioError catch (e, st) {
      getIt<Talker>().handle(e, st);
      emit(DataError(message: e.message ?? "", error: e));
    } catch (e, st) {
      getIt<Talker>().handle(e, st);
      emit(DataError(message: e.toString(), error: null));
    }
  }

  Future<CharactersModel> fetchData(int page) async {
    dynamic response = await HttpQuery().get(
      url: "character/?page=$page",
    );
    if (response is DioError) {
      DioError e = response;
      getIt<Talker>().handle(e, e.stackTrace);
      throw e; // Throw the error so it can be caught by the caller
    } else {
      return CharactersModel.fromJson(response);
    }
  }
}

int getPageValueFromUrl(String url) {
  var uri = Uri.parse(url);
  var queryParameters = uri.queryParameters;

  if (queryParameters.containsKey('page')) {
    var pageValue = queryParameters['page'];
    return pageValue != null ? int.tryParse(pageValue)! : -1; // return -1 if page value is not a valid integer
  }

  return -1; // return -1 if page parameter is not found in the URL
}
