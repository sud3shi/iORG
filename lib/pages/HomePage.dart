import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iorg_flutter/main.dart';
import 'package:iorg_flutter/pages/InitPage.dart';
import 'package:iorg_flutter/pages/LoggedOut.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  DateTime backButtonPressedTime;
  int _bottomNavIndex = 0;
  User _currentAuthUser;
  AnimationController _animationController;
  Animation<double> animation;
  CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    _currentAuthUser = FirebaseAuth.instance.currentUser;
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
      () => _animationController.forward(),
    );
  }

  void changePage(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentAuthUser == null) {
      return InitPage();
    }
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: _appBar(context),
        drawer: _drawer(context),
        floatingActionButton: ScaleTransition(
          scale: animation,
          child: FloatingActionButton(
            elevation: 8,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add_photo_alternate,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/create');
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: [
            Icons.dashboard,
            Icons.archive,
          ],
          backgroundColor: Colors.white,
          activeIndex: _bottomNavIndex,
          activeColor: Theme.of(context).accentColor,
          splashColor: Hexcolor('#998abd'),
          inactiveColor: Colors.grey,
          notchAndCornersAnimation: animation,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.center,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: (index) => setState(() => _bottomNavIndex = index),
        ),
        body: Center(
          child: IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {}),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () => Scaffold.of(context).openDrawer(),
        child: CachedNetworkImage(
          height: AppBar().preferredSize.height * 0.9,
          width: AppBar().preferredSize.height * 0.9,
          placeholder: (context, url) => CircularProgressIndicator(),
          imageUrl: _currentAuthUser.photoURL,
        ),
      ),
      title: Text(
        getApplicationTitle(),
        style: TextStyle(color: Theme
            .of(context)
            .accentColor),
      ),
      actions: [
        // IconButton(
        //   icon: Icon(Icons.info_outline),
        //   color: Theme.of(context).accentColor,
        //   onPressed: () => Navigator.pushNamed(context, '/experiment'),
        // ),
        IconButton(
          icon: Icon(Icons.sort,
            color: Theme
                .of(context)
                .accentColor,
          ),
          onPressed: null,
        ),
        IconButton(
          icon: Icon(Icons.search,
            color: Theme
                .of(context)
                .accentColor,
          ),
          onPressed: null,
        ),
      ],
    );
  }

  Drawer _drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .accentColor,
            ),
            child: Text(
              getApplicationTitle(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Messages'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.signOutAlt),
            title: Text("Sign Out"),
            onTap: _signOutDialog,
          )
        ],
      ),
    );
  }


  Future<void> _signOutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign Out?'),
          content: Text('Do you want to sign out now?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                print('GUserHomePageCheck::::${GoogleSignIn().isSignedIn()}');
                if (await GoogleSignIn().isSignedIn()) {
                  await GoogleSignIn().signOut();
                  print("GSignOUT");
                } else {
                  print("Didn'tGSignOUT");
                }
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoggedOut()));
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    bool backButton = backButtonPressedTime == null ||
        currentTime.difference(backButtonPressedTime) > Duration(seconds: 3);

    if (backButton) {
      backButtonPressedTime = currentTime;
      Fluttertoast.showToast(
        msg: "Double Click to exit app",
        backgroundColor: Colors.white,
        textColor: Hexcolor(getAccentColorHexVal()),
      );
      return false;
    }
    SystemNavigator.pop();
    return true;
  }
}
