import 'package:ditonton/data/models/tv_show_model.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvModel = TvShowModel(
      backdropPath: "/mpsYIytXhDXjI9yYC1Fp1S3PxsS.jpg",
      genreIds: [
        16,
        10759,
        10765
      ],
      id: 46260,
      originalName: "ナルト",
      overview: "Naruto Uzumaki, a mischievous adolescent ninja, struggles as he searches for recognition and dreams of becoming the Hokage, the village's leader and strongest ninja.",
      popularity: 270.255,
      posterPath: "/xppeysfvDKVx775MFuH8Z9BlpMk.jpg",
      name: "Naruto",
      voteAverage: 8.357,
      voteCount: 5360,
  );

  final tTvShow =
      TvShow(
          backdropPath: "/mpsYIytXhDXjI9yYC1Fp1S3PxsS.jpg",
          genreIds: [
            16,
            10759,
            10765
          ],
          id: 46260,
          originalName: "ナルト",
          overview: "Naruto Uzumaki, a mischievous adolescent ninja, struggles as he searches for recognition and dreams of becoming the Hokage, the village's leader and strongest ninja.",
          popularity: 270.255,
          posterPath: "/xppeysfvDKVx775MFuH8Z9BlpMk.jpg",
          name: "Naruto",
          voteAverage: 8.357,
          voteCount: 5360,

      );

  test('should be subclass of Tv Series Entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTvShow);
  });
}