// import 'package:easycut/core/constant/color.dart';
// import 'package:easycut/core/constant/dimensions.dart';
// import 'package:easycut/core/shared/widgets/small_text.dart';
// import 'package:flutter/material.dart';

// class ExpandableTextWidget extends StatefulWidget {
//   final String text;
//   const ExpandableTextWidget({super.key, required this.text});

//   @override
//   State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
// }

// class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
//   late String firstHalf;
//   late String secondHalf;

//   bool hiddenText = true;

//   double textHeight = Dimensions.screenHeight / 5.63;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.text.length > textHeight) {
//       firstHalf = widget.text.substring(0, textHeight.toInt());
//       secondHalf =
//           widget.text.substring(textHeight.toInt() + 1, widget.text.length);
//     } else {
//       firstHalf = widget.text;
//       secondHalf = "";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: secondHalf.isEmpty
//           ? SmallText(
//               text: firstHalf,
//               size: Dimensions.font16,
//               color: AppColor.grey,
//               height: 1.4,
//               overFlow: TextOverflow.visible,
//             )
//           : Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SmallText(
//                   text: hiddenText
//                       ? ("$firstHalf....")
//                       : (firstHalf + secondHalf),
//                   size: Dimensions.font16,
//                   color: AppColor.grey,
//                   height: 1.4,
//                   overFlow: TextOverflow.visible,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     setState(() {
//                       hiddenText = !hiddenText;
//                     });
//                   },
//                   child: Row(
//                     children: [
//                       SmallText(
//                         text: hiddenText ? "Show More" : "Show Less",
//                         color: AppColor.primaryColor,
//                       ),
//                       Icon(
//                         hiddenText
//                             ? Icons.arrow_drop_down
//                             : Icons.arrow_drop_up,
//                         color: AppColor.primaryColor,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }
