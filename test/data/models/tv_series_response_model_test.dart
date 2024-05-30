import 'dart:convert';

import 'package:ditonton/data/models/tv_show_model.dart';
import 'package:ditonton/data/models/tv_show_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final dummyTvModel = TvShowModel(
    backdropPath: "/eWF3oRyL4QWaidN9F4uvM7cBJUV.jpg",
    genreIds: [10766],
    id: 206559,
    originalName: "Binnelanders",
    overview:
        "A South African Afrikaans soap opera. It is set in and around the fictional private hospital, Binneland Kliniek, in Pretoria, and the storyline follows the trials, trauma and tribulations of the staff and patients of the hospital.",
    popularity: 3243.031,
    posterPath: "/v9nGSRx5lFz6KEgfmgHJMSgaARC.jpg",
    name: "Binnelanders",
    voteAverage: 5.392,
    voteCount: 60,
  );

  final dummyResponseModel = TvShowResponse(tvShowList: [dummyTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/popular_tv_series.json'));
      // act
      final result = TvShowResponse.fromJson(jsonMap);
      // assert
      expect(result, dummyResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = dummyResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/eWF3oRyL4QWaidN9F4uvM7cBJUV.jpg",
            "genre_ids": [10766],
            "id": 206559,
            "original_name": "Binnelanders",
            "overview":
                "A South African Afrikaans soap opera. It is set in and around the fictional private hospital, Binneland Kliniek, in Pretoria, and the storyline follows the trials, trauma and tribulations of the staff and patients of the hospital.",
            "popularity": 3243.031,
            "poster_path": "/v9nGSRx5lFz6KEgfmgHJMSgaARC.jpg",
            "name": "Binnelanders",
            "vote_average": 5.392,
            "vote_count": 60
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
