import 'package:flutter/material.dart';
import 'package:movies/browse_tab/MoviesListDetails/browse_details.dart';
import 'package:movies/browse_tab/cubit/browse_cubit.dart';
import 'package:movies/browse_tab/movie_details.dart';
import 'package:movies/home_screen/cubit/home_tab_cubit.dart';
import 'package:movies/home_screen/home_details/Movie_details.dart';
import 'package:movies/home_screen/home_details/cubit/movie_details_cubit.dart';
import 'package:movies/home_screen/newrelease_details.dart';
import 'package:movies/home_screen/recommended_details.dart';
import 'package:movies/main_page/main_page.dart';
import 'package:movies/my_theme_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/splash_screen.dart';
import 'package:movies/watchlist_screen/cubit/watchlist_viewmodel.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => HomeTabCubit()),
      BlocProvider(create: (context)=> MoviesViewModel()),
      BlocProvider(create: (context)=> WatchlistViewModel(),)
    ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routename ,
      routes: {
      MovieDetails.routename : (context) => MovieDetails(),
       SplashScreen.routename : (context) => SplashScreen(),
       MainPage.routename : (context) => MainPage(),
        BrowseDetails.routename : (context) => BrowseDetails(),
        MovieDetailsInBrowse.routename : (context) => MovieDetailsInBrowse(),
       NewReleaseDetails.routename : (context) => NewReleaseDetails(),
        RecommendedDetails.routename : (context) => RecommendedDetails()
      },
      theme: MyThemeData.LightTheme,
    );
  }
}
