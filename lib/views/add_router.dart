import 'dart:async';
import '../bottom_nav_bar.dart';
import '../controllers/storage.dart';
import '../models/router_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import '../constants.dart';
import '../controllers/add_router_cont.dart';
import '../controllers/apis.dart';
import '../controllers/permission.dart';
import '../models/switch_initial.dart';
import '../widgets/custom_appbar.dart';

class NewRouterInstallationPage extends StatefulWidget {
  NewRouterInstallationPage({super.key});

  @override
  State<NewRouterInstallationPage> createState() =>
      _NewRouterInstallationPageState();
}

class _NewRouterInstallationPageState extends State<NewRouterInstallationPage> {
  StorageController _storage = StorageController();

  final TextEditingController _switchId = TextEditingController();

  final TextEditingController _switchName = TextEditingController();

  final TextEditingController _privatePin = TextEditingController();

  final TextEditingController _ssid = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final formKey = GlobalKey<FormState>();
  ConnectivityResult _connectionStatusS = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _initNetworkInfo();
    getSwitchId();
    getSwitchName();
    getPrivatePin();

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      _updateConnectionStatus(results);
    });
  }

  String? switchID;
  getSwitchId() async {
    List<SwitchDetails> switches = await _storage.readSwitches();
    for (var element in switches) {
      if (_connectionStatus.contains(element.switchSSID)) {
        setState(() {
          switchID = element.switchld;
          _switchId.text = element.switchld;
        });
        break;
      }
    }
  }

  String? switchName;
  getSwitchName() async {
    List<SwitchDetails> switches = await _storage.readSwitches();
    for (var element in switches) {
      if (_connectionStatus.contains(element.switchSSID)) {
        setState(() {
          switchName = element.switchSSID;
          _switchName.text = element.switchSSID;
        });
        break;
      }
    }
  }

  String? privatePin;
  getPrivatePin() async {
    List<SwitchDetails> switches = await _storage.readSwitches();
    for (var element in switches) {
      if (_connectionStatus.contains(element.switchSSID)) {
        setState(() {
          privatePin = element.privatePin;
          _privatePin.text = element.privatePin;
        });
        break;
      }
    }
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
    for (var result in results) {
      _initNetworkInfo(); // Process each result as needed
    }
  }
  String _connectionStatus = 'Unknown';
  final NetworkInfo _networkInfo = NetworkInfo();
  Future<void> _initNetworkInfo() async {
    String? wifiName,
        wifiBSSID,
        wifiIPv4,
        wifiIPv6,
        wifiGatewayIP,
        wifiBroadcast,
        wifiSubmask;

    try {
      await requestPermission(Permission.nearbyWifiDevices);
      // await requestPermission(Permission.locationWhenInUse);
    } catch (e) {}

    try {
      if (!kIsWeb && Platform.isIOS) {
        // ignore: deprecated_member_use
        var status = await _networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          // ignore: deprecated_member_use
          status = await _networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiName = await _networkInfo.getWifiName();
        } else {
          wifiName = await _networkInfo.getWifiName();
        }
      } else {
        wifiName = await _networkInfo.getWifiName();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi Name', error: e);
      wifiName = 'Failed to get Wifi Name';
    }

    try {
      if (!kIsWeb && Platform.isIOS) {
        // ignore: deprecated_member_use
        var status = await _networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          // ignore: deprecated_member_use
          status = await _networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiBSSID = await _networkInfo.getWifiBSSID();
        } else {
          wifiBSSID = await _networkInfo.getWifiBSSID();
        }
      } else {
        wifiBSSID = await _networkInfo.getWifiBSSID();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi BSSID', error: e);
      wifiBSSID = 'Failed to get Wifi BSSID';
    }

    try {
      wifiIPv4 = await _networkInfo.getWifiIP();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi IPv4', error: e);
      wifiIPv4 = 'Failed to get Wifi IPv4';
    }

    try {
      if (!Platform.isWindows) {
        wifiIPv6 = await _networkInfo.getWifiIPv6();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi IPv6', error: e);
      wifiIPv6 = 'Failed to get Wifi IPv6';
    }

    try {
      if (!Platform.isWindows) {
        wifiSubmask = await _networkInfo.getWifiSubmask();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi submask address', error: e);
      wifiSubmask = 'Failed to get Wifi submask address';
    }

    try {
      if (!Platform.isWindows) {
        wifiBroadcast = await _networkInfo.getWifiBroadcast();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi broadcast', error: e);
      wifiBroadcast = 'Failed to get Wifi broadcast';
    }

    try {
      if (!Platform.isWindows) {
        wifiGatewayIP = await _networkInfo.getWifiGatewayIP();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi gateway address', error: e);
      wifiGatewayIP = 'Failed to get Wifi gateway address';
    }

    setState(() {
      _connectionStatus = wifiName!.toString();
      // 'Wifi BSSID: $wifiBSSID\n'
      // 'Wifi IPv4: $wifiIPv4\n'
      // 'Wifi IPv6: $wifiIPv6\n'
      // 'Wifi Broadcast: $wifiBroadcast\n'
      // 'Wifi Gateway: $wifiGatewayIP\n'
      // 'Wifi Submask: $wifiSubmask\n';
    });
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: CustomAppBar(heading: "Add Router")),
        body: Center(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // TextFormField(
                  //   controller: _switchId,
                  //   validator: (value) {
                  //     if (value!.length <= 0) return "Switch ID cannot be empty";
                  //   },
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(20),
                  //       // borderSide: BorderSide(width: 40),
                  //     ),
                  //     labelText: "Switch ID",
                  //     labelStyle: TextStyle(fontSize: 15),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  TextFormField(
                    controller: _ssid,
                    validator: (value) {
                      if (value!.isEmpty) return "SSID cannot be empty";
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        // borderSide: BorderSide(width: 40),
                      ),
                      labelText: "New Router Name",
                      labelStyle: const TextStyle(fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _password,
                    validator: (value) {
                      if (value!.length <= 7) {
                        return "Router Password cannot be less than 8 letters";
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        // borderSide: BorderSide(width: 40),
                      ),
                      labelText: "New Router Password",
                      labelStyle: const TextStyle(fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  loading
                      ? Align(
                          // alignment: AlignmentDirectional(1, 0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 0, 16, 16),
                            child: InkWell(
                              splashColor: backGroundColour,
                              // onTap: onPressed,
                              child: Container(
                                width: 300,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: backGroundColour ?? backGroundColour,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 1,
                                      color:
                                          backGroundColour ?? backGroundColour,
                                      offset: const Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: backGroundColour ?? backGroundColour,
                                    width: 1,
                                  ),
                                ),
                                alignment: const AlignmentDirectional(0, 0),
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        )
                      : CustomButton(
                          text: "Submit",
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              try {
                                setState(() {
                                  loading = true;
                                });
                                await getSwitchId();
                                await getSwitchName();
                                await getPrivatePin();
                                String ssidd = _connectionStatus.substring(1, _connectionStatus.length - 1);
                                String? passkey = await RouterAddController().fetchSwitches(ssidd);
                                if (passkey == null) {
                                  showToast(context,
                                      "No switch found with switch $ssidd");
                                  return;
                                }
                                showToast(context,
                                    "You are connected to $_connectionStatus");
                                await ApiConnect.hitApiGet(
                                  routerIP + "/",
                                );
                                print({
                                  "router_ssid": _ssid.text,
                                  "router_password": _password.text,
                                  "switch_passkey": passkey
                                });
                                var res = await ApiConnect.hitApiPost(
                                    "$routerIP/getWifiParem", {
                                  "router_ssid": _ssid.text,
                                  "router_password": _password.text,
                                  "switch_passkey": passkey
                                });
                                String IPAddr = res['IPAddress'];
                                if (IPAddr.contains("0.0.0.0")) {
                                  showToast(context, "Unable to connect. Try Again.");
                                  setState(() {
                                    loading = false;
                                  });
                                  return;
                                }
                                setState(() {
                                  loading = false;
                                });
                                RouterDetails routerDetails = RouterDetails(
                                  switchID: _switchId.text,
                                  name: _ssid.text,
                                  password: _password.text,
                                  switchPasskey: passkey,
                                  iPAddress: res['IPAddress'],
                                  switchName: _switchName.text,
                                  privatePin: _privatePin.text,);
                                bool exists = await _storage.isSwitchIDExists(_switchId.text);
                                //String? IP = await _storage.getIpAdderss(_switchId.text);
                                if (exists) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Switch ID Already Exists"),
                                        content: const Text("Do you want to update the existing router Details?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () async{
                                              await _storage.cancelUpdateRouter(_switchId.text, res['IPAddress']!);
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => const MyNavigationBar()));
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              await _storage.updateRouterDetails(_switchId.text, routerDetails);
                                              Navigator.of(context).pop();
                                              showToast(context, "Router updated successfully.");
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => MyNavigationBar(),
                                                ),
                                              );
                                            },
                                            child: Text("Update"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                                else {
                                  setState(() {
                                    loading = true;
                                  });
                                  _storage.addRouters(context, routerDetails);
                                  setState(() {
                                    loading = false;
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MyNavigationBar()));
                                }
                              } catch (e) {
                                print("error ${e.toString()}");
                                showToast(
                                    context, "Unable to connect. Try Again.");
                                setState(() {
                                  loading = false;
                                });
                              }
                            }
                          },
                        )
                ],
              ),
            ),
          ),
        ));
  }
}
