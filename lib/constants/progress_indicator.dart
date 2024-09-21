import 'package:flutter/material.dart';

class ProgressWidget extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  const ProgressWidget(
      {super.key,
      required this.child,
      required this.inAsyncCall,
      this.opacity = 0.3,
      this.color = Colors.grey,
     });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: ModalBarrier(
              dismissible: false,
              color: color,
            ),
          ),
          const Center(
            child: CircularProgressIndicator(),
          )
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}
