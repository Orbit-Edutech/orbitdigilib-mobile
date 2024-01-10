// import 'package:flutter/material.dart';
// import 'package:get/route_manager.dart';

// import '../../../constants/gaps.dart';
// import '../../../constants/sizes.dart';
// import '../../../shared/widget/app_button.dart';

// class SearchFilterModalButtons extends StatelessWidget {
//   const SearchFilterModalButtons({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: Sizes.m),
//       child: Row(
//         children: [
//           Expanded(
//             child: AppButton(
//               type: ButtonType.outlined,
//               onPressed: Get.back,
//               child: const Text("Batal"),
//             ),
//           ),
//           HGap.s,
//           Expanded(
//             child: AppButton(
//               type: ButtonType.elevated,
//               onPressed: Get.back,
//               child: const Text("Terapkan"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
