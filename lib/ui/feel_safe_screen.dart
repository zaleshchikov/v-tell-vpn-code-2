import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wireguard_flutter/shared_preferences.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:wireguard_flutter/ui/common/app_router.dart';
import 'package:wireguard_flutter/ui/common/button.dart';
import 'package:wireguard_flutter/ui/common/colors.dart';
import 'package:wireguard_flutter/ui/common/text_styles.dart';
import 'package:wireguard_flutter/ui/tunnel_details.dart';
import 'package:wireguard_flutter/ui/webview_screen.dart';

import 'common/texts.dart';

class FeelSafeScreen extends StatefulWidget {
  final bool emailSubmit;

  const FeelSafeScreen({
    Key? key,
    this.emailSubmit = false,
  }) : super(key: key);

  @override
  State<FeelSafeScreen> createState() => _FeelSafeScreenState();
}

class _FeelSafeScreenState extends State<FeelSafeScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30.h),
                Text(
                  'V-Tell VPN',
                  style: TextStyles.regular14,
                ),
                SizedBox(height: 85.h),
                SvgPicture.asset(
                  widget.emailSubmit
                      ? 'assets/icon/email_submit.svg'
                      : 'assets/icon/feel_safety.svg',
                ),
                if (widget.emailSubmit) ...[
                  SizedBox(height: 60.h),
                  Text(
                    'If you would like to become a V-Tell Customer or get access to VPN services, please submit your e-mail address and a representative will reach out to you shortly.',
                    style: TextStyles.regular16,
                  ),
                  SizedBox(height: 50.h),
                  TextFormField(
                    style: TextStyles.beauSansRegular14
                        .copyWith(color: Colors.white),
                    cursorColor: PjColors.lightGrey,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      enabledBorder: border(),
                      disabledBorder: border(),
                      border: border(),
                      focusedBorder: border(),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'E-mail',
                        style: TextStyles.beauSansRegular14,
                      ),
                    ),
                  ),
                  SizedBox(height: 60.h),
                  Button(
                    text: 'Submit',
                    onTap: () {
                      context.router.push(TunnelDetailsRoute());
                    },
                  ),
                  SizedBox(height: 34.h),
                  Text(
                    'If you do not receive the e-mail containing the V-Tell VPN Key within 24hrs of subscribing, please check your spam or contact Customer Service.',
                    style: TextStyles.italic12,
                  ),
                ] else ...[
                  SizedBox(height: 30.h),
                  Text(
                    'FEEL SAFE.',
                    style: TextStyles.redTitle,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    'Please continue to the next page to confirm your subscription.',
                    style: TextStyles.regular16,
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    'Once you have successfully subscribed, you will receive an e-mail with a VPN Activation Key.',
                    style: TextStyles.regular16,
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    'Once received, you can then activate VPN on your device by selecting "Upload V-Tell VPN Key".',
                    style: TextStyles.regular16,
                  ),
                  SizedBox(height: 50.h),
                  Button(
                    text: 'Continue',
                    onTap: () async {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  WebViewScreen(url: "https://v-tell.com/vpn"),
                        ),
                      ).then((_) {
                        context.router.push(TunnelDetailsRoute());
                      }).catchError((_) {
                        context.router.push(TunnelDetailsRoute());
                      });
                      // context.router.push(FeelSafeScreenRoute(emailSubmit: true));
                    },
                  ),
                  SizedBox(height: 20.h),
                  Button(
                    text: 'Upload V-Tell VPN key',
                    onTap: () async {
                      final file = await getConfigFile();
                      if(file == null) 

                      return;
                      final json = file.readAsStringSync();
                      final extractedValues = extractValues(json,["PrivateKey","Address","DNS",]);
                      final String? privateKey = extractedValues['PrivateKey'];
                      final String? address = extractedValues["Address"];
                      
                      if(privateKey != null) {
                        initPrivateKey = privateKey.trim();
                      }
                      if(address != null) {
                        initAddress = address.trim();
                      }
                      //save the configDataString:
                      MySharedPreferences().setConfigString(json);
                      isUploadedConfFile = true;
                      context.router.push(TunnelDetailsRoute());
                    },
                    isActive: false,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

Map<String,String> extractValues(String input,List<String> keys) {
  // Split the input string by lines to process each line
  List<String> lines = input.trim().split('\n');
  Map<String,String> res = {};
  // Search for the line containing "PrivateKey"
  for (String line in lines) {
    for(final key in keys) {
    if (line.contains(key)) {
      // Split the line by '=' to get the value part
      List<String> parts = line.split(' = ');
      if (parts.length > 1) {
        // Trim and return the PrivateKey value
        res[key] = parts[1].trim();
      }
    }
    }
  }

  return res; // Return an empty string if PrivateKey is not found
}

  Future<File?> getConfigFile() async {
    try {
      // final permission = await Permission.storage.smartRequest();
      // if(!permission.isGranted) return null;
      final result = await FilePicker.platform.pickFiles();
      final filteres = result?.files.where((element) => element.path?.endsWith('.vt_conf')??false).toList() ?? [];
      if ( filteres.isEmpty) return null;
      final path = filteres.first.path;
      if(path == null) return null;
      return File(path);
    } catch (e) {
      _showError(context, e.toString());
      return null;
    }
  }
}

OutlineInputBorder border() {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(40)),
    borderSide: BorderSide(color: PjColors.lightGrey),
  );
}

  _showError(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Texts.semiBold(error, color: Colors.white),
      backgroundColor: Colors.red[400],
    ));
  }


// extension PermissionHandlerExt on Permission {
//   Future<PermissionStatus> smartRequest() async {
//     PermissionStatus status = await request();
//     if (status.isDenied) {
//       status = await request();
//     }
//     if (status.isLimited || status.isPermanentlyDenied) {
//       await openAppSettings();
//       status = await request();
//     }
//     return status;
//   }
// }
