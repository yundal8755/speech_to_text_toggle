import 'package:flutter/material.dart';
import 'package:speech_to_text_toggle_example/common/app_color.dart';
import 'package:speech_to_text_toggle_example/common/app_image_path.dart';

class SpeechMode extends StatelessWidget {
  final VoidCallback onCircleButtonPressed; // 버튼 누를 때 호출될 콜백

  const SpeechMode({super.key, required this.onCircleButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 36),
      child: Center(
        child: Column(children: [
          GestureDetector(
            onTap: onCircleButtonPressed,
            child: Container(
              width: 112,
              height: 112,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.blueGrey,
              ),
              child: const Center(
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.white,
                  child: Icon(
                    size: 48,
                    Icons.mic,
                    color: AppColor.mainBlue,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onCircleButtonPressed,
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColor.blueGrey,
                    child: Image.asset(AppImagePath.typingModeIcon,
                        color: AppColor.mainBlue),
                  ),
                ),
                GestureDetector(
                  onTap: onCircleButtonPressed,
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColor.backgroundGrey,
                    child: Image.asset(AppImagePath.cancleIcon,
                        color: AppColor.mainGrey),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
