import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'movie.dart';
import 'loading.dart';
import 'something_went_wrong.dart';


class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final String _nameOfUser = FirebaseAuth.instance.currentUser!.displayName ?? "";
  final Future<String> _moviesString = loadJSON();
  List<Movie> _movies=[];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(

      future: _moviesString,
      builder: (context, snapshot){

        if(snapshot.hasError){
          return const SomethingWentWrong();
        }

        if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
          _movies = (json.decode(snapshot.data as String) as List).map((i) => Movie.fromJson(i)).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  "Logged in as " + _nameOfUser,
                style: const TextStyle(
                  fontSize: 15.0
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(FontAwesomeIcons.signOutAlt),
                  onPressed: () async{
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  tooltip: "Log Out",
                ),
              ],
            ),
            body: GridView.builder(
              itemCount: _movies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(image: AssetImage("assets/movie-poster/" + _movies[index].getPosterUri())),
                        Text(
                            _movies[index].getTitle(),
                            overflow: TextOverflow.ellipsis,
                        ),
                        Text(_movies[index].getReleaseYear()),
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.pushNamed(context, 'AMovieDetailsScreen', arguments: _movies[index]);
                  },
                );
              },
            ),
          );
        }
        return const Loading();
      },
    );
  }




  static Future<String> loadJSON() async {

      return await rootBundle.loadString('assets/json/movies.json');

  }

}