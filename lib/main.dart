import 'package:equatable_pagination/src/bloc/data_bloc.dart';
import 'package:equatable_pagination/src/models/person.dart';
import 'package:equatable_pagination/src/service/get_it.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  Talker talker = TalkerFlutter.init();
  initGetIt(talker: talker);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyRefresh',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 1;
  int? _nextPage;
  int _limit = 1;
  List<Person> _list = [];
  late EasyRefreshController _controller;
  late DataBloc _dataBloc;

  @override
  void initState() {
    super.initState();
    _dataBloc = DataBloc();
    _dataBloc.add(const GetList(index: 1));
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _dataBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getIt<Talker>().warning("_currentPage: $_currentPage");
    getIt<Talker>().warning("_nextPage: $_nextPage");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('EasyRefresh'),
      ),
      body: EasyRefresh(
        controller: _controller,
        callLoadOverOffset: 5,
        header: const ClassicHeader(
          dragText: "Для загрузки потяните вниз",
          armedText: "Отпустите для загрузки",
          readyText: "Загрузка...",
          processingText: "Загрузка...",
          processedText: "Загружено",
          noMoreText: "Больше нет",
          failedText: "Ошибка",
          messageText: "Последний раз обновлялось: %T",
        ),
        footer: const ClassicFooter(
          position: IndicatorPosition.behind,
          dragText: "Для загрузки потяните вниз",
          armedText: "Отпустите для загрузки",
          readyText: "Загрузка...",
          processingText: "Загрузка...",
          processedText: "Загружено",
          noMoreText: "Больше нет данных",
          failedText: "Ошибка",
          messageText: "Обновлено: %T",
        ),
        onRefresh: () async {
          setState(() {
            _currentPage = 1;
          });
          getIt<Talker>().warning("onRefresh");
          if (!mounted) {
            return;
          }
          var newData = await _dataBloc.repository.fetchData(_currentPage);
          getIt<Talker>().good("listEquals: ${listEquals(newData.results, _list)}");
          if (!listEquals(newData.results, _list)) {
            _list.clear();
            _dataBloc.add(const GetList(index: 1));
          }
          _controller.finishRefresh();
          _controller.resetFooter();
        },
        onLoad: () async {
          getIt<Talker>().warning("onLoad");
          if (!mounted) return;

          if (_nextPage != null && _nextPage! <= _limit) {
            _dataBloc.add(GetList(index: _nextPage!));
          } else {
            _controller.finishLoad(IndicatorResult.noMore);
          }

          setState(() {});
        },
        child: BlocConsumer<DataBloc, DataState>(
          bloc: _dataBloc,
          listener: (context, state) {
            getIt<Talker>().warning("listener: ${state.toString()}");
            if (state is DataLoaded) {
              setState(() {
                var newData = state.charactersModel.results;
                _list.addAll(newData);
                _limit = state.charactersModel.lastPage;
                _nextPage = state.charactersModel.nextPage;
              });
              _controller.finishLoad(IndicatorResult.success);
            }
          },
          builder: (context, state) {
            if (state is DataLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      alignment: Alignment.center,
                      height: 80,
                      child: Text("${_list[index].name} ${_list[index].id}"),
                    ),
                  );
                },
                itemCount: _list.length,
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
