// To parse this JSON data, do
//
//     final movieModel = movieModelFromJson(jsonString);

import 'dart:convert';

MovieModel movieModelFromJson(String str) =>
    MovieModel.fromJson(json.decode(str));

String movieModelToJson(MovieModel data) => json.encode(data.toJson());

class MovieModel {
  MovieModel({
    required this.result,
    required this.queryParam,
    required this.code,
    required this.message,
  });

  List<Result> result;
  QueryParam queryParam;
  int code;
  String message;

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        queryParam: QueryParam.fromJson(json["queryParam"]),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "queryParam": queryParam.toJson(),
        "code": code,
        "message": message,
      };
}

class QueryParam {
  QueryParam({
    required this.category,
    required this.language,
    required this.genre,
  });

  String category;
  String language;
  String genre;

  factory QueryParam.fromJson(Map<String, dynamic> json) => QueryParam(
        category: json["category"],
        language: json["language"],
        genre: json["genre"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "language": language,
        "genre": genre,
      };
}

class Result {
  Result({
    required this.id,
    required this.description,
    required this.director,
    required this.writers,
    required this.stars,
    required this.productionCompany,
    required this.pageViews,
    this.upVoted,
    this.downVoted,
    required this.title,
    required this.language,
    this.runTime,
    required this.releasedDate,
    required this.genre,
    required this.voted,
    required this.poster,
    required this.totalVoted,
    required this.voting,
  });

  String id;
  String description;
  List<String> director;
  List<String> writers;
  List<String> stars;
  List<String> productionCompany;
  int pageViews;
  List<String>? upVoted;
  List<String>? downVoted;
  String title;
  String language;
  int? runTime;
  int releasedDate;
  String genre;
  List<Voted> voted;
  String poster;
  int totalVoted;
  int voting;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        description: json["description"],
        director: List<String>.from(json["director"].map((x) => x)),
        writers: List<String>.from(json["writers"].map((x) => x)),
        stars: List<String>.from(json["stars"].map((x) => x)),
        productionCompany:
            List<String>.from(json["productionCompany"].map((x) => x)),
        pageViews: json["pageViews"],
        upVoted: json["upVoted"] == null
            ? []
            : List<String>.from(json["upVoted"]!.map((x) => x)),
        downVoted: json["downVoted"] == null
            ? []
            : List<String>.from(json["downVoted"]!.map((x) => x)),
        title: json["title"],
        language: json["language"],
        runTime: json["runTime"],
        releasedDate: json["releasedDate"],
        genre: json["genre"],
        voted: List<Voted>.from(json["voted"].map((x) => Voted.fromJson(x))),
        poster: json["poster"],
        totalVoted: json["totalVoted"],
        voting: json["voting"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "description": description,
        "director": List<dynamic>.from(director.map((x) => x)),
        "writers": List<dynamic>.from(writers.map((x) => x)),
        "stars": List<dynamic>.from(stars.map((x) => x)),
        "productionCompany":
            List<dynamic>.from(productionCompany.map((x) => x)),
        "pageViews": pageViews,
        "upVoted":
            upVoted == null ? [] : List<dynamic>.from(upVoted!.map((x) => x)),
        "downVoted": downVoted == null
            ? []
            : List<dynamic>.from(downVoted!.map((x) => x)),
        "title": title,
        "language": language,
        "runTime": runTime,
        "releasedDate": releasedDate,
        "genre": genre,
        "voted": List<dynamic>.from(voted.map((x) => x.toJson())),
        "poster": poster,
        "totalVoted": totalVoted,
        "voting": voting,
      };
}

class Voted {
  Voted({
    required this.upVoted,
    required this.downVoted,
    required this.id,
    required this.genre,
    required this.updatedAt,
  });

  List<String> upVoted;
  List<String> downVoted;
  String id;
  String genre;
  int updatedAt;

  factory Voted.fromJson(Map<String, dynamic> json) => Voted(
        upVoted: List<String>.from(json["upVoted"].map((x) => x)),
        downVoted: List<String>.from(json["downVoted"].map((x) => x)),
        id: json["_id"],
        genre: json["genre"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "upVoted": List<dynamic>.from(upVoted.map((x) => x)),
        "downVoted": List<dynamic>.from(downVoted.map((x) => x)),
        "_id": id,
        "genre": genre,
        "updatedAt": updatedAt,
      };
}
