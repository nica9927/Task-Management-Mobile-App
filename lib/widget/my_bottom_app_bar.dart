import 'package:flutter/material.dart';

class MyBottomAppBarItem {
  MyBottomAppBarItem({this.iconData, this.text});

  IconData? iconData;
  String? text;
}

class MyBottomAppBar extends StatefulWidget {
  final List<MyBottomAppBarItem>? items;
  final String? centerItemText;
  final double? height;
  final double? iconSize;
  final Color? backgroundColor;
  final Color? color;
  final Color? selectedColor;
  final NotchedShape? notchedShape;
  final ValueChanged<int>? onTabSelected;

  MyBottomAppBar({
    Key? key,
    this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
  }) : super(key: key) {
    assert(this.items!.length == 2 || this.items!.length == 4);
  }

  @override
  MyBottomAppBarState createState() => MyBottomAppBarState();
}

class MyBottomAppBarState extends State<MyBottomAppBar> {
  int _selectedIndex = 0;

  updateIndex(int index) {
    if (widget.onTabSelected != null) widget.onTabSelected!(index);
    setState(() {
      _selectedIndex = index;
    });
  }

//
//  setPage(int page) {
//    setState(() {
//      _selectedIndex = page;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items!.length, (int index) {
      return _buildTabItem(
        item: widget.items![index],
        index: index,
        onPressed: updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items,
        ),
      ),
      color: Colors.white,
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize)
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    MyBottomAppBarItem? item,
    int? index,
    ValueChanged<int>? onPressed,
  }) {
    Color color = (_selectedIndex == index ? widget.selectedColor : widget.color)!;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed!(index!),
            child: Icon(item!.iconData, color: color, size: widget.iconSize),
          ),
        ),
      ),
    );
  }
}