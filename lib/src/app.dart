// import 'package:easy_refresh/easy_refresh.dart';
// import 'package:equatable_pagination/src/bloc/data_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Equatable with pagination',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Equatable with pagination'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final DataBloc _dataBloc = DataBloc();
//   final EasyRefreshController _controller = EasyRefreshController(
//     controlFinishRefresh: true,
//     controlFinishLoad: true,
//   );

//   @override
//   void initState() {
//     _dataBloc.add(const GetList(index: 1));
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _dataBloc.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         child: EasyRefresh(
//           controller: _controller,
//           onRefresh: () async {
//             _controller.finishRefresh();
//           },
//           child: BlocConsumer<DataBloc, DataState>(
//             bloc: _dataBloc,
//             listener: (context, state) {
//               if (state is DataError) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text(state.message),
//                   ),
//                 );
//               }
//             },
//             builder: (context, state) {
//               if (state is DataLoaded) {
//                 return ListView.builder(
//                   itemCount: state.posts.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(state.posts[index].name),
//                     );
//                   },
//                 );
//               }
//               return const Center(child: CircularProgressIndicator());
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
