import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_now_airing_tv_show.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_show.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_show.dart';
import 'package:ditonton/presentation/provider/tv_show_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvShow, GetTopRatedTvShow, GetNowAiringTvShow])
void main() {
  late TvShowListNotifier provider;
  late MockGetNowAiringTvShow mockGetNowAiringTvShow;
  late MockGetPopularTvShow mockGetPopularTvShow;
  late MockGetTopRatedTvShow mockGetTopRatedTvShow;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowAiringTvShow = MockGetNowAiringTvShow();
    mockGetTopRatedTvShow = MockGetTopRatedTvShow();
    mockGetPopularTvShow = MockGetPopularTvShow();
    provider = TvShowListNotifier(
        getNowAiringTvShow: mockGetNowAiringTvShow,
        getTopRatedTvShow: mockGetTopRatedTvShow,
        getPopularTvShow: mockGetPopularTvShow
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

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
    voteCount: 7947,
  );

  final dummyTvSeries = <TvShow>[dummyTv];

  group('now airing tv series', () {
    test('initialState should be Empty', () {
      expect(provider.nowAiringTvShowState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {

      when(mockGetNowAiringTvShow.execute())
          .thenAnswer((_) async => Right(dummyTvSeries));

      provider.fetchOnAiringTvShows();

      verify(mockGetNowAiringTvShow.execute());
    });

    test('should change state to Loading when usecase is called', () {

      when(mockGetNowAiringTvShow.execute())
          .thenAnswer((_) async => Right(dummyTvSeries));

      provider.fetchOnAiringTvShows();

      expect(provider.nowAiringTvShowState, RequestState.Loading);
    });

    test('should change tv series when data is gotten successfully', () async {

      when(mockGetNowAiringTvShow.execute())
          .thenAnswer((_) async => Right(dummyTvSeries));

      await provider.fetchOnAiringTvShows();

      expect(provider.nowAiringTvShowState, RequestState.Loaded);
      expect(provider.nowAiringTvShows, dummyTvSeries);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {

      when(mockGetNowAiringTvShow.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchOnAiringTvShows();

      expect(provider.nowAiringTvShowState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv series', () {
    test('should change state to loading when usecase is called', () async {

      when(mockGetPopularTvShow.execute())
          .thenAnswer((_) async => Right(dummyTvSeries));

      provider.fetchPopularTvShows();

      expect(provider.popularTvState, RequestState.Loading);

    });

    test('should change tv series data when data is gotten successfully',
            () async {

          when(mockGetPopularTvShow.execute())
              .thenAnswer((_) async => Right(dummyTvSeries));

          await provider.fetchPopularTvShows();

          expect(provider.popularTvState, RequestState.Loaded);
          expect(provider.popularTvShows, dummyTvSeries);
          expect(listenerCallCount, 2);
        });

    test('should return error when data is unsuccessful', () async {

      when(mockGetPopularTvShow.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchPopularTvShows();

      expect(provider.popularTvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });


  group('top rated tv series', () {
    test('should change state to loading when usecase is called', () async {

      when(mockGetTopRatedTvShow.execute())
          .thenAnswer((_) async => Right(dummyTvSeries));

      provider.fetchTopRatedTvShows();

      expect(provider.topRatedTvShowsState, RequestState.Loading);
    });

    test('should change tv series data when data is gotten successfully',
            () async {

          when(mockGetTopRatedTvShow.execute())
              .thenAnswer((_) async => Right(dummyTvSeries));

          await provider.fetchTopRatedTvShows();

          expect(provider.topRatedTvShowsState, RequestState.Loaded);
          expect(provider.topRatedTvShow, dummyTvSeries);
          expect(listenerCallCount, 2);
        });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTvShow.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTvShows();
      // assert
      expect(provider.topRatedTvShowsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
