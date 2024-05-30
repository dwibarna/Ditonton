import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_search_tv_show.dart';
import 'package:ditonton/presentation/provider/tv_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_notifier_test.mocks.dart';

@GenerateMocks([GetSearchTvShow])
void main() {
  late TvSearchNotifier provider;
  late MockGetSearchTvShow mockGetSearchTvShow;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetSearchTvShow = MockGetSearchTvShow();
    provider = TvSearchNotifier(searchTvShow: mockGetSearchTvShow)
      ..addListener(() {
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
  final dummyQuery = "naruto";

  group('search tv series', () {
    test('should change state to loading when usecase is called', () async {

      when(mockGetSearchTvShow.execute(dummyQuery))
          .thenAnswer((_) async => Right(dummyTvSeries));

      provider.fetchTvSeriesSearch(dummyQuery);

      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
            () async {

          when(mockGetSearchTvShow.execute(dummyQuery))
              .thenAnswer((_) async => Right(dummyTvSeries));

          await provider.fetchTvSeriesSearch(dummyQuery);

          expect(provider.state, RequestState.Loaded);
          expect(provider.list, dummyTvSeries);
          expect(listenerCallCount, 2);
        });

    test('should return error when data is unsuccessful', () async {

      when(mockGetSearchTvShow.execute(dummyQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchTvSeriesSearch(dummyQuery);

      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
