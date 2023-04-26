// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';

// class HeroContainer extends StatelessWidget {
//   final String tag;
//   final ImageProvider imageProvider;

//   const HeroContainer({
//     Key? key,
//     required this.tag,
//     required this.imageProvider,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Center(
//         child: Hero(
//           tag: tag,
//           createRectTween: (begin, end) {
//             Tween<Rect> tween = Tween(
//                 begin: Rect.fromPoints(Offset.zero, Offset.zero),
//                 end: Rect.fromPoints(
//                     Offset(MediaQuery.of(context).size.width,
//                         MediaQuery.of(context).size.height),
//                     Offset(MediaQuery.of(context).size.width,
//                         MediaQuery.of(context).size.height)));
//             return tween;
//           },
//           child: PhotoView(
//             // heroAttributes: PhotoViewHeroAttributes(
//             //     tag: tag,
//             //     createRectTween: (begin, end) {
//             //       return MaterialRectCenterArcTween(begin: begin, end: end);
//             //     }),
//             imageProvider: imageProvider,
//           ),
//         ),
//       ),
//     );
//   }
// }
