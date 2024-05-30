import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvDetail usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetTvDetail(mockTvShowRepository);
  });

  final dummyId = 31910;

  test('should get Tv Series detail from the repository', () async {
    when(mockTvShowRepository.getTvDetail(dummyId))
        .thenAnswer((_) async => Right(testTvShowDetail));

    final result = await usecase.execute(dummyId);

    expect(result, Right(testTvShowDetail));
  });
}
