import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

import 'genre_model.dart';

class TvDetailResponse {
  bool adult;
  String backdropPath;

//  List<CreatedBy> createdBy;
  List<int> episodeRunTime;
  DateTime firstAirDate;
  List<GenreModel> genres;
  String homepage;
  int id;
  bool inProduction;
  List<String> languages;
  DateTime lastAirDate;

//  TEpisodeToAir lastEpisodeToAir;
  String name;

//  TEpisodeToAir nextEpisodeToAir;
//  List<Network> networks;
  int numberOfEpisodes;
  int numberOfSeasons;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String posterPath;

//  List<Network> productionCompanies;
//  List<ProductionCountry> productionCountries;
  List<SeasonModel> seasons;

//  List<SpokenLanguage> spokenLanguages;
  String status;
  String tagline;
  String type;
  double voteAverage;
  int voteCount;

  TvDetailResponse({
    required this.adult,
    required this.backdropPath,
//    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
//    required this.lastEpisodeToAir,
    required this.name,
//    required this.nextEpisodeToAir,
//    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    // required this.productionCompanies,
    //  required this.productionCountries,
    required this.seasons,
//    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

/*  factory TvDetailResponse.fromRawJson(String str) => TvDetailResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());*/

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
//    createdBy: List<CreatedBy>.from(json["created_by"].map((x) => CreatedBy.fromJson(x))),
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: DateTime.parse(json["first_air_date"]),
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: DateTime.parse(json["last_air_date"]),
//    lastEpisodeToAir: TEpisodeToAir.fromJson(json["last_episode_to_air"]),
        name: json["name"],
//    nextEpisodeToAir: TEpisodeToAir.fromJson(json["next_episode_to_air"]),
//    networks: List<Network>.from(json["networks"].map((x) => Network.fromJson(x))),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        //productionCompanies: List<Network>.from(json["production_companies"].map((x) => Network.fromJson(x))),
        //  productionCountries: List<ProductionCountry>.from(json["production_countries"].map((x) => ProductionCountry.fromJson(x))),
        seasons: List<SeasonModel>.from(
            json["seasons"].map((x) => SeasonModel.fromJson(x))),
//    spokenLanguages: List<SpokenLanguage>.from(json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
//    "created_by": List<dynamic>.from(createdBy.map((x) => x.toJson())),
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "first_air_date":
            "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "last_air_date":
            "${lastAirDate.year.toString().padLeft(4, '0')}-${lastAirDate.month.toString().padLeft(2, '0')}-${lastAirDate.day.toString().padLeft(2, '0')}",
//    "last_episode_to_air": lastEpisodeToAir.toJson(),
        "name": name,
//    "next_episode_to_air": nextEpisodeToAir.toJson(),
//    "networks": List<dynamic>.from(networks.map((x) => x.toJson())),
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        //"production_companies": List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
        //  "production_countries": List<dynamic>.from(productionCountries.map((x) => x.toJson())),
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
//    "spoken_languages": List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TvDetail toEntity() {
    return TvDetail(
        adult: this.adult,
        backdropPath: this.backdropPath,
        episodeRunTime: this.episodeRunTime,
        firstAirDate: this.firstAirDate,
        genres: this.genres.map((genre) => genre.toEntity()).toList(),
        homepage: this.homepage,
        id: this.id,
        inProduction: this.inProduction,
        languages: this.languages,
        lastAirDate: this.lastAirDate,
        name: this.name,
        numberOfEpisodes: this.numberOfEpisodes,
        numberOfSeasons: this.numberOfSeasons,
        originCountry: this.originCountry,
        originalLanguage: this.originalLanguage,
        originalName: this.originalName,
        overview: this.overview,
        popularity: this.popularity,
        posterPath: this.posterPath,
        seasons: this.seasons.map((season) => season.toEntity()).toList(),
        status: this.status,
        tagline: this.tagline,
        type: this.type,
        voteAverage: this.voteAverage,
        voteCount: this.voteCount);
  }
}
/*
class CreatedBy {
  int id;
  String creditId;
  String name;
  String originalName;
  int gender;
  String profilePath;

  CreatedBy({
    required this.id,
    required this.creditId,
    required this.name,
    required this.originalName,
    required this.gender,
    required this.profilePath,
  });

  factory CreatedBy.fromRawJson(String str) => CreatedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["id"],
    creditId: json["credit_id"],
    name: json["name"],
    originalName: json["original_name"],
    gender: json["gender"],
    profilePath: json["profile_path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "credit_id": creditId,
    "name": name,
    "original_name": originalName,
    "gender": gender,
    "profile_path": profilePath,
  };
}

class TEpisodeToAir {
  int id;
  String overview;
  String name;
  int voteAverage;
  int voteCount;
  DateTime airDate;
  int episodeNumber;
  String episodeType;
  String productionCode;
  int? runtime;
  int seasonNumber;
  int showId;
  String? stillPath;

  TEpisodeToAir({
    required this.id,
    required this.overview,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
    required this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
  });

  factory TEpisodeToAir.fromRawJson(String str) => TEpisodeToAir.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TEpisodeToAir.fromJson(Map<String, dynamic> json) => TEpisodeToAir(
    id: json["id"],
    overview: json["overview"],
    name: json["name"],
    voteAverage: json["vote_average"],
    voteCount: json["vote_count"],
    airDate: DateTime.parse(json["air_date"]),
    episodeNumber: json["episode_number"],
    episodeType: json["episode_type"],
    productionCode: json["production_code"],
    runtime: json["runtime"],
    seasonNumber: json["season_number"],
    showId: json["show_id"],
    stillPath: json["still_path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "overview": overview,
    "name": name,
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "air_date": "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
    "episode_number": episodeNumber,
    "episode_type": episodeType,
    "production_code": productionCode,
    "runtime": runtime,
    "season_number": seasonNumber,
    "show_id": showId,
    "still_path": stillPath,
  };
}*/