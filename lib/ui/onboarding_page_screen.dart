import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wireguard_flutter/ui/common/app_router.dart';
import 'package:wireguard_flutter/ui/common/text_styles.dart';

class OnBoardingPageScreen extends StatelessWidget {
  const OnBoardingPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 45),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'V-Tell VPN',
                        style: TextStyles.regular14,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    context.router.push(FeelSafeScreenRoute());
                  },
                  child: SizedBox(
                    height: 45,
                    width: 45,
                    child: SvgPicture.asset(
                      'assets/icon/cross.svg',
                      fit: BoxFit.none,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 45.h),
            Text(
              'THANK YOU FOR CHOOSING\nV-TELL VPN.',
              style: TextStyles.redTitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 45.h),
            Text(
              'Protect your digital\nprivacy!',
              style: TextStyles.regular14,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60.h),
            Stack(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/on_boarding_svg.png',
                    height: 340.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
