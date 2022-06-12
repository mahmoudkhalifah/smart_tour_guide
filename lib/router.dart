import 'package:app/business_logic/cubit/places_cubit.dart';
import 'package:app/business_logic/cubit/statues_cubit.dart';
import 'package:app/data/api/places_api.dart';
import 'package:app/data/api/statues_api.dart';
import 'package:app/data/repository/statues_repository.dart';
import 'package:app/presentation/screens/forgot_password/forgot_password_screen.dart';
import 'package:app/presentation/screens/login_signup/login_signup_screen.dart';
import 'package:app/presentation/screens/place_info/place_info_screen.dart';
import 'package:app/presentation/screens/splash/splash_screen.dart';
import 'package:app/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repository/places_repository.dart';
import 'presentation/screens/home/home_screen.dart';
import 'presentation/screens/statue_info/statue_info_screen.dart';
import 'presentation/screens/statues/statues_screen.dart';

class AppRoute{

  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name){

      case splashViewRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case loginViewRoute:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );

      case forgotPasswordViewRoute:
        return MaterialPageRoute(
          builder: (context) => ForgotPasswordScreen(),
        );

      case homeViewRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => PlacesCubit(
                  PlacesRepository(PlacesAPI()),
              ),
              child: const HomeScreen(),
            ),
        );

      case placeInfoViewRoute:
        final args = settings.arguments as PlaceInfoScreen;
        return MaterialPageRoute(
          builder: (context) => PlaceInfoScreen(
            place: args.place,
          ),
        );

      case statuesViewRoute:
        final args = settings.arguments as StatuesScreeen;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) =>
                  StatuesCubit(StatuesRepository(StatuesAPI())),
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
          throw const FormatException('Route Not Found');

    }
  }
}