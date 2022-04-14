import 'package:flutter/material.dart';
import 'package:web3_flutter/base/view_model_provider_widget.dart';
import 'package:web3_flutter/feature/home/home_view_model.dart';
import 'package:web3_flutter/feature/home/widget/connect_wallet_button_widget.dart';
import 'package:web3_flutter/feature/home/widget/home_content_widget.dart';
import 'package:web3_flutter/feature/home/widget/not_supported_message_widget.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelProviderWidget<HomeViewModel>(
        onModelProvided: (model) => model.onInit(),
        builder: (context, model, _) {
          if (model.isWalletConnectReady) {
            return const HomeContentWidget();
          }

          if (model.isEnabled) {
            return const ConnectWalletButtonWidget();
          }

          return const NotSupportedMessageWidget();
        },
      ),
    );
  }
}
