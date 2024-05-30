import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_state.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchlistTvState,
  SaveWatchlistTv,
  RemoveWatchlistTv
])
void main() {
  late TvDetailNotifier provider;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchlistTvState mockGetWatchlistTvState;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvDetail = MockGetTvDetail();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchlistTvState = MockGetWatchlistTvState();
    provider = TvDetailNotifier(
        getTvDetail: mockGetTvDetail,
        getTvRecommendations: mockGetTvRecommendations,
        removeWatchlistTv: mockRemoveWatchlistTv,
        saveWatchlistTv: mockSaveWatchlistTv,
        getWatchlistStateTv: mockGetWatchlistTvState
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

  final dummyId = 31910;

  final dummyTvSeries = <TvShow>[dummyTv];

  void _arrangeUseCase() {
    when(mockGetTvDetail.execute(dummyId))
        .thenAnswer((_) async => Right(testTvShowDetail));
    when(mockGetTvRecommendations.execute(dummyId))
        .thenAnswer((_) async => Right(dummyTvSeries));
  }

  group('Get Tv Detail', () {
    test('should get data from UseCase', () async {
      _arrangeUseCase();

      await provider.fetchTvSeriesDetail(dummyId);

      verify(mockGetTvDetail.execute(dummyId));
      verify(mockGetTvRecommendations.execute(dummyId));
    });
  });

  test('should change state to loading when UseCase is Called', () {
    _arrangeUseCase();

    provider.fetchTvSeriesDetail(dummyId);

    expect(provider.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });


  group('Get Tv Recommendations', () {
    test('should get data from UseCase', () async {
      _arrangeUseCase();

      await provider.fetchTvSeriesDetail(dummyId);

      verify(mockGetTvDetail.execute(dummyId));
      verify(mockGetTvRecommendations.execute(dummyId));
    });


    test('should update recommendation state when data is gotten successfully',
            () async {

          _arrangeUseCase();
          await provider.fetchTvSeriesDetail(dummyId);

          expect(provider.recState, RequestState.Loaded);
          expect(provider.list, dummyTvSeries);
        });

    test('should update error message when request in successful', () async {

      when(mockGetTvDetail.execute(dummyId))
          .thenAnswer((_) async => Right(testTvShowDetail));
      when(mockGetTvRecommendations.execute(dummyId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));

      await provider.fetchTvSeriesDetail(dummyId);

      expect(provider.recState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist TV State', ()  {
    test('should get the watchlist state', () async {

      when(mockGetWatchlistTvState.execute(3910)).thenAnswer((_) async => true);

      await provider.loadTvWatchListState(3910);

      expect(provider.stateWatchlist, true);
    });
  });

  test('should execute save watchlist when function called', () async {

    when(mockSaveWatchlistTv.execute(testTvShowDetail))
        .thenAnswer((_) async => Right('Success'));
    when(mockGetWatchlistTvState.execute(testTvShowDetail.id))
        .thenAnswer((_) async => true);

    await provider.addTvWatchList(testTvShowDetail);

    verify(mockSaveWatchlistTv.execute(testTvShowDetail));
  });

  test('should execute remove watchlist when function called', () async {

    when(mockRemoveWatchlistTv.execute(testTvShowDetail))
        .thenAnswer((_) async => Right('Removed'));
    when(mockGetWatchlistTvState.execute(testTvShowDetail.id))
        .thenAnswer((_) async => false);

    await provider.removeTvWatchList(testTvShowDetail);

    verify(mockRemoveWatchlistTv.execute(testTvShowDetail));
  });

  test('should update watchlist status when add watchlist success', () async {
    when(mockSaveWatchlistTv.execute(testTvShowDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    when(mockGetWatchlistTvState.execute(testTvShowDetail.id))
        .thenAnswer((_) async => true);

    await provider.addTvWatchList(testTvShowDetail);

    verify(mockGetWatchlistTvState.execute(testTvShowDetail.id));
    expect(provider.stateWatchlist, true);
    expect(provider.watchlistMessage, 'Added to Watchlist');
    expect(listenerCallCount, 1);
  });


  test('should update watchlist message when add watchlist failed', () async {

    when(mockSaveWatchlistTv.execute(testTvShowDetail))
        .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
    when(mockGetWatchlistTvState.execute(testTvShowDetail.id))
        .thenAnswer((_) async => false);

    await provider.addTvWatchList(testTvShowDetail);

    expect(provider.watchlistMessage, 'Failed');
    expect(listenerCallCount, 1);
  });


  group('on Error', () {
    test('should return error when data is unsuccessful', () async {

      when(mockGetTvDetail.execute(dummyId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvRecommendations.execute(dummyId))
          .thenAnswer((_) async => Right(dummyTvSeries));

      await provider.fetchTvSeriesDetail(dummyId);

      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

}
