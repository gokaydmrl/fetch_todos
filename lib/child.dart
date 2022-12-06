import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

// class Child extends StatelessWidget {
//   final String val;

//   const Child({
//     super.key,
//     required this.val,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Text(val);
//   }
// }

class Child extends StatefulWidget {
  final String aval;
  final void Function() changeValFunc;
  const Child({super.key, required this.aval, required this.changeValFunc});

  @override
  State<Child> createState() => _ChildState();
}

class _ChildState extends State<Child> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.aval),
        FloatingActionButton(onPressed: widget.changeValFunc)
      ],
    );
  }
}
