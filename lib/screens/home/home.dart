import 'package:flutter/material.dart';
import 'package:happy_plants/config.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:provider/provider.dart';
import 'tabs/garden.dart';
import 'tabs/timeline.dart';
import 'tabs/options/options.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  bool loading = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dbUser = Provider.of<DbUser?>(context);

    // Reloads until the db user is loaded
    if (!modeInit) {
      Future.delayed(Duration.zero, () {
        if (dbUser != null && dbUser.settings != null) {
          currentTheme
              .changeThemeMode(dbUser.settings!.designSettings.colorScheme!);
          modeInit = true;
        }
      });
    }

    final List<Widget> _widgetOptions = <Widget>[
      const Garden(),
      const Timeline(),
      const Options(),
    ];

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist),
            label: 'Garden',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shower),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
      ),
    );
  }
}
