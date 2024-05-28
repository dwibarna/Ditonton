import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/on_airing_tv_shows_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NowAiringTvShowPage extends StatefulWidget {
  static const ROUTE_NAME = '/airing-show';

  @override
  State<NowAiringTvShowPage> createState() => _NowAiringTvShowPageState();
}

class _NowAiringTvShowPageState extends State<NowAiringTvShowPage> {
  @override
  void initState() {
    Future.microtask(() =>
        Provider.of<OnAiringTvShowsNotifier>(context, listen: false)
            .fetchOnAiringTvShows());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On Air TV Series'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Consumer<OnAiringTvShowsNotifier>(
          builder: (context, data, _) {
            if (data.state == RequestState.Loading) {
              return CircularProgressIndicator();
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
