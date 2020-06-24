import 'package:flutter/material.dart';
import 'package:device_id/device_id.dart';

import 'dart:async';

import 'create_poll.dart';
import 'favourites.dart';
import 'mypolls.dart';
import 'timeline.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _deviceid = 'Unknown';
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    initDeviceId();
  }

  final PageStorageBucket bucket = PageStorageBucket();
  static const List<Widget> screens = <Widget>[
    Timeline(
      key: PageStorageKey('Timeline'),
    ),
    MyPolls(
      key: PageStorageKey('My Polls'),
    ),
    Favourites(
      key: PageStorageKey('Favourties'),
    ),
  ];

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
        onTap: (int index) => setState(() => _selectedIndex = index),
        currentIndex: selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.poll), title: Text('My Polls')),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text('Favourites')),
        ],
        selectedItemColor: Colors.amber[800],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreatePoll()));
        },
        tooltip: 'Create Poll',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: screens[_selectedIndex],
        bucket: bucket,
      ),
    );
  }

  Future<void> initDeviceId() async {
    String deviceId = await DeviceId.getID;
    setState(() {
      _deviceid = '$deviceId';
    });
  }
}
