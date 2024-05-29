import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/genre.dart';
import '../../domain/entities/tv_show.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  TvSeriesDetailPage({required this.id});

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {

  @override
  void initState() {
    Future.microtask(() {
      Provider.of<TvDetailNotifier>(context, listen: false)
          ..fetchTvSeriesDetail(widget.id)
          ..loadTvWatchListState(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvDetailNotifier>(
        builder: (context, provider, _) {
          if(provider.state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(provider.state == RequestState.Loaded) {
            final tvSeries = provider.tvDetail;
            return SafeArea(
                child: DetailContent(
                  tvDetail: tvSeries,
                  listRecommendations: provider.list,
                  stateWatchlist: provider.stateWatchlist,
                )
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetail tvDetail;
  final List<TvShow> listRecommendations;
  final bool stateWatchlist;

  const DetailContent({Key? key, required this.tvDetail, required this.listRecommendations, required this.stateWatchlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, _, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: kRichBlack,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16
                  ),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tvDetail.name,
                                style: kHeading5,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    var provider = Provider.of<TvDetailNotifier>(context, listen: false);
                                    final message = provider.watchlistMessage;

                                    if (!stateWatchlist) {
                                      await provider.addTvWatchList(tvDetail);
                                    } else {
                                      await provider.removeTvWatchList(tvDetail);
                                    }
                                    if (
                                    message == TvDetailNotifier.watchlistAddSuccessMessage ||
                                        message == TvDetailNotifier.watchlistRemoveSuccessMessage
                                    ) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(message))
                                      );
                                    } else {
                                      showDialog(context: context, builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      stateWatchlist
                                          ? Icon(Icons.check)
                                          : Icon(Icons.add),
                                      Text('Watchlist')
                                    ],
                                  )
                              ),
                              Text(
                                _showGenres(tvDetail.genres)
                              ),

                              tvDetail.episodeRunTime.isNotEmpty
                                  ? Text(_showDuration(tvDetail.episodeRunTime))
                                  : Container(),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                      itemBuilder: (context, idx) => Icon(
                                        Icons.star,
                                        color: kMikadoYellow
                                      ),
                                    rating: tvDetail.voteAverage / 2,
                                    itemSize: 24,
                                  ),
                                  Text('${tvDetail.voteAverage}')
                                ],
                              ),
                              SizedBox(height: 16,),
                              Text(
                                tvDetail.overview,
                                style: kHeading6,
                              ),
                              SizedBox(height: 16,),
                              Text(
                                'Recommendations',
                                style: kHeading6,
                              ),
                              Consumer<TvDetailNotifier>(
                                builder: (context, data, _) {
                                  if (data.recState == RequestState.Loading) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (data.recState == RequestState.Error) {
                                    return Text(data.message);
                                  } else if (data.recState == RequestState.Loaded) {
                                    return Container(
                                      height: 150,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, idx) {
                                          final tvShow = listRecommendations[idx];
                                          return Padding(
                                              padding: const EdgeInsets.all(4),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pushReplacementNamed(
                                                    context,
                                                    TvSeriesDetailPage.ROUTE_NAME,
                                                  arguments: tvShow.id
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(Radius.circular(8),
                                                ),
                                                child: CachedNetworkImage(
                                                    imageUrl: 'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
                                                  placeholder: (context, url) => Center(
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                  errorWidget: (context, _, error) => Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: listRecommendations.length,
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          color: Colors.white,
                          height: 4,
                          width: 48,
                        ),
                      )
                    ],
                  ),
                );
              },
            minChildSize: 0.25,
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back)
            ),
          ),
        )
      ],
    );
  }


  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(List<int> runtime) {
    int tempTime = 0;
    runtime.forEach((t) {
      print("waktu : $t");
      tempTime += t;
    });
    final int time = tempTime ~/runtime.length;
    final int hours = time ~/ 60;
    final int minutes = time % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
