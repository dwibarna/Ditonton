import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ditonton'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/circle-g.png',
              width: 256,
            ),
            Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
                          },
                          child: Text('Movie'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white70
                          )
                      ),
                      SizedBox(height: 16,),
                      ElevatedButton(
                          onPressed: () {},
                          child: Text('TV Show'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white70
                          )
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}