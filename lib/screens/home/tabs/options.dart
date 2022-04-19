import 'package:flutter/material.dart';
import 'package:happy_plants/services/authentication.dart';
import 'package:happy_plants/shared/widgets/util/lists/custom_list_group.dart';
import 'package:happy_plants/shared/widgets/util/lists/custom_list_tile.dart';

class Options extends StatefulWidget {
  const Options({Key? key}) : super(key: key);

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        CustomListGroup(
            title: 'Account Settings',
            children: <Widget>[
              CustomListTile(
                title: const Text('Logout'),
                leading: const Icon(Icons.logout),
                onTap: () async {
                  await _auth.signOut();
                },
              ),

              CustomListTile(
                title: const Text('Logout'),
                leading: const Icon(Icons.logout),
                onTap: () async {
                  await _auth.signOut();
                },
              ),
            ]
        ),




        CustomListGroup(
            title: 'Test Settings',
            children: <Widget>[
              CustomListTile(
                title: const Text('Logout'),
                leading: const Icon(Icons.logout),
                onTap: () async {
                  await _auth.signOut();
                },
              ),

              CustomListTile(
                title: const Text('Logout'),
                leading: const Icon(Icons.logout),
                onTap: () async {
                  await _auth.signOut();
                },
              ),
            ]
        ),
      ],
    );
  }
}