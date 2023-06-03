import 'package:cardiowell/screens/note_detail_screen.dart';
import 'package:cardiowell/screens/note_screen.dart';
import 'package:cardiowell/screens/post_screen.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class BottomNavBar extends StatefulWidget {
  final String userId;

  BottomNavBar({required this.userId});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: const [
          CurvedNavigationBarItem(
            child: Icon(
              Icons.event_note,
              color: Colors.white,
            ),
          ),
          CurvedNavigationBarItem(
            child: Icon(
              Icons.newspaper,
              color: Colors.white,
            ),
          ),
          CurvedNavigationBarItem(
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          CurvedNavigationBarItem(
            child: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
        color: HexColor("#003366"),
        buttonBackgroundColor: HexColor("#ff6700"),
        backgroundColor: HexColor("#ffffff"),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: _getPageWidget(_page),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPageWidget(int page) {
    switch (page) {
      case 0:
        return NotesScreen(userId: widget.userId);
      case 1:
        return const PostScreen();
      case 2:
        return const NoteDetail();
      case 3:
        return const NoteDetail();
      default:
        return const SizedBox();
    }
  }
}
