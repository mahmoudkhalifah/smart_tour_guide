import 'package:app/localization/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_offline/flutter_offline.dart';

class OfflineBuilderWidget extends StatelessWidget {
  const OfflineBuilderWidget({Key? key,required this.child,required this.isButton}) : super(key: key);
  final Widget child;
  final bool isButton;

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return connected ? child : !isButton ? Center(child: Text(AppLocalizations.of(context).translate("internet error"),textAlign: TextAlign.center,)):const SizedBox();
        },
        child: child
      );
  }
}