import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/popular_tv_shows_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularTvShowPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-show';
  @override
  State<PopularTvShowPage> createState() => _PopularTvShowPageState();
}

class _PopularTvShowPageState extends State<PopularTvShowPage> {

  @override
  void initState() {
    Future.microtask(
        () => Provider.of<PopularTvShowsNotifier>(context, listen: false).fetchPopularTvShows()
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Series'),
      ),
      body: Padding(
          padding: EdgeInsets.all(8),
        child: Consumer<PopularTvShowsNotifier>(
          builder: (context, data, _) {
            if (data.state == RequestState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemCount: data.list.length,
                  itemBuilder: (context, idx) {
                    final tvShow = data.list[idx];
                    return TvSeriesCard(tvShow);
                  }
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