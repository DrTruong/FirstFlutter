import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus { available, notNetwork, noInternet }

class CheckNetworkBody extends StatefulWidget {
  const CheckNetworkBody({super.key});

  @override
  State<CheckNetworkBody> createState() => _CheckNetworkBodyState();
}

class _CheckNetworkBodyState extends State<CheckNetworkBody> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
          NetworkStatus status;
          if (snapshot.hasData) {
            ConnectivityResult? result = snapshot.data;
            if (result == ConnectivityResult.mobile ||
                result == ConnectivityResult.wifi) {
              status = NetworkStatus.available;
            } else {
              status = NetworkStatus.notNetwork;
            }
          } else {
            status = NetworkStatus.noInternet;
          }
          return AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            color: changeColorNetwork(status),
            width: double.infinity,
            height: double.infinity,
            child: changeIconNetwork(status),
          );
        });
  }

  Color? changeColorNetwork(NetworkStatus status) {
    return status == NetworkStatus.available
        ? Colors.green[100]
        : status == NetworkStatus.notNetwork
            ? Colors.pink[100]
            : Colors.red;
  }

  Icon? changeIconNetwork(NetworkStatus status) {
    return Icon(status == NetworkStatus.available
        ? Icons.wifi
        : status == NetworkStatus.notNetwork
            ? Icons.wifi_off_sharp
            : Icons.no_cell_sharp);
  }
}
