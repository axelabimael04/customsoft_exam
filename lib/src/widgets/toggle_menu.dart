import 'package:flutter/material.dart';

class ToggleMenu extends StatefulWidget {
  final List<ToggleItem> items;
  const ToggleMenu({super.key, required this.items});

  @override
  State<ToggleMenu> createState() => _ToggleMenuState();
}

class _ToggleMenuState extends State<ToggleMenu> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = (constraints.maxWidth - (widget.items.length + 1)) /
            widget.items.length;
        return ToggleButtons(
          onPressed: (int index) {
            for (int i = 0; i < widget.items.length; i++)
              setState(() {
                widget.items[i].isSelected = i == index;
              });
          },
          constraints: BoxConstraints(
            minHeight: 40.0,
            minWidth: maxWidth,
            maxWidth: maxWidth,
          ),
          isSelected: widget.items.map((e) => e.isSelected).toList(),
          children: widget.items.map((e) => Text(e.title)).toList(),
        );
      },
    );
  }
}

class ToggleItem {
  final String title;
  bool isSelected;

  ToggleItem({required this.title, this.isSelected = false});
}
