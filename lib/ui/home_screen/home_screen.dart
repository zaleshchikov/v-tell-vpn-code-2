import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wireguard_flutter/repository/models.dart';
import 'package:wireguard_flutter/ui/common/text_styles.dart';
import '../common/button.dart';
import 'cubit/cb_home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget implements AutoRouteWrapper {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbHomeScreen>(
      create: (context) => CbHomeScreen(),
      child: this,
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int sliderIndex = -1;

  static const platform = const MethodChannel('tark.pro/wireguard-flutter');
  static const initName = 'my-tunnel';
  static const initAddress = "10.200.200.185";
  static const initPort = "51820";
  static const initDnsServer = "116.203.231.122";//"8.8.8.8";//
  static const initPrivateKey = "mIWKevXKBlBxXEAtzJJtLOU0TjSduvvm9rUQpvdPBkM=";
  static const initAllowedIp = "0.0.0.0/0";
  static const initPublicKey = "9Xhc/RmDmmyy54+F/mhSh1KEV0/bjD6ruAp934pmlDk=";
  static const initEndpoint = "wghongkong01.spidervpnservers.com:443";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<CbHomeScreen, StHomeScreen>(
        builder: (context, state) => state.when(
          loading: () => Placeholder(),
          error: (code, message) => const Placeholder(),
          loaded: () => Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  'V-Tell VPN',
                  style: TextStyles.regular14,
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icon/us.svg',
                          ),
                          SizedBox(width: 35),
                          Text('USA', style: TextStyles.regular16,),
                          const Spacer(),
                          CupertinoSwitch(
                            value: sliderIndex == index,
                            onChanged: (res) {
                              setState(() {
                                res ? sliderIndex = index : sliderIndex = -1;
                              });
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 0),
                Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Row(
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
                            value: sliderIndex == index,
                            onChanged: (res) {
                              setState(() {
                                res ? sliderIndex = index : sliderIndex = -1;
                              });
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 0),
                Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Row(
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
                            value: sliderIndex == index,
                            onChanged: (res) {
                              setState(() {
                                res ? sliderIndex = index : sliderIndex = -1;
                              });
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
                // Button
                SizedBox(height: 0),
                Button(
                  text: 'Logout',
                  onTap: () {},
                  isActive: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
