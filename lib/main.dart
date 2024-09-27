import 'package:flutter/material.dart';
import 'package:movies/browse_tab/MoviesListDetails/browse_details.dart';
import 'package:movies/browse_tab/cubit/browse_cubit.dart';
import 'package:movies/home_screen/cubit/home_tab_cubit.dart';
import 'package:movies/main_page/main_page.dart';
import 'package:movies/my_theme_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => HomeTabCubit()),
      BlocProvider(create: (context)=> MoviesViewModel())
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
       SplashScreen.routename : (context) => SplashScreen(),
       MainPage.routename : (context) => MainPage(),
        BrowseDetails.routename : (context) => BrowseDetails()
      },
      theme: MyThemeData.LightTheme,
    );
  }
}
