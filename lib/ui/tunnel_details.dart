// import 'dart:async';
// import 'dart:convert';
// import 'dart:math';

// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:wireguard_flutter/repository/models.dart';
// import 'package:wireguard_flutter/ui/common/app_router.dart';
// import 'package:wireguard_flutter/ui/common/text_styles.dart';
// import 'package:wireguard_flutter/ui/webview_screen.dart';

// import '../log.dart';
// import 'common/button.dart';
// import 'common/texts.dart';
// import 'ui_constants.dart';

// String initName = 'my-tunnel';
// String initAddress = "10.10.0.4/32";
// String initPort = "1280";
// String initDnsServer = "8.8.8.8";
// String initPrivateKey = "2P23r4Oj0wZEoMdXwJv3gVOYCkhPCrnG0AtRQ1G/m1U=";
// String initAllowedIp = "0.0.0.0/0";
// String initPublicKey = "WPte+VNVZknRVDEi2OmlUzBL6GwM5d06NxQAKSDAsws=";
// String initEndpoint = "74.208.203.188:443";

// class TunnelDetails extends StatefulWidget {
//   @override
//   createState() => _TunnelDetailsState();
// }

// class _TunnelDetailsState extends State<TunnelDetails> {
//   static const platform = const MethodChannel('tark.pro/wireguard-flutter');
//   String _name = initName;
//   String _address = initAddress;
//   String _listenPort = initPort;
//   String _dnsServer = initDnsServer;
//   String _privateKey = initPrivateKey;
//   String _peerAllowedIp = initAllowedIp;
//   String _peerPublicKey = initPublicKey;
//   String _peerEndpoint = initEndpoint;
//   bool _connected = false;
//   bool _scrolledToTop = true;
//   bool _gettingStats = true;
//   Stats? _stats;
//   Timer? _gettingStatsTimer;

//   int sliderIndex = -1;

// bool isLoading = false;

//  void onSwitchChange(int index, BuildContext context) async {
//     if (isLoading) return;
//     isLoading = true;
//     if (sliderIndex != -1) {
//       sliderIndex = -1;
//     } else {
//       sliderIndex = index;
//     }
//     _connected = sliderIndex != -1;
//     setState(() {});
//     await _setTunnelState(context);
//     isLoading = false;
//   }

//   @override
//   void initState() {
//     super.initState();
//     platform.setMethodCallHandler((call) async {
//       switch (call.method) {
//         case 'onStateChange':
//           try {
//             final stats = StateChangeData.fromJson(jsonDecode(call.arguments));
//             if (stats.tunnelState) {
//               setState(() => _connected = true);
//               _startGettingStats(context);
//             } else {
//               setState(() => _connected = false);
//               _stopGettingStats();
//             }
//           } catch (e) {
//             l('initState', 'error', e);
//           }

//           break;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: NotificationListener<ScrollUpdateNotification>(
//           onNotification: (notification) {
//             setState(() => _scrolledToTop = notification.metrics.pixels == 0);
//             return true;
//           },
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 25),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: 5.h),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: Text(
//                           'V-Tell VPN',
//                           style: TextStyles.regular14,
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         PageRouteBuilder(
//                           pageBuilder: (context, animation,
//                                   secondaryAnimation) =>
//                               WebViewScreen(url: 'https://v-tell.com/vpn'),
//                         ),
//                       );
//                     },
//                     child: Align(
//                       alignment: Alignment.centerRight,
//                       child: SvgPicture.asset('assets/icon/burger.svg'),
//                     ),
//                   ),

//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 Row(
//                 children: [
//                   SvgPicture.asset(
//                     'assets/icon/us.svg',
//                   ),
//                   SizedBox(width: 15),
//                   Text(
//                     'USA',
//                     style: TextStyles.regular16,
//                   ),
//                   const Spacer(),
//                   CupertinoSwitch(
//                     trackColor: Color(0xffd0d2d1),
//                     value: sliderIndex == 0,
//                     onChanged: (res) {
//                       onSwitchChange(res ? 0 : -1, context);
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               Row(
//                 children: [
//                   SvgPicture.asset(
//                     'assets/icon/nl.svg',
//                   ),
//                   SizedBox(width: 15),
//                   Text(
//                     'Netherlands',
//                     style: TextStyles.regular16,
//                   ),
//                   const Spacer(),
//                   CupertinoSwitch(
//                     trackColor: Color(0xffd0d2d1),
//                     value: sliderIndex == 1,
//                     onChanged: (res) {
//                       onSwitchChange(res ? 1 : -1, context);
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//                 Row(
//                 children: [
//                   SvgPicture.asset(
//                     'assets/icon/ru.svg',
//                   ),
//                   SizedBox(width: 15),
//                   Text(
//                     'Russia',
//                     style: TextStyles.regular16,
//                   ),
//                   const Spacer(),
//                   CupertinoSwitch(
//                     trackColor: Color(0xffd0d2d1),
//                     value: sliderIndex == 2,
//                     onChanged: (res) {
//                       onSwitchChange(res ? 2 : -1, context);
//                     },
//                   ),
//                 ],
//               ),
// Spacer(
//                 flex: 394,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   context.router.pushAndPopUntil(
//                     OnBoardingPageScreenRoute(),
//                     predicate: (route) => false,
//                   );
//                 },
//                 child: Container(
//                   alignment: Alignment.center,
//                   width: double.maxFinite,
//                   height: 32,
//                   margin: EdgeInsets.symmetric(horizontal: 20),
//                   color: Color(0xffE31F25),
//                   child: Text(
//                     'Log out',
//                     style: TextStyle(
//                         fontFamily: 'Arial',
//                         fontSize: 16,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w700),
//                   ),
//                 ),
//               ),
//               Spacer(
//                 flex: 22,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   children: [
//                     _buildUrlText('V-Tell Homepage', 'https://v-tell.com'),
//                     Spacer(),
//                     _buildUrlText('V-Tell App',
//                         'https://apps.apple.com/us/app/v-tell/id916724641'),
//                   ],
//                 ),
//               ),
//               Spacer(
//                 flex: 30,
//               )

//             ],
//             ),
//             // Button
//             ),
//           ),
//         ),
//     );
//   }
//  Widget _buildUrlText(String text, String url) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           PageRouteBuilder(
//             pageBuilder: (context, animation, secondaryAnimation) =>
//                 WebViewScreen(url: url),
//           ),
//         );
//       },
//       child: Text(
//         text,
//         style: TextStyle(
//           color: Color(0xff898989),
//           fontSize: 14.6,
//           fontStyle: FontStyle.italic,
//           fontWeight: FontWeight.w400,
//           fontFamily: 'PF BeauSans Pro',
//           decoration: TextDecoration.underline,
//         ),
//       ),
//     );
//   }

//   Future _setTunnelState(BuildContext context) async {
//     try {
//       final result = await platform.invokeMethod(
//         'setState',
//         jsonEncode(SetStateParams(
//           state: _connected,
//           tunnel: Tunnel(
//             name: _name,
//             address: _address,
//             dnsServer: _dnsServer,
//             listenPort: _listenPort,
//             peerAllowedIp: _peerAllowedIp,
//             peerEndpoint: _peerEndpoint,
//             peerPublicKey: _peerPublicKey,
//             privateKey: _privateKey,
//           ),
//         ).toJson()),
//       );
//       if (result == true) {
//         setState(() => _connected = !_connected);
//       }
//     } on PlatformException catch (e) {
//       l('_setState', e.toString());
//       _showError(context, e.toString());
//     }
//   }

//   _getTunnelNames(BuildContext context) async {
//     try {
//       final result = await platform.invokeMethod('getTunnelNames');
//     } on PlatformException catch (e) {
//       l('_getTunnelNames', e.toString());
//       _showError(context, e.toString());
//     }
//   }

//   _showError(BuildContext context, String error) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       behavior: SnackBarBehavior.floating,
//       content: Texts.semiBold(error, color: Colors.white),
//       backgroundColor: Colors.red[400],
//     ));
//   }

//   _showSuccess(BuildContext context, String error) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       behavior: SnackBarBehavior.floating,
//       content: Texts.semiBold(
//         error,
//         color: Colors.white,
//       ),
//       backgroundColor: Colors.green[500],
//     ));
//   }

//   _startGettingStats(BuildContext context) {
//     _gettingStatsTimer?.cancel();
//     _gettingStatsTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
//       if (!_gettingStats) {
//         timer.cancel();
//       }
//       try {
//         final result = await platform.invokeMethod('getStats', _name);
//         final stats = Stats.fromJson(jsonDecode(result));
//         setState(() => _stats = stats);
//       } catch (e) {
//         // can't get scaffold context from initState. todo: fix this
//         //_showError(context, e.toString());
//       }
//     });
//   }

//   _stopGettingStats() {
//     setState(() => _gettingStats = false);
//   }

//   Widget _input({
//     required String hint,
//     required ValueChanged<String> onChanged,
//     bool enabled = true,
//     required TextEditingController controller,
//   }) {
//     return Container(
//       padding: AppPadding.horizontalSmall,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: enabled ? Colors.white : Colors.grey[100],
//         border: Border.fromBorderSide(
//           BorderSide(
//             color: enabled ? Colors.black12 : Colors.black.withOpacity(0.05),
//             width: 1.0,
//           ),
//         ),
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Column(
//         children: [
//           const Vertical.micro(),
//           Row(
//             children: [
//               Texts(
//                 hint,
//                 textSize: AppSize.fontSmall,
//                 color: Colors.black38,
//                 height: 1.5,
//               ),
//             ],
//           ),
//           TextField(
//             enabled: enabled,
//             decoration: InputDecoration(
//               hintText: hint,
//               border: InputBorder.none,
//               isDense: true,
//             ),
//             style: GoogleFonts.openSans(
//               textStyle: TextStyle(fontWeight: FontWeight.w600),
//               height: 1.0,
//             ),
//             controller: controller,
//             onChanged: onChanged,
//           ),
//           const Vertical.micro(),
//         ],
//       ),
//     );
//   }

//   Widget _divider(String title) {
//     return Padding(
//       padding: AppPadding.verticalNormal,
//       child: Row(
//         children: [
//           Expanded(
//             child: Padding(
//               padding: AppPadding.rightNormal,
//               child: Container(
//                 height: 0.5,
//                 color: Colors.black.withOpacity(0.08),
//               ),
//             ),
//           ),
//           Texts.smallVery(
//             title.toUpperCase(),
//             color: Colors.black45,
//           ),
//           Expanded(
//             child: Padding(
//               padding: AppPadding.leftNormal,
//               child: Container(
//                 height: 0.5,
//                 color: Colors.black.withOpacity(0.08),
//               ),
//             ),
//           ),
//       ],
//       ),
//     );
//   }

//   Widget _statsWidget(Stats? stats) {
//     return Container(
//       padding: AppPadding.horizontalSmall,
//       //height: 60,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.fromBorderSide(
//           BorderSide(
//             color: Colors.black12,
//             width: 1.0,
//           ),
//         ),
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               children: [
//                 const Vertical.micro(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Texts(
//                       'Upload',
//                       textSize: AppSize.fontSmall,
//                       color: Colors.black38,
//                       height: 1.5,
//                     ),
//                   ],
//                 ),
//                 Texts.semiBold(
//                     _formatBytes(stats?.totalUpload.toInt() ?? 0, 0)),
//                 const Vertical.medium(),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Column(
//               children: [
//                 const Vertical.micro(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Texts(
//                       'Download',
//                       textSize: AppSize.fontSmall,
//                       color: Colors.black38,
//                       height: 1.5,
//                     ),
//                   ],
//                 ),
//                 Texts.semiBold(
//                     _formatBytes(stats?.totalDownload.toInt() ?? 0, 0)),
//                 const Vertical.medium(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String _formatBytes(int bytes, int decimals) {
//     if (bytes <= 0) return "0 B";
//     const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
//     var i = (log(bytes) / log(1024)).floor();
//     return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
//         ' ' +
//         suffixes[i];
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher.dart';

import 'package:wireguard_flutter/repository/models.dart';
import 'package:wireguard_flutter/shared_preferences.dart';
import 'package:wireguard_flutter/ui/common/app_router.dart';
import 'package:wireguard_flutter/ui/common/text_styles.dart';
import 'package:wireguard_flutter/ui/webview_screen.dart';

import '../log.dart';
import 'common/texts.dart';
import 'ui_constants.dart';

String initName = 'my-tunnel';
String initAddress = "10.10.0.4/32";
String initPort = "1280";
String initDnsServer = "8.8.8.8";
String initPrivateKey = "2P23r4Oj0wZEoMdXwJv3gVOYCkhPCrnG0AtRQ1G/m1U=";
String initAllowedIp = "0.0.0.0/0";

const String ruEndpoint = "ru-m9-vpn-p01.v-tell.com:443";
const String netherlandsEndpoint = "nl-m4-vpn-p01.v-tell.com:443";
const String usaEndpoint = "us-bc-vpn-p01.v-tell.com:443";

const String usaPublicKey = "WPte+VNVZknRVDEi2OmlUzBL6GwM5d06NxQAKSDAsws=";
const String netherlandsPublicKey = "CBgJnWnvHOU7Y8eiM+Zf84lkjflNYBraGWZe/QSknWE=";
const String russiaPublicKey = "4OifycfgqkoPNZmMxcopdxwP5fLH9xtRd1Or/nLGWkc=";

const List<String> publicKeys = [usaPublicKey,netherlandsPublicKey,russiaPublicKey];

String initPublicKey = usaPublicKey;

const List<String> peerEndpoints = [usaEndpoint,netherlandsEndpoint,ruEndpoint];

String initEndpoint = usaEndpoint;//"74.208.203.188:443";

bool isUploadedConfFile = false;

class TunnelDetails extends StatefulWidget {
  @override
  createState() => _TunnelDetailsState();
}

class _TunnelDetailsState extends State<TunnelDetails> {
  static const platform = const MethodChannel('tark.pro/wireguard-flutter');
  String _name = initName;
  String _address = initAddress;
  String _listenPort = initPort;
  String _dnsServer = initDnsServer;
  String _privateKey = initPrivateKey;
  String _peerAllowedIp = initAllowedIp;
  String _peerPublicKey = initPublicKey;
  String _peerEndpoint = initEndpoint;
  bool _connected = false;
  bool _scrolledToTop = true;
  bool _gettingStats = true;
  Stats? _stats;
  Timer? _gettingStatsTimer;

  int sliderIndex = -1;

  bool isLoading = false;

  void onSwitchChange(int index, BuildContext context) async {
    if (!isUploadedConfFile) {
      _showError(context, 'Upload V-Tell VPN key');
      return;
    }
    if (isLoading) return;
    isLoading = true;
    if (sliderIndex != -1) {
      sliderIndex = -1;
    } else {
      sliderIndex = index;
      _peerPublicKey = publicKeys[index];
      _peerEndpoint = peerEndpoints[index];
    }
    _connected = sliderIndex != -1;
    setState(() {});
    await _setTunnelState(context);
    isLoading = false;
  }

  // ! при перезаходе в приложение туннели переставали работать - fix
  void checkIfConfigDataStored() async {
    var isConfigDataStored = await MySharedPreferences().getConfigString();
    isUploadedConfFile =  isConfigDataStored != null;
    print(isUploadedConfFile);
  }

  @override
  void initState() {
    super.initState();
    // ! при перезаходе в приложение туннели перестают работать
    checkIfConfigDataStored();
    _connected = isUploadedConfFile;
    if (!isUploadedConfFile) {
      _setTunnelState(context);
    }
    platform.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onStateChange':
          try {
            final stats = StateChangeData.fromJson(jsonDecode(call.arguments));
            if (stats.tunnelState) {
              setState(() => _connected = true);
              _startGettingStats(context);
            } else {
              setState(() => _connected = false);
              _stopGettingStats();
            }
          } catch (e) {
            l('initState', 'error', e);
          }

          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: NotificationListener<ScrollUpdateNotification>(
          onNotification: (notification) {
            setState(() => _scrolledToTop = notification.metrics.pixels == 0);
            return true;
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'V-Tell VPN',
                          style: TextStyles.regular14,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // launch('https://v-tell.com/vpn');
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation,
                                    secondaryAnimation) =>
                                WebViewScreen(url: 'https://v-tell.com/vpn'),
                          ),
                        );
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SvgPicture.asset('assets/icon/burger.svg'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icon/us.svg',
                    ),
                    SizedBox(width: 15),
                    Text(
                      'USA',
                      style: TextStyles.regular16,
                    ),
                    const Spacer(),
                    CupertinoSwitch(
                      trackColor: Color(0xffd0d2d1),
                      value: sliderIndex == 0,
                      onChanged: (res) {
                        onSwitchChange(res ? 0 : -1, context);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icon/nl.svg',
                    ),
                    SizedBox(width: 15),
                    Text(
                      'Netherlands',
                      style: TextStyles.regular16,
                    ),
                    const Spacer(),
                    CupertinoSwitch(
                      trackColor: Color(0xffd0d2d1),
                      value: sliderIndex == 1,
                      onChanged: (res) {
                        onSwitchChange(res ? 1 : -1, context);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icon/ru.svg',
                    ),
                    SizedBox(width: 15),
                    Text(
                      'Russia',
                      style: TextStyles.regular16,
                    ),
                    const Spacer(),
                    CupertinoSwitch(
                      trackColor: Color(0xffd0d2d1),
                      value: sliderIndex == 2,
                      onChanged: (res) {
                        onSwitchChange(res ? 2 : -1, context);
                      },
                    ),
                  ],
                ),
                Spacer(
                  flex: 394,
                ),
                GestureDetector(
                  onTap: () {
                    MySharedPreferences().removeConfigString();
                    context.router.pushAndPopUntil(
                      OnBoardingPageScreenRoute(),
                      predicate: (route) => false,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    height: 32,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    color: Color(0xffE31F25),
                    child: Text(
                      'Log out',
                      style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Spacer(
                  flex: 22,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      _buildUrlText('V-Tell Homepage', 'https://v-tell.com'),
                      Spacer(),
                      _buildUrlText('V-Tell App',
                          'https://play.google.com/store/apps/details?id=com.vtellapp'),
                    ],
                  ),
                ),
                Spacer(
                  flex: 30,
                )
              ],
            ),
            // Button
          ),
        ),
      ),
    );
  }

  Widget _buildUrlText(String text, String url) {
    return GestureDetector(
      onTap: () {
        // if (url.startsWith("https://play.google.com")) {
        //   launch(url);
        // } else {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                WebViewScreen(url: url),
          ),
        );
        // }
      },
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xff898989),
          fontSize: 14.6,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w400,
          fontFamily: 'PF BeauSans Pro',
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Future _setTunnelState(BuildContext context) async {
    try {
      final result = await platform.invokeMethod(
        'setState',
        jsonEncode(SetStateParams(
          state: _connected,
          tunnel: Tunnel(
            name: _name,
            address: _address,
            dnsServer: _dnsServer,
            listenPort: _listenPort,
            peerAllowedIp: _peerAllowedIp,
            peerEndpoint: _peerEndpoint,
            peerPublicKey: _peerPublicKey,
            privateKey: _privateKey,
          ),
        ).toJson()),
      );
      if (result == true) {
        setState(() => _connected = !_connected);
      }
    } on PlatformException catch (e) {
      l('_setState', e.toString());
      _showError(context, e.toString());
      setState(() => _connected = !_connected);
    }
  }

  _getTunnelNames(BuildContext context) async {
    try {
      final result = await platform.invokeMethod('getTunnelNames');
    } on PlatformException catch (e) {
      l('_getTunnelNames', e.toString());
      _showError(context, e.toString());
    }
  }

  _showError(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Texts.semiBold(error, color: Colors.white),
      backgroundColor: Colors.red[400],
    ));
  }

  _showSuccess(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Texts.semiBold(
        error,
        color: Colors.white,
      ),
      backgroundColor: Colors.green[500],
    ));
  }

  _startGettingStats(BuildContext context) {
    _gettingStatsTimer?.cancel();
    _gettingStatsTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (!_gettingStats) {
        timer.cancel();
      }
      try {
        final result = await platform.invokeMethod('getStats', _name);
        final stats = Stats.fromJson(jsonDecode(result));
        setState(() => _stats = stats);
      } catch (e) {
        // can't get scaffold context from initState. todo: fix this
        //_showError(context, e.toString());
      }
    });
  }

  _stopGettingStats() {
    setState(() => _gettingStats = false);
  }

  Widget _input({
    required String hint,
    required ValueChanged<String> onChanged,
    bool enabled = true,
    required TextEditingController controller,
  }) {
    return Container(
      padding: AppPadding.horizontalSmall,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: enabled ? Colors.white : Colors.grey[100],
        border: Border.fromBorderSide(
          BorderSide(
            color: enabled ? Colors.black12 : Colors.black.withOpacity(0.05),
            width: 1.0,
          ),
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          const Vertical.micro(),
          Row(
            children: [
              Texts(
                hint,
                textSize: AppSize.fontSmall,
                color: Colors.black38,
                height: 1.5,
              ),
            ],
          ),
          TextField(
            enabled: enabled,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              isDense: true,
            ),
            style: GoogleFonts.openSans(
              textStyle: TextStyle(fontWeight: FontWeight.w600),
              height: 1.0,
            ),
            controller: controller,
            onChanged: onChanged,
          ),
          const Vertical.micro(),
        ],
      ),
    );
  }

  Widget _divider(String title) {
    return Padding(
      padding: AppPadding.verticalNormal,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: AppPadding.rightNormal,
              child: Container(
                height: 0.5,
                color: Colors.black.withOpacity(0.08),
              ),
            ),
          ),
          Texts.smallVery(
            title.toUpperCase(),
            color: Colors.black45,
          ),
          Expanded(
            child: Padding(
              padding: AppPadding.leftNormal,
              child: Container(
                height: 0.5,
                color: Colors.black.withOpacity(0.08),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statsWidget(Stats? stats) {
    return Container(
      padding: AppPadding.horizontalSmall,
      //height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.fromBorderSide(
          BorderSide(
            color: Colors.black12,
            width: 1.0,
          ),
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const Vertical.micro(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Texts(
                      'Upload',
                      textSize: AppSize.fontSmall,
                      color: Colors.black38,
                      height: 1.5,
                    ),
                  ],
                ),
                Texts.semiBold(
                    _formatBytes(stats?.totalUpload.toInt() ?? 0, 0)),
                const Vertical.medium(),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Vertical.micro(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Texts(
                      'Download',
                      textSize: AppSize.fontSmall,
                      color: Colors.black38,
                      height: 1.5,
                    ),
                  ],
                ),
                Texts.semiBold(
                    _formatBytes(stats?.totalDownload.toInt() ?? 0, 0)),
                const Vertical.medium(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }
}
