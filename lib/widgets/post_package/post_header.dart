// import 'package:flutter/material.dart';

// class PostHeader extends StatelessWidget {
//   final Post post;

//   const PostHeader({
//     required this.post,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         ProfileAvatar(imageUrl: post.user.imageUrl),
//         const SizedBox(width: 8.0),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 post.user.name,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Row(
//                 children: [
//                   Text(
//                     '${post.timeAgo} • ',
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                       fontSize: 12.0,
//                     ),
//                   ),
//                   Icon(
//                     Icons.public,
//                     color: Colors.grey[600],
//                     size: 12.0,
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//         IconButton(
//           icon: const Icon(Icons.more_horiz),
//           onPressed: () => print('More'),
//         ),
//       ],
//     );
//   }
// }
