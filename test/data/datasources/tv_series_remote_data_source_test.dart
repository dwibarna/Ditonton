import 'dart:convert';
import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/models/tv_detail_response.dart';
import 'package:ditonton/data/models/tv_show_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvSeriesRemoteDataSourceImpl dataSourceImpl;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourceImpl = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get On Airing Tv Series', () {
    final dummyList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/on_airing_tv_series.json')))
        .tvShowList;

    test('should return list of Tv Series Model when response code is 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/on_airing_tv_series.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));

      final result = await dataSourceImpl.getOnAirTvShows();
      expect(result, equals(dummyList));
    });

    test('should throw a ServerException when the response code 400', () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Bad Request', 400));

      final result = dataSourceImpl.getOnAirTvShows();
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });

  group('get On Popular Tv Series', () {
    final dummyList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/popular_tv_series.json')))
        .tvShowList;

    test('should return list of Tv Series Model when response code is 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/popular_tv_series.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));

      final result = await dataSourceImpl.getPopularTvShows();
      expect(result, equals(dummyList));
    });

    test('should throw a ServerException when the response code 400', () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Bad Request', 400));

      final result = dataSourceImpl.getPopularTvShows();
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });

  group('search tv series', () {
    final tSearchResult = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/search_naruto_tv_series.json')))
        .tvShowList;
    final dummyQuery = 'naruto';

    test('should return list of search tv series when response code is 200',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?query=$dummyQuery&$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/search_naruto_tv_series.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));

      final result = await dataSourceImpl.getSearchTvShows(dummyQuery);

      expect(result, tSearchResult);
    });

    test('should throw a ServerException when the response code 400', () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?query=$dummyQuery&$API_KEY')))
          .thenAnswer((_) async => http.Response('Bad Request', 400));

      final result = dataSourceImpl.getSearchTvShows(dummyQuery);
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });

  group('get On Top Rated Tv Series', () {
    final dummyList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated_tv_series.json')))
        .tvShowList;

    test('should return list of Tv Series Model when response code is 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/top_rated_tv_series.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));

      final result = await dataSourceImpl.getTopRatedTvShows();
      expect(result, equals(dummyList));
    });

    test('should throw a ServerException when the response code 400', () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Bad Request', 400));

      final result = dataSourceImpl.getTopRatedTvShows();
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });

  group('get tv series detail', () {
    final dummyId = 31910;
    final dummyDetail = TvDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_series_detail.json')));

    test('should return tv series detail when the response code is 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$dummyId?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_series_detail.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));

      final result = await dataSourceImpl.getTvSeriesDetail(dummyId);

      expect(result, dummyDetail);
    });

    test('should throw Server Exception when the response code is 400 ',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$dummyId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Bad Request', 400));

      final call = dataSourceImpl.getTvSeriesDetail(dummyId);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get On Recommendations Tv Series', () {
    final dummyList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_recommendations.json')))
        .tvShowList;
    final dummyId = 31910;

    test('should return list of Tv Series Model when response code is 200',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$dummyId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_series_recommendations.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));

      final result = await dataSourceImpl.getTvSeriesRecommendation(dummyId);
      expect(result, equals(dummyList));
    });

    test('should throw a ServerException when the response code 400', () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$dummyId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Bad Request', 400));

      final result = dataSourceImpl.getTvSeriesRecommendation(dummyId);
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });
}
