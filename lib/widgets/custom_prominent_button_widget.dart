import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomProminentButtonWidget extends StatelessWidget {
  const CustomProminentButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
    this.isLoading = false,
    this.width = double.infinity,
  }) : super(key: key);

  final String text;
  final VoidCallback onClicked;
  final bool isLoading;
  final double width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        height: 48,
        width: width,
        decoration: const BoxDecoration(
          color: Color(0xff03dac6),
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(14, 14, 44, 0.4),
              offset: Offset(0, 1),
            )
          ],
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : Text(
                  text,
                  style: const TextStyle(fontSize: kIsWeb ? 28 : 14),
                ),
        ),
      ),
    );
  }
}
