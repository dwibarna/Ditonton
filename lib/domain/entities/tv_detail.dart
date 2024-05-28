import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  final bool adult;
  final String backdropPath;
//  List<CreatedBy> createdBy;
  final List<int> episodeRunTime;
  final DateTime firstAirDate;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final DateTime lastAirDate;
//  TEpisodeToAir lastEpisodeToAir;
  final String name;
//  TEpisodeToAir nextEpisodeToAir;
//  List<Network> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
//  List<Network> productionCompanies;
//  List<ProductionCountry> productionCountries;
  final List<Season> seasons;
//  List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;


  TvDetail({
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


  @override
  List<Object?> get props => [
    adult,
    backdropPath,
//    required this.createdBy,
    episodeRunTime,
    firstAirDate,
    genres,
    homepage,
    id,
    inProduction,
    languages,
    lastAirDate,
//    required this.lastEpisodeToAir,
    name,
//    required this.nextEpisodeToAir,
//    required this.networks,
    numberOfEpisodes,
    numberOfSeasons,
    originCountry,
    originalLanguage,
    originalName,
    overview,
    popularity,
    posterPath,
    // required this.productionCompanies,
    //  required this.productionCountries,
    seasons,
//    required this.spokenLanguages,
    status,
    tagline,
    type,
    voteAverage,
    voteCount,
  ];

}