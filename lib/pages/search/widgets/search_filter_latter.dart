// import 'package:flutter/material.dart';
// import 'package:get/instance_manager.dart';

// import '../../../constants/gaps.dart';
// import '../../../constants/sizes.dart';
// import '../../../theme/app_text_stlye.dart';
// import '../../../utils/compute_luminance.dart';
// import '../controller/search_page_controller.dart';

// class SearchFilterLetter extends StatefulWidget {
//   const SearchFilterLetter({super.key});

//   @override
//   State<SearchFilterLetter> createState() => _SearchFilterLetterState();
// }

// class _SearchFilterLetterState extends State<SearchFilterLetter> {
//   final controller = Get.find<SearchPageController>();

//   bool isActive(String filter) => controller.filterLetter == filter;
//   void onChangeFilter(String filter) {
//     setState(() {
//       controller.filterLetter == filter ? controller.filterLetter = "" : controller.filterLetter = filter;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: Sizes.m),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Urutan Huruf", style: AppTextStyle.ts14Bold),
//           VGap.s,
//           Row(
//             children: [
//               InkWell(
//                 onTap: () => onChangeFilter("ASC"),
//                 borderRadius: const BorderRadius.all(Radius.circular(100)),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: Sizes.r, vertical: Sizes.s),
//                   decoration: BoxDecoration(
//                     color: isActive("ASC") ? theme.primaryColor : null,
//                     borderRadius: const BorderRadius.all(Radius.circular(100)),
//                     border: Border.all(width: 2, color: theme.primaryColor),
//                   ),
//                   child: Column(
//                     children: [
//                       Text(
//                         "A - Z",
//                         style: AppTextStyle.ts14Bold.copyWith(
//                           color: isActive("ASC") ? calculateLuminance(theme.primaryColor) : theme.primaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               HGap.s,
//               InkWell(
//                 onTap: () => onChangeFilter("DESC"),
//                 borderRadius: const BorderRadius.all(Radius.circular(100)),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: Sizes.r, vertical: Sizes.s),
//                   decoration: BoxDecoration(
//                     color: isActive("DESC") ? theme.primaryColor : null,
//                     borderRadius: const BorderRadius.all(Radius.circular(100)),
//                     border: Border.all(width: 2, color: theme.primaryColor),
//                   ),
//                   child: Column(
//                     children: [
//                       Text(
//                         "Z - A",
//                         style: AppTextStyle.ts14Bold.copyWith(
//                           color: isActive("DESC") ? calculateLuminance(theme.primaryColor) : theme.primaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
