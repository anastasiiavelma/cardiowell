import 'package:cardiowell/screens/med_card_screen.dart';
import 'package:cardiowell/screens/note_screen.dart';
import 'package:cardiowell/screens/post_screen.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class BottomNavBar extends StatefulWidget {
  final String userId;
  final String token;

  const BottomNavBar({super.key, required this.userId, required this.token});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

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
        return NotesScreen(userId: widget.userId, token: widget.token);
      case 1:
        return const PostScreen();
      case 2:
        return MedCardScreen(userId: widget.userId, token: widget.token);
      default:
        return const SizedBox();
    }
  }
}
