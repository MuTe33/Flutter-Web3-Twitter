import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3_wave_portal/feature/home/home_view_model.dart';
import 'package:web3_wave_portal/feature/home/widget/bottom_sheet_widget.dart';
import 'package:web3_wave_portal/feature/home/widget/welcome_message_widget.dart';

class HomeContentWidget extends StatelessWidget {
  const HomeContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 16),
              const WelcomeMessageWidget(),
              if (model.isLoading)
                const Center(child: CircularProgressIndicator())
              else ...[
                const SizedBox(height: 32),
                Text(
                  'Total Waves: ${model.totalWaves}',
                  style: const TextStyle(fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff03dac6)),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'From: ${model.allWaves[index].formattedAddress}'),
                              const SizedBox(height: 8),
                              Text(
                                'Timestamp: ${model.allWaves[index].formattedTimeStamp}',
                              ),
                              const SizedBox(height: 8),
                              Text('Message: ${model.allWaves[index].message}'),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(
                              Icons.call_made_outlined,
                              size: 16,
                            ),
                            onPressed: () async {
                              final etherscanLink = join(
                                'https://rinkeby.etherscan.io/address',
                                model.allWaves[index].address.hex,
                              );

                              if (await canLaunch(etherscanLink)) {
                                await launch(etherscanLink);
                              }
                            },
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        thickness: 2,
                        color: Color(0xff03dac6),
                      );
                    },
                    itemCount: model.allWaves.length,
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useRootNavigator: true,
            enableDrag: true,
            clipBehavior: Clip.hardEdge,
            builder: (context) => ChangeNotifierProvider.value(
              value: model,
              child: BottomSheetWidget(),
            ),
          );
        },
        tooltip: 'wave',
        child: const Text('👋'),
      ),
    );
  }
}
