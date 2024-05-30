import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_shows_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedShowPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-show';

  @override
  State<TopRatedShowPage> createState() => _TopRatedShowPageState();
}

class _TopRatedShowPageState extends State<TopRatedShowPage> {
  @override
  void initState() {
    Future.microtask(
        () => Provider.of<TopRatedTvShowsNotifier>(context, listen: false).fetchPopularTvShows()
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Consumer<TopRatedTvShowsNotifier>(
          builder: (context, data, _) {
            if (data.state == RequestState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                  itemBuilder: (context, idx) {
                    final tvShow = data.list[idx];
                    return TvSeriesCard(tvShow);
                  },
                itemCount: data.list.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
