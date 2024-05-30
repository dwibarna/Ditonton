import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_detail_response.dart';
import 'package:ditonton/data/models/tv_show_model.dart';
import 'package:ditonton/data/repositories/tv_show_repository_impl.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowRepositoryImpl tvShowRepositoryImpl;
  late MockTvShowDataSource mockTvShowDataSource;
  late MockTvLocalDataSource mockTvLocalDataSource;

  setUp(() {
    mockTvLocalDataSource = MockTvLocalDataSource();
    mockTvShowDataSource = MockTvShowDataSource();
    tvShowRepositoryImpl = TvShowRepositoryImpl(
        remoteDataSource: mockTvShowDataSource,
        tvLocalDataSource: mockTvLocalDataSource
    );
  });

  final dummyModel = TvShowModel(
      backdropPath: "/cQ7obD9zptMqtmmwBi13gunYe2D.jpg",
      genreIds: [16, 10759, 10765],
      id: 31910,
      originalName: "ナルト 疾風伝",
      overview:
          "After 2 and a half years Naruto finally returns to his village of Konoha, and sets about putting his ambitions to work. It will not be easy though as he has amassed a few more dangerous enemies, in the likes of the shinobi organization; Akatsuki.",
      popularity: 174.02,
      posterPath: "/xppeysfvDKVx775MFuH8Z9BlpMk.jpg",
      name: "Naruto",
      voteAverage: 8.6,
      voteCount: 7947,);

  final dummyTv = TvShow(
      backdropPath: "/cQ7obD9zptMqtmmwBi13gunYe2D.jpg",
      genreIds: [16, 10759, 10765],
      id: 31910,
      originalName: "ナルト 疾風伝",
      overview:
          "After 2 and a half years Naruto finally returns to his village of Konoha, and sets about putting his ambitions to work. It will not be easy though as he has amassed a few more dangerous enemies, in the likes of the shinobi organization; Akatsuki.",
      popularity: 174.02,
      posterPath: "/xppeysfvDKVx775MFuH8Z9BlpMk.jpg",
      name: "Naruto",
      voteAverage: 8.6,
      voteCount: 7947,);

  final dummyDetailResponse = TvDetailResponse(

      adult: false,
      backdropPath: "/cQ7obD9zptMqtmmwBi13gunYe2D.jpg",
      episodeRunTime: [25],
      firstAirDate: DateTime(2007, 2, 15),
      genres: [
        GenreModel(id: 16, name: "Animation"),
        GenreModel(id: 10759, name: "Action & Adventure"),
        GenreModel(id: 10765, name: "Sci-Fi & Fantasy")
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
        SeasonModel(
            airDate: DateTime(2008, 2, 5),
            episodeCount: 3,
            id: 43372,
            name: "Specials",
            overview: "Collection of Naruto shorts.",
            posterPath: "/cXu0QVcW1cpVLJuLEdIzVORCVJP.jpg",
            seasonNumber: 0,
            voteAverage: 0
        ),
        SeasonModel(
            airDate: DateTime(2007, 2, 15),
            episodeCount: 32,
            id: 43373,
            name: "Kazekage Rescue",
            overview: "Naruto Uzumaki is back! After two and a half years of training on the road with Jiraiya of the Sannin, Naruto is back in the Village Hidden in the Leaves and he's ready to show off his new skills. He and Sakura team up to take on their old master Kakashi, who's pretty impressed with their progress. They'll have plenty of opportunity to put it into action when news arrives from the Sand Village that Gaara, Naruto's former rival and now Kazekage of the Sand, has been kidnapped! And the culprits are the very same group who are after Naruto - the Akatsuki!",
            posterPath: "/842myobV2MkoHZuoyxJDV9gdkvb.jpg",
            seasonNumber: 1,
            voteAverage: 7.7
        ),
      ],
      status: "Ended",
      tagline: "Believe it!",
      type: "Scripted",
      voteAverage: 8.55,
      voteCount: 7950
  );


  final dummyId = 31910;
  final dummyModelList = <TvShowModel>[dummyModel];
  final dummyList = <TvShow>[dummyTv];
  final dummyRecommendList = <TvShowModel>[];
  final dummyQuery = 'naruto';

  group('On Airing Tv Series', () {
    test('should return remote data when call remote data source is successful',
        () async {
      when(mockTvShowDataSource.getOnAirTvShows())
          .thenAnswer((_) async => dummyModelList);

      final result = await tvShowRepositoryImpl.getNowAiringTvShows();

      verify(mockTvShowDataSource.getOnAirTvShows());

      final resultList = result.getOrElse(() => []);
      expect(resultList, dummyList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      when(mockTvShowDataSource.getOnAirTvShows()).thenThrow(ServerException());

      final result = await tvShowRepositoryImpl.getNowAiringTvShows();

      verify(mockTvShowDataSource.getOnAirTvShows());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
          when(mockTvShowDataSource.getOnAirTvShows())
              .thenThrow(SocketException('Failed to connect to the network'));

          final result = await tvShowRepositoryImpl.getNowAiringTvShows();

          verify(mockTvShowDataSource.getOnAirTvShows());
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('On Popular Tv Series', () {
    test('should return remote data when call remote data source is successful',
        () async {
      when(mockTvShowDataSource.getPopularTvShows())
          .thenAnswer((_) async => dummyModelList);

      final result = await tvShowRepositoryImpl.getPopularTvShows();

      verify(mockTvShowDataSource.getPopularTvShows());

      final resultList = result.getOrElse(() => []);
      expect(resultList, dummyList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      when(mockTvShowDataSource.getPopularTvShows())
          .thenThrow(ServerException());

      final result = await tvShowRepositoryImpl.getPopularTvShows();

      verify(mockTvShowDataSource.getPopularTvShows());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      when(mockTvShowDataSource.getPopularTvShows())
          .thenThrow(SocketException('Failed to connect to the network'));

      final result = await tvShowRepositoryImpl.getPopularTvShows();

      verify(mockTvShowDataSource.getPopularTvShows());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('On Top Rated Tv Series', () {
    test('should return remote data when call remote data source is successful',
        () async {
      when(mockTvShowDataSource.getTopRatedTvShows())
          .thenAnswer((_) async => dummyModelList);

      final result = await tvShowRepositoryImpl.getTopRatedTvShows();

      verify(mockTvShowDataSource.getTopRatedTvShows());

      final resultList = result.getOrElse(() => []);
      expect(resultList, dummyList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      when(mockTvShowDataSource.getTopRatedTvShows())
          .thenThrow(ServerException());

      final result = await tvShowRepositoryImpl.getTopRatedTvShows();

      verify(mockTvShowDataSource.getTopRatedTvShows());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      when(mockTvShowDataSource.getTopRatedTvShows())
          .thenThrow(SocketException('Failed to connect to the network'));

      final result = await tvShowRepositoryImpl.getTopRatedTvShows();

      verify(mockTvShowDataSource.getTopRatedTvShows());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Series Detail', () {

    test(
        'should return Tv Series data when the call to remote data source is successful',
            () async {

          when(mockTvShowDataSource.getTvSeriesDetail(dummyId))
              .thenAnswer((_) async => dummyDetailResponse
          );

          final result = await tvShowRepositoryImpl.getTvDetail(dummyId);

          verify(mockTvShowDataSource.getTvSeriesDetail(dummyId));
          expect(result, equals(Right(testTvShowDetail)));
        });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
            () async {

          when(mockTvShowDataSource.getTvSeriesDetail(dummyId))
              .thenThrow(ServerException());

          final result = await tvShowRepositoryImpl.getTvDetail(dummyId);

          verify(mockTvShowDataSource.getTvSeriesDetail(dummyId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockTvShowDataSource.getTvSeriesDetail(dummyId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await tvShowRepositoryImpl.getTvDetail(dummyId);
          // assert
          verify(mockTvShowDataSource.getTvSeriesDetail(dummyId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Get Tv Series Recommendations', () {
    test('should return data when the call is successful', () async {
      when(mockTvShowDataSource.getTvSeriesRecommendation(dummyId))
          .thenAnswer((_) async => dummyRecommendList);

      final result =
          await tvShowRepositoryImpl.getTvSeriesRecommendations(dummyId);

      verify(mockTvShowDataSource.getTvSeriesRecommendation(dummyId));

      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(dummyRecommendList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      when(mockTvShowDataSource.getTvSeriesRecommendation(dummyId))
          .thenThrow(ServerException());

      final result =
          await tvShowRepositoryImpl.getTvSeriesRecommendations(dummyId);

      verify(mockTvShowDataSource.getTvSeriesRecommendation(dummyId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      when(mockTvShowDataSource.getTvSeriesRecommendation(dummyId))
          .thenThrow(SocketException('Failed to connect to the network'));

      final result =
          await tvShowRepositoryImpl.getTvSeriesRecommendations(dummyId);

      verify(mockTvShowDataSource.getTvSeriesRecommendation(dummyId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Tv Series', () {
    test('should return list when call to data source is successful', () async {
      when(mockTvShowDataSource.getSearchTvShows(dummyQuery))
          .thenAnswer((_) async => dummyRecommendList);

      final result = await tvShowRepositoryImpl.getSearchTvShows(dummyQuery);
      final resultList = result.getOrElse(() => []);
      expect(resultList, dummyRecommendList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      when(mockTvShowDataSource.getSearchTvShows(dummyQuery))
          .thenThrow(ServerException());

      final result = await tvShowRepositoryImpl.getSearchTvShows(dummyQuery);

      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      when(mockTvShowDataSource.getSearchTvShows(dummyQuery))
          .thenThrow(SocketException('Failed to connect to the network'));

      final result = await tvShowRepositoryImpl.getSearchTvShows(dummyQuery);

      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      when(mockTvLocalDataSource.insertWatchlistTvSeries(testTvSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');

      final result =
          await tvShowRepositoryImpl.addTvWatchList(testTvShowDetail);

      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      when(mockTvLocalDataSource.insertWatchlistTvSeries(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));

      final result =
          await tvShowRepositoryImpl.addTvWatchList(testTvShowDetail);

      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      when(mockTvLocalDataSource.removeWatchlistTvSeries(testTvSeriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');

      final result =
          await tvShowRepositoryImpl.removeTvWatchList(testTvShowDetail);

      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      when(mockTvLocalDataSource.removeWatchlistTvSeries(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));

      final result =
          await tvShowRepositoryImpl.removeTvWatchList(testTvShowDetail);

      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      when(mockTvLocalDataSource.getTvShowById(dummyId))
          .thenAnswer((_) async => null);

      final result = await tvShowRepositoryImpl.isAddedTvToWatchList(dummyId);

      expect(result, false);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of tv series', () async {
      when(mockTvLocalDataSource.getTvSeriesWatchlist())
          .thenAnswer((_) async => [testTvSeriesTable]);

      final result = await tvShowRepositoryImpl.getWatchlistTvSeries();

      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvSeries]);
    });
  });
}
