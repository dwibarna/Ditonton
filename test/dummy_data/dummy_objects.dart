import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_show_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/tv_show.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testTvShow = TvShow(
    backdropPath: "/cQ7obD9zptMqtmmwBi13gunYe2D.jpg",
    genreIds: [
      16,
      10759,
      10765
    ],
    id: 31910,
    originalName: "ナルト 疾風伝",
    overview:
    "After 2 and a half years Naruto finally returns to his village of Konoha, and sets about putting his ambitions to work. It will not be easy though as he has amassed a few more dangerous enemies, in the likes of the shinobi organization; Akatsuki.",
    popularity: 174.02,
    posterPath: "/xppeysfvDKVx775MFuH8Z9BlpMk.jpg",
    name: "Naruto",
    voteAverage: 8.6,
    voteCount: 7947,
);


final testMovieList = [testMovie];

final testTvSeriesList = [testTvShow];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testTvShowDetail = TvDetail(
    adult: false,
    backdropPath: "/cQ7obD9zptMqtmmwBi13gunYe2D.jpg",
    episodeRunTime: [25],
    firstAirDate: DateTime(2007, 2, 15),
    genres: [
      Genre(id: 16, name: "Animation"),
      Genre(id: 10759, name: "Action & Adventure"),
      Genre(id: 10765, name: "Sci-Fi & Fantasy")
    ],
    homepage: "http://www.tv-tokyo.co.jp/anime/naruto/",
    id: 31910,
    inProduction: false,
    languages: ["ja"],
    lastAirDate: DateTime(2017, 3, 23),
    name: "Naruto Shippūden",
    numberOfEpisodes: 500,
    numberOfSeasons: 20,
    originCountry: ["JP"],
    originalLanguage: "ja",
    originalName: "ナルト 疾風伝",
    overview: "After 2 and a half years Naruto finally returns to his village of Konoha, and sets about putting his ambitions to work. It will not be easy though as he has amassed a few more dangerous enemies, in the likes of the shinobi organization; Akatsuki.",
    popularity: 169.833,
    posterPath: "/kV27j3Nz4d5z8u6mN3EJw9RiLg2.jpg",
    seasons: [
      Season(
          airDate: DateTime(2008, 2, 5),
          episodeCount: 3,
          id: 43372,
          name: "Specials",
          overview: "Collection of Naruto shorts.",
          posterPath: "/cXu0QVcW1cpVLJuLEdIzVORCVJP.jpg",
          seasonNumber: 0,
          voteAverage: 0
      ),
      Season(
          airDate: DateTime(2007, 2, 15),
          episodeCount: 32,
          id: 43373,
          name: "Kazekage Rescue",
          overview: "Naruto Uzumaki is back! After two and a half years of training on the road with Jiraiya of the Sannin, Naruto is back in the Village Hidden in the Leaves and he's ready to show off his new skills. He and Sakura team up to take on their old master Kakashi, who's pretty impressed with their progress. They'll have plenty of opportunity to put it into action when news arrives from the Sand Village that Gaara, Naruto's former rival and now Kazekage of the Sand, has been kidnapped! And the culprits are the very same group who are after Naruto - the Akatsuki!",
          posterPath: "/842myobV2MkoHZuoyxJDV9gdkvb.jpg",
          seasonNumber: 1,
          voteAverage: 7.7
      ),
      // seasons berikutnya
    ],
    status: "Ended",
    tagline: "Believe it!",
    type: "Scripted",
    voteAverage: 8.55,
    voteCount: 7950
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistTvSeries = TvShow.watchlist(
    id: 31910, name: 'Naruto Shippūden',
    posterPath: '/kV27j3Nz4d5z8u6mN3EJw9RiLg2.jpg',
    overview: 'After 2 and a half years Naruto finally returns to his village of Konoha, and sets about putting his ambitions to work. It will not be easy though as he has amassed a few more dangerous enemies, in the likes of the shinobi organization; Akatsuki.'
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeriesTable = TvShowTable(
    id: 31910, name: 'Naruto Shippūden',
    posterPath: '/kV27j3Nz4d5z8u6mN3EJw9RiLg2.jpg',
    overview: 'After 2 and a half years Naruto finally returns to his village of Konoha, and sets about putting his ambitions to work. It will not be easy though as he has amassed a few more dangerous enemies, in the likes of the shinobi organization; Akatsuki.'
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvSeriesMap = {
  'id' : 31910,
  'overview': 'After 2 and a half years Naruto finally returns to his village of Konoha, and sets about putting his ambitions to work. It will not be easy though as he has amassed a few more dangerous enemies, in the likes of the shinobi organization; Akatsuki.',
  'posterPath': '/kV27j3Nz4d5z8u6mN3EJw9RiLg2.jpg',
  'name': 'Naruto Shippūden'
};
