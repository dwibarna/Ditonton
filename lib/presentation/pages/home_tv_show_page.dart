import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/now_airing_tv_show_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_show_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_show_page.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/provider/tv_show_list_notifier.dart';
import 'package:ditonton/presentation/widgets/build_sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/tv_show.dart';
import 'about_page.dart';

class HomeTvShowPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tv';
  @override
  State<HomeTvShowPage> createState() => _HomeTvShowPageState();
}

class _HomeTvShowPageState extends State<HomeTvShowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
                accountName: Text('Ditonton'),
                accountEmail: Text('dwibarna@gmail.com')
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushReplacementNamed(context, HomeMoviePage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('TV Show'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(
                    context,
                    WatchlistMoviesPage.ROUTE_NAME,
                    arguments: WatchlistMoviesPage.TV_TYPE
                );
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(
                    context,
                    SearchPage.ROUTE_NAME,
                    arguments: SearchPage.TV_TYPE
                );
              },
              icon: Icon(Icons.search)
          )
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
/*              Text(
                'Now Airing',
                style: kHeading6,
              ),*/

            buildSubHeading(title: "Now Airing", onTap: () => Navigator.pushNamed(context, NowAiringTvShowPage.ROUTE_NAME)),
              Consumer<TvShowListNotifier>(
                  builder: (context, data, child) {
                    final state = data.nowAiringTvShowState;
                    if (state == RequestState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state == RequestState.Loaded) {
                      return TvShowList(tvShows: data.nowAiringTvShows,);
                    } else {
                      return Text('Failed');
                    }
                  }
              ),
              buildSubHeading(
                  title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, TopRatedShowPage.ROUTE_NAME),
              ),
              Consumer<TvShowListNotifier>(
                  builder: (context, data, _) {
                    final state = data.topRatedTvShowsState;
                    if (state == RequestState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state == RequestState.Loaded) {
                      return TvShowList(tvShows: data.topRatedTvShow);
                    } else {
                      return Text('Failed');
                    }
                  }
              ),
              buildSubHeading(
                  title: 'Popular',
                  onTap: () => Navigator.pushNamed(context, PopularTvShowPage.ROUTE_NAME),
              ),
              Consumer<TvShowListNotifier>(
                  builder: (context, data, _) {
                    final state = data.popularTvState;
                    if (state == RequestState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state == RequestState.Loaded) {
                      return TvShowList(tvShows: data.popularTvShows,);
                    } else {
                      return Text('Failed');
                    }
                  }
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    Future.microtask(
        () => Provider.of<TvShowListNotifier>(context, listen: false)
            ..fetchOnAiringTvShows()
            ..fetchTopRatedTvShows()
            ..fetchPopularTvShows()
    );
    super.initState();
  }
}

class TvShowList extends StatelessWidget {
  final List<TvShow> tvShows;

  const TvShowList({required this.tvShows});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
          itemBuilder: (context, idx) {
            final tvShow = tvShows[idx];
            return Container(
              padding: EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                      context,
                      TvSeriesDetailPage.ROUTE_NAME,
                    arguments: tvShow.id
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  child: CachedNetworkImage(
                      imageUrl: '$BASE_IMAGE_URL${tvShow.posterPath}',
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            );
          },
        itemCount: tvShows.length,
      ),
    );
  }
}