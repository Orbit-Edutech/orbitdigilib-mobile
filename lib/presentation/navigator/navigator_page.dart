import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../constants/gaps.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import '../collection/collection_page.dart';
import '../index/controller/index_controller.dart';
import '../index/index_page.dart';
import '../profile/profile_page.dart';
import '../wishlist/wishlist_page.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  int currentIndex = 0;

  void onItemSelected(int index) => setState(() => currentIndex = index);

  bool isActive(int index) => currentIndex == index;
  @override
  Widget build(BuildContext context) {
    final indexController = Get.find<IndexController>();
    final theme = Theme.of(context);
    return PersistentTabView(
      context,
      hideNavigationBarWhenKeyboardShows: true,
      resizeToAvoidBottomInset: true,
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
      onItemSelected: onItemSelected,
      screens: const [
        IndexPage(),
        WishlistPage(),
        CollectionPage(),
        ProfilePage(),
      ],
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 100),
        curve: Curves.easeIn,
      ),
      items: [
        PersistentBottomNavBarItem(
          icon: Obx(() {
            final perpustakaan = indexController.perpustakaan.value;
            return AnimatedOpacity(
              opacity: perpustakaan == null ? 0 : 1,
              duration: const Duration(milliseconds: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.string(
                    """
                      <svg width="20" height="19" viewBox="0 0 20 19" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <g id="Group 4">
                      <path id="Union" fill-rule="evenodd" clip-rule="evenodd" d="M10.7849 0.312128C10.3444 -0.104042 9.65561 -0.104043 9.21511 0.312126L1.20145 7.88307C0.449874 8.59313 0.952388 9.85676 1.98633 9.85676H3.14254V16.7142C3.14254 17.9766 4.16593 19 5.42835 19H14.5716C15.834 19 16.8574 17.9766 16.8574 16.7142V9.85676H18.0136C19.0476 9.85676 19.5501 8.59313 18.7985 7.88307L10.7849 0.312128Z" fill="#${isActive(0) ? theme.primaryColor.value.toRadixString(16).substring(2) : 'D6D6D6'}"/>
                            <rect id="Rectangle 12" x="5.42834" y="16.5713" width="9.14324" height="1" rx="0.457162" fill="#${isActive(0) ? 'FFFFFF' : '9E9E9E'}"/>
                            </g>
                            </svg>
                          """,
                    height: 20,
                  ),
                  VGap.xs,
                  Text(
                    "Beranda",
                    style: AppTextStyle.ts10Reg.copyWith(
                      decoration: TextDecoration.none,
                      color: isActive(0) ? theme.primaryColor : AppColor.grey,
                    ),
                  )
                ],
              ),
            );
          }),
        ),
        PersistentBottomNavBarItem(
          icon: Obx(() {
            final perpustakaan = indexController.perpustakaan.value;
            return AnimatedOpacity(
              opacity: perpustakaan == null ? 0 : 1,
              duration: const Duration(milliseconds: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.string(
                    """
                      <svg width="15" height="17" viewBox="0 0 15 17" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <g id="Group 6">
                      <path id="Subtract" fill-rule="evenodd" clip-rule="evenodd" d="M2.3336 0C1.399 0 0.641357 0.75764 0.641357 1.69224V15.2302C0.641357 15.7337 0.861238 16.1858 1.21021 16.4958L7.41032 11.8457L13.6104 16.4958C13.9594 16.1858 14.1793 15.7337 14.1793 15.2302V1.69224C14.1793 0.757642 13.4216 0 12.487 0H2.3336Z" fill="#${isActive(1) ? theme.primaryColor.value.toRadixString(16).substring(2) : 'D6D6D6'}"/>
                      <rect id="Rectangle 12" x="4.02582" y="1.69225" width="6.76896" height="0.84612" rx="0.169224" fill="#${isActive(1) ? 'FFFFFF' : '9E9E9E'}"/>
                      </g>
                      </svg>
                    """,
                    height: 20,
                  ),
                  VGap.xs,
                  Text(
                    "Wishlist",
                    style: AppTextStyle.ts10Reg.copyWith(
                      decoration: TextDecoration.none,
                      color: isActive(1) ? theme.primaryColor : AppColor.grey,
                    ),
                  )
                ],
              ),
            );
          }),
        ),
        PersistentBottomNavBarItem(
          icon: Obx(() {
            final perpustakaan = indexController.perpustakaan.value;
            return AnimatedOpacity(
              opacity: perpustakaan == null ? 0 : 1,
              duration: const Duration(milliseconds: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.string(
                    """
                      <svg width="16" height="18" viewBox="0 0 16 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <g id="Group 2">
                      <path id="Vector 3" d="M6.58579 1H1C0.447715 1 0 1.44772 0 2V13C0 13.5523 0.447715 14 1 14H6.58579C6.851 14 7.10536 14.1054 7.29289 14.2929C7.68342 14.6834 8.31658 14.6834 8.70711 14.2929C8.89464 14.1054 9.149 14 9.41421 14H15C15.5523 14 16 13.5523 16 13V2C16 1.44772 15.5523 1 15 1H9.41421C9.149 1 8.89464 1.10536 8.70711 1.29289C8.31658 1.68342 7.68342 1.68342 7.29289 1.29289C7.10536 1.10536 6.851 1 6.58579 1Z" fill="#${isActive(2) ? theme.primaryColor.value.toRadixString(16).substring(2) : 'D6D6D6'}"/>
                      <path id="Vector 4" d="M8 2V14" stroke="#${isActive(2) ? 'FFFFFF' : '9E9E9E'}" stroke-width="0.5"/>
                      <path id="Vector 5" d="M3 16V16C3 16.3064 3.17313 16.5866 3.44721 16.7236L3.78885 16.8944C3.92771 16.9639 4.08082 17 4.23607 17H11.7639C11.9192 17 12.0723 16.9639 12.2111 16.8944L12.5528 16.7236C12.8269 16.5866 13 16.3064 13 16V16" stroke="#${isActive(2) ? theme.primaryColor.value.toRadixString(16).substring(2) : '9E9E9E'}"/>
                      <path id="Vector 6" d="M4.76 0H2.24C2.10745 0 2 0.107452 2 0.24V4.48759C2 4.69107 2.23733 4.80223 2.39364 4.67196L3.34636 3.87804C3.43536 3.80387 3.56464 3.80387 3.65364 3.87804L4.60636 4.67196C4.76267 4.80223 5 4.69107 5 4.48759V0.24C5 0.107452 4.89255 0 4.76 0Z" fill="#${isActive(2) ? 'FFFFFF' : '9E9E9E'}"/>
                      <rect id="Rectangle 13" x="10" y="4" width="4.2" height="1" rx="0.24" fill="#${isActive(2) ? 'FFFFFF' : '9E9E9E'}"/>
                      <rect id="Rectangle 14" x="10" y="7" width="4.2" height="1" rx="0.24" fill="#${isActive(2) ? 'FFFFFF' : '9E9E9E'}"/>
                      <rect id="Rectangle 15" x="10" y="10" width="4.2" height="1" rx="0.24" fill="#${isActive(2) ? 'FFFFFF' : '9E9E9E'}"/>
                      </g>
                      </svg>
                    """,
                    height: 20,
                  ),
                  VGap.xs,
                  Text(
                    "Koleksi",
                    style: AppTextStyle.ts10Reg.copyWith(
                      decoration: TextDecoration.none,
                      color: isActive(2) ? theme.primaryColor : AppColor.grey,
                    ),
                  )
                ],
              ),
            );
          }),
        ),
        PersistentBottomNavBarItem(
          icon: Obx(() {
            final perpustakaan = indexController.perpustakaan.value;
            return AnimatedOpacity(
              opacity: perpustakaan == null ? 0 : 1,
              duration: const Duration(milliseconds: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.string(
                    """
                      <svg width="18" height="20" viewBox="0 0 18 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <g id="Icon-profil-nav-enable">
                      <path id="Union" fill-rule="evenodd" clip-rule="evenodd" d="M11.687 12.6468C12.9744 11.7811 13.8214 10.3109 13.8214 8.64292C13.8214 5.98011 11.6628 3.82149 9.00001 3.82149C6.33721 3.82149 4.17858 5.98011 4.17858 8.64292C4.17858 10.3109 5.02561 11.7811 6.313 12.6468C4.61845 13.1185 3.375 14.673 3.375 16.5179V18.125C3.375 18.7463 3.87868 19.25 4.5 19.25H13.5C14.1213 19.25 14.625 18.7463 14.625 18.125V16.5179C14.625 14.673 13.3816 13.1185 11.687 12.6468Z" fill="#${isActive(3) ? theme.primaryColor.value.toRadixString(16).substring(2) : 'D6D6D6'}"/>
                      <path id="Ellipse 3" d="M15.6657 13.6561C16.0592 13.931 16.6051 13.8366 16.8408 13.4184C17.501 12.2468 17.8921 10.9386 17.9807 9.58935C18.0883 7.95013 17.7451 6.31273 16.9885 4.85462C16.2318 3.3965 15.0905 2.17328 13.6883 1.31755C12.286 0.461806 10.6763 0.00618547 9.03355 6.25165e-05C7.39081 -0.00606044 5.77773 0.437548 4.36913 1.28281C2.96053 2.12807 1.81014 3.34274 1.04265 4.79518C0.27515 6.24762 -0.0801774 7.88241 0.0151736 9.52239C0.0936598 10.8723 0.475035 12.1833 1.12652 13.3599C1.35903 13.7798 1.9042 13.8782 2.29973 13.6063C2.69526 13.3344 2.79026 12.7952 2.56751 12.3701C2.09036 11.4593 1.81046 10.4545 1.7504 9.4215C1.67347 8.09825 1.96017 6.77918 2.57944 5.60725C3.19871 4.43532 4.12692 3.45524 5.26348 2.77322C6.40004 2.0912 7.70159 1.73327 9.02707 1.73821C10.3525 1.74315 11.6514 2.11078 12.7828 2.80125C13.9143 3.49172 14.8352 4.4787 15.4457 5.65521C16.0562 6.83172 16.3331 8.15289 16.2463 9.47553C16.1785 10.5081 15.8911 11.5108 15.4072 12.4179C15.1813 12.8414 15.2723 13.3813 15.6657 13.6561Z" fill="#${isActive(3) ? theme.secondaryHeaderColor.value.toRadixString(16).substring(2) : '9E9E9E'}"/>
                      </g>
                      </svg>
                    """,
                    height: 20,
                  ),
                  VGap.xs,
                  Text(
                    "Akun",
                    style: AppTextStyle.ts10Reg.copyWith(
                      decoration: TextDecoration.none,
                      color: isActive(3) ? theme.primaryColor : AppColor.grey,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
