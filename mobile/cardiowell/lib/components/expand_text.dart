import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:hexcolor/hexcolor.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;

  const ExpandableTextWidget({super.key, required this.text});

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpandableText(
      widget.text,
      expandText: 'Read More',
      collapseText: 'Read Less',
      maxLines: 5,
      linkColor: HexColor("#ff6700"), // Customize the link color if desired
      expandOnTextTap: isExpanded = true,

      collapseOnTextTap: isExpanded = false,

      expanded: isExpanded,
    );
  }
}
