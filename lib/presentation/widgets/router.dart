import 'package:app/business_logic/cubit/places_cubit.dart';
import 'package:app/data/api/places_api.dart';
import 'package:app/data/models/place.dart';
import 'package:app/presentation/screens/forgot_password/forgot_password_screen.dart';
import 'package:app/presentation/screens/login_signup/login_signup_screen.dart';
import 'package:app/presentation/screens/place_info/place_info_screen.dart';
import 'package:app/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/places_repository.dart';
import '../screens/home/home_screen.dart';
import '../screens/statue_info/statue_info_screen.dart';
import '../screens/statues/statues_screen.dart';

class AppRoute{
  static const String splashViewRoute = '/';
  static const String loginViewRoute = '/login';
  static const String forgotPasswordViewRoute = '/forget';
  static const String homeViewRoute = '/home';
  static const String placeInfoViewRoute = '/placeInfoView';
  static const String statueInfoViewRoute = '/statueInfo';
  static const String statuesViewRoute = '/statues';


  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name){

      case splashViewRoute:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );

      case loginViewRoute:
        return MaterialPageRoute(
          builder: (context)=> LoginScreen(),
        );

      case forgotPasswordViewRoute:
        return MaterialPageRoute(
          builder: (context)=> ForgotPasswordScreen(),
        );

      case homeViewRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context)=> PlacesCubit(
                  PlacesRepository(PlacesAPI()),
              ),
              child: HomeScreen(),
            ),
        );

      case placeInfoViewRoute:
        final args = settings.arguments as PlaceInfoScreen;
        return MaterialPageRoute(
          builder: (context)=> PlaceInfoScreen(
            place: args.place,
          ),
        );

      case statuesViewRoute:
        final args = settings.arguments as StatuesScreeen;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) =>
                  PlacesCubit(PlacesRepository(PlacesAPI())),
              child: StatuesScreeen(
                placeId: args.placeId,
                title: args.title,
              ),
            )
        );

      case statueInfoViewRoute:
        final args = settings.arguments as StatueInfoScreen;
        return MaterialPageRoute(
          builder: (context)=> StatueInfoScreen(
            statue: args.statue,
          ),
        );

        default:
          throw FormatException('Route Not Found');

    }
  }
}