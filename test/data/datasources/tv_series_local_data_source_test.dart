import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvLocalDataSourceImpl tvLocalDataSourceImpl;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    tvLocalDataSourceImpl = TvLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('Save Tv Series Watchlist', () {
    test('should return success message when success to insert data to database', () async {

      when(mockDatabaseHelper.insertTvWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 31910);

      final result = await tvLocalDataSourceImpl.insertWatchlistTvSeries(testTvSeriesTable);
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when failed to insert data to database', () async {
      when(mockDatabaseHelper.insertTvWatchlist(testTvSeriesTable))
          .thenThrow(Exception());

      final result = tvLocalDataSourceImpl.insertWatchlistTvSeries(testTvSeriesTable);
      expect(() => result, throwsA(isA<DatabaseException>()));
    });
  });

  group('Remove Tv Series Watchlist', () {
    test('should return success message when success to remove data from database', () async {

      when(mockDatabaseHelper.removeTvWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 31910);

      final result = await tvLocalDataSourceImpl.removeWatchlistTvSeries(testTvSeriesTable);
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when failed to remove data from database', () async {
      when(mockDatabaseHelper.removeTvWatchlist(testTvSeriesTable))
          .thenThrow(Exception());

      final result = tvLocalDataSourceImpl.removeWatchlistTvSeries(testTvSeriesTable);
      expect(() => result, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tv Series by id', () {
    final dummyId = 31910;
    test('should return Tv Show detail from database', () async {

      when(mockDatabaseHelper.getTvSeriesById(dummyId))
          .thenAnswer((_) async => testTvSeriesMap);

      final result = await tvLocalDataSourceImpl.getTvShowById(dummyId);
      expect(result, testTvSeriesTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesById(dummyId)).thenAnswer((_) async => null);
      // act
      final result = await tvLocalDataSourceImpl.getTvShowById(dummyId);
      // assert
      expect(result, null);
    });
  });


  group('Get Tv Series Watchlist', () {
    test('should return Tv series list data from database', () async {

      when(mockDatabaseHelper.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvSeriesMap]);

      final result = await tvLocalDataSourceImpl.getTvSeriesWatchlist();
      expect(result, [testTvSeriesTable]);
    });
  });
}