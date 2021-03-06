import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3_flutter/feature/home/home_view_model.dart';
import 'package:web3_flutter/widgets/custom_prominent_button_widget.dart';
import 'package:web3_flutter/widgets/custom_text_form_field_widget.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({Key? key}) : super(key: key);

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeViewModel>();
    final viewInsets = MediaQuery.of(context).viewInsets;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: viewInsets.bottom,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 16),
                const Text(
                  'Coool, you made it until here, leave me a tweet if you want to :)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'There is a 10% chance to win some ETH 🥳',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomTextFormFieldWidget(
                    focusNode: _focusNode,
                    controller: _controller,
                    hintText: 'How is it going for you? :)',
                    errorText: model.hasError ? 'Something went wrong' : null,
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value == null || value.length > 70) {
                        return 'Sorry, too long :( It must be max. 70 characters';
                      }
                      _focusNode.unfocus();
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 24),
                CustomProminentButtonWidget(
                  text: 'Submit',
                  onClicked: () async {
                    if (_formKey.currentState?.validate() == false) {
                      model.setError();
                    } else {
                      await model.sendTweet(message: _controller.text);

                      Navigator.of(context).pop();
                    }
                  },
                  isLoading: model.isLoading,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
