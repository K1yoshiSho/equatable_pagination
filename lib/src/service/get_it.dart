import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

GetIt getIt = GetIt.I;

initGetIt({required Talker talker}) async {
  getIt.registerLazySingleton<Dio>(
    () {
      // PrettyDioLogger logger = PrettyDioLogger(
      //   requestHeader: true,
      //   requestBody: true,
      //   responseBody: false,
      //   responseHeader: true,
      //   error: true,
      //   compact: true,
      //   maxWidth: 100,
      // );
      Dio dio = Dio(BaseOptions(baseUrl: 'https://rickandmortyapi.com/api/'));
      dio.interceptors.add(
        TalkerDioLogger(
          talker: talker,
          settings: TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printRequestData: true,
            printResponseData: false,
            printResponseHeaders: true,
            printResponseMessage: true,
            errorPen: AnsiPen()..red(bold: true),
          ),
        ),
      );
      return dio;
    },
  );
  getIt.registerSingleton<Talker>(talker);
}
