
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),

            child :ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Favourites',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  leading: Icon(Icons.favorite,
                    color: Colors.red,),
                ),
                const Divider(
                  height: 20,
                  thickness: 0.5,
                  indent: 20,
                  endIndent: 0,
                  color: Colors.grey,
                ),
                ListTile(
                  title: Text('Visited Places',
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
                  thickness: 0.5,
                  indent: 20,
                  endIndent: 0,
                  color: Colors.grey,
                ),
                ListTile(
                  title: Text('Settings',
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
                  thickness: 0.5,
                  indent: 20,
                  endIndent: 0,
                  color: Colors.grey,
                ),
                ListTile(
                  title: Text('About',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  leading: Icon(Icons.error_outline),
                ),
                const Divider(
                  height: 25,
                  thickness: 0.7,
                  indent: 20,
                  endIndent: 0,
                  color: Colors.grey,
                ),
                ListTile(
                  title: Text('Logout',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  leading: Icon(Icons.logout,
                    color: Colors.blue,),
                ),
              ],)
        ),),
    );
  }
}
