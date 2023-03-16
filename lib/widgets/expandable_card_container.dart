import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ExpandableCardContainer extends StatefulWidget {
  const ExpandableCardContainer(
      {Key? key,
      required this.isExpanded,
      required this.header,
      required this.collapsedChild,
      required this.expandedChild})
      : super(key: key);

  final bool isExpanded;
  final String header;
  final Widget collapsedChild;
  final Widget expandedChild;

  @override
  _ExpandableCardContainerState createState() =>
      _ExpandableCardContainerState();
}

class _ExpandableCardContainerState extends State<ExpandableCardContainer> {
  // @override
  // Widget build(BuildContext context) {
  // return AnimatedContainer(
  //   padding: const EdgeInsets.all(40),
  //   color: Colors.redAccent,
  //   duration: const Duration(milliseconds: 8000),
  //   curve: Curves.easeInOut,
  //   child: widget.isExpanded ? widget.expandedChild : widget.collapsedChild,
  // );
  late bool _expanded;

  @override
  void initState() {
    _expanded = widget.isExpanded;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.symmetric(vertical: 2.0),
    //   child: GestureDetector(
    //     onTap: () {
    //       setState(() {
    //         _expanded = !_expanded;
    //       });
    //     },
    //     child: Card(
    //       elevation: 4,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(16.0),
    //       ),
    //       child: AnimatedContainer(
    //         duration: const Duration(milliseconds: 600),
    //         curve: Curves.easeInOut,
    //         height: _expanded? 250: 100,
    //         child: Row(
    //           children: [
    //             Expanded(
    //               child: Center(
    //                 child: Container(
    //                   padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
    //                   child: Wrap(
    //                     children: [
    //                       _expanded ? widget.expandedChild : widget.collapsedChild,
    //                     ]
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             _expanded? const Icon(Icons.arrow_drop_up_rounded): const Icon(Icons.arrow_drop_down_rounded)
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: ExpandablePanel(
                header: Text(widget.header),
                collapsed: widget.collapsedChild,
                expanded: widget.expandedChild,
              ),
            ),
          ),
        ),
      ),
    );

    // return Padding(
    //   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    //   child: Card(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(16.0),
    //     ),
    //     child: ExpandablePanel(
    //       header: Text(widget.header),
    //       collapsed: widget.collapsedChild,
    //       expanded: widget.expandedChild,
    //     ),
    //   ),
    // );
  }
}
