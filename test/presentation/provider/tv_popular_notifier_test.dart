import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_show.dart';
import 'package:ditonton/presentation/provider/popular_tv_shows_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks(
  [GetPopularTvShow]
)
void main() {
  late MockGetPopularTvShow mockGetPopularTvShow;
  late PopularTvShowsNotifier provider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTvShow = MockGetPopularTvShow();
    provider = PopularTvShowsNotifier(mockGetPopularTvShow)
    ..addListener(() {
      listenerCallCount ++;
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

  group('Popular TV Series', () {

    test('should change state to loading when usecase is called', () async {

      when(mockGetPopularTvShow.execute())
          .thenAnswer((_) async => Right(dummyTvSeries));

      provider.fetchPopularTvShows();

      expect(provider.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv series data when data is gotten successfully', () async {

      when(mockGetPopularTvShow.execute())
          .thenAnswer((_) async => Right(dummyTvSeries));

      await provider.fetchPopularTvShows();

      expect(provider.state, RequestState.Loaded);
      expect(provider.list, dummyTvSeries);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {

      when(mockGetPopularTvShow.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchPopularTvShows();

      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}