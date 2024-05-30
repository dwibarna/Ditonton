import 'package:ditonton/domain/usecases/get_watchlist_tv_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvState usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetWatchlistTvState(repository: mockTvShowRepository);
  });

  test('should get watchlist status from repository', () async {
    when(mockTvShowRepository.isAddedTvToWatchList(1))
        .thenAnswer((_) async => true);

    final result = await usecase.execute(1);

    expect(result, true);
  });
}
