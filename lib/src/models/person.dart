import 'package:equatable/equatable.dart';
import 'package:equatable_pagination/src/resource/repository.dart';

class CharactersModel extends Equatable {
  final int itemsCount;
  final int lastPage;
  final int? nextPage;
  final int? previousPage;
  final List<Person> results;

  const CharactersModel({
    required this.itemsCount,
    required this.lastPage,
    required this.nextPage,
    required this.previousPage,
    required this.results,
  });

  @override
  List<Object> get props => [nextPage ?? -1, previousPage ?? -1, results];

  static CharactersModel fromJson(dynamic json) {
    return CharactersModel(
      itemsCount: json['info']['count'],
      lastPage: json['info']['pages'],
      nextPage: (json['info']['next'] != null) ? getPageValueFromUrl(json['info']['next'] as String) : null,
      previousPage: (json['info']['prev'] != null) ? getPageValueFromUrl(json['info']['prev'] as String) : null,
      results: Person.fromList(json['results'] as List<dynamic>),
    );
  }

  static List<CharactersModel> fromList(List<dynamic> jsonList) {
    return jsonList.map((json) => CharactersModel.fromJson(json)).toList();
  }
}

class Person extends Equatable {
  final int id;
  final String name;
  final String gender;
  final String imageURL;

  const Person({
    required this.id,
    required this.name,
    required this.gender,
    required this.imageURL,
  });

  @override
  List<Object> get props => [id, name, gender, imageURL];

  static Person fromJson(dynamic json) {
    return Person(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      imageURL: json['image'],
    );
  }

  static List<Person> fromList(List<dynamic> jsonList) {
    return jsonList.map((json) => Person.fromJson(json)).toList();
  }
}
