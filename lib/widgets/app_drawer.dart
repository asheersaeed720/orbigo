import 'package:flutter/material.dart';
import 'package:orbigo/screens/about_screen.dart';
import 'package:orbigo/screens/change_password_screen.dart';
import 'package:orbigo/screens/login_screen.dart';
import 'package:orbigo/screens/setting_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Consumer<AuthProvider>(
          //   builder: (_, authProvider, __) {
          //     return UserAccountsDrawerHeader(
          //       decoration: BoxDecoration(
          //           image: DecorationImage(
          //         fit: BoxFit.cover,
          //         image: AssetImage('./assets/images/header.jpg'),
          //       )),
          //       currentAccountPicture: CircleAvatar(
          //         backgroundImage:
          //             AssetImage('./assets/images/dummy_profile.png'),
          //       ),
          //       accountName: Text(
          //           '${authProvider.user['user']['first_name']} ${authProvider.user['user']['last_name']}'),
          //       accountEmail:
          //           Text('${authProvider.user['user']['user_mobile']}'),
          //     );
          //   },
          // ),
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('./assets/images/header.jpg'),
            )),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('./assets/images/dummy_profile.png'),
            ),
            accountName: Text('Username here'),
            accountEmail: Text('Email here'),
          ),

          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(LoginScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Setting"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(SettingScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text("Change Password"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(ChangePasswordScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(AboutScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.explicit),
            title: Text("Exit"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(LoginScreen.routeName);
            },
          ),
          Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
