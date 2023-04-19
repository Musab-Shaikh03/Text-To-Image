import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class GenerateBtn extends StatelessWidget {
  final bool _isLoading;
  VoidCallback postRequest;
  String? chosenValue;
  final GlobalKey<FormState> _key;
  GenerateBtn(this._isLoading, this.postRequest, this.chosenValue, this._key,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Skeleton(
                    isLoading: _isLoading,
                    skeleton: SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          height: 290,
                          borderRadius: BorderRadius.circular(20),
                          width: 300),
                    ),
                    darkShimmerGradient: const LinearGradient(
                      colors: [
                        Color(0xFF222222),
                        Color(0xFF242424),
                        Color(0xFF2B2B2B),
                        Color(0xFF242424),
                        Color(0xFF222222),
                      ],
                      stops: [
                        0.0,
                        0.2,
                        0.5,
                        0.8,
                        1,
                      ],
                      begin: Alignment(-2.4, -0.2),
                      end: Alignment(2.4, 0.2),
                      tileMode: TileMode.clamp,
                    ),
                    child: const Center(child: Text("Loading")),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const BlinkText(
                    'Creating',
                    style: TextStyle(fontSize: 23.0, color: Colors.white),
                    endColor: Colors.red,
                  ),
                ],
              ),
            ],
          )
        : ElevatedButton(
            onPressed: chosenValue == null
                ? null
                : () {
                    if (_key.currentState!.validate()) {
                      postRequest();
                    }
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
            child: const Text('Generate'));
  }
}
