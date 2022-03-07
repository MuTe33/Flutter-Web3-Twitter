import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3_wave_portal/feature/home/home_view_model.dart';
import 'package:web3_wave_portal/widgets/custom_prominent_button_widget.dart';

class ConnectWalletButtonWidget extends StatelessWidget {
  const ConnectWalletButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeViewModel>();

    return Center(
      child: CustomProminentButtonWidget(
        width: 300,
        onClicked: model.onConnectClicked,
        text: 'Connect Wallet',
      ),
    );
  }
}
