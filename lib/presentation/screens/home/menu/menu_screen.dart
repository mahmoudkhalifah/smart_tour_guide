// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app/localization/app_localizations.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 40),
      shrinkWrap: true,
      children: <Widget>[
        ListTile(
          title: Text(
            AppLocalizations.of(context).translate("favourite places"),
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
        const Divider(
          height: 20,
          thickness: 1,
          color: Colors.grey,
        ),
        ListTile(
          title: Text(
            AppLocalizations.of(context).translate("favourite statues"),
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
        const Divider(
          height: 20,
          thickness: 1,
          color: Colors.grey,
        ),
        ListTile(
          title: Text(
            AppLocalizations.of(context).translate("visited places"),
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: Icon(Icons.location_on),
        ),
        const Divider(
          height: 20,
          thickness: 1,
          color: Colors.grey,
        ),
        ListTile(
          title: Text(
            AppLocalizations.of(context).translate("settings"),
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: Icon(Icons.settings),
        ),
        const Divider(
          height: 20,
          thickness: 1,
          color: Colors.grey,
        ),
        ListTile(
          title: Text(
            AppLocalizations.of(context).translate("about"),
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: Icon(Icons.error_outline),
        ),
        const Divider(
          height: 20,
          thickness: 1,
          color: Colors.grey,
        ),
        ListTile(
          title: Text(
            AppLocalizations.of(context).translate("login"),
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: Icon(
            Icons.login,
            color: Colors.blue,
          ),
        ),
        const Divider(
          height: 20,
          thickness: 1,
          color: Colors.grey,
        ),
        ListTile(
          title: Text(
            AppLocalizations.of(context).translate("logout"),
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: Icon(
            Icons.logout,
            color: Colors.blue,
          ),
        ),
        const Divider(
          height: 20,
          thickness: 1,
          color: Colors.grey,
        ),
        ListTile(
          title: Row(
            children: [
              TextButton(
                  onPressed: () {
                    App.setLocale(context, Locale('ar'));
                  },
                  child: Text(
                    "AR",
                    style: TextStyle(),
                  )),
              TextButton(
                  onPressed: () {
                    App.setLocale(context, Locale('en'));
                  },
                  child: Text("EN"))
            ],
          ),
          leading: Icon(
            Icons.language,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
