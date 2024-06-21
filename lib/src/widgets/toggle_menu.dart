import 'package:flutter/material.dart';

class ToggleMenu<T> extends StatefulWidget {
  final List<ToggleItem<T>> items;
  final void Function(ToggleItem value) onChanged;
  const ToggleMenu({super.key, required this.items, required this.onChanged});

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
            setState(() {
              for (int i = 0; i < widget.items.length; i++) {
                widget.items[i].isSelected = i == index;
              }
            });
            widget.onChanged(widget.items[index]);
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

class ToggleItem<T> {
  final String title;
  bool isSelected;
  final T value;

  ToggleItem({
    required this.title,
    this.isSelected = false,
    required this.value,
  });
}
