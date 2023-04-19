import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:major_project/widgets/err.dart';
import 'package:major_project/widgets/generate_btn.dart';
import 'package:major_project/widgets/image_widget.dart';
import 'dart:convert';
import '../models/item_model.dart';
import 'dart:math';

class PromptForm extends StatefulWidget {
  String? chosenValue;
  String? imageSource;
  Items? item;
  PromptForm(this.item, this.imageSource, this.chosenValue);

  @override
  State<PromptForm> createState() => _PromptFormState();
}

class _PromptFormState extends State<PromptForm> {
  final _key = GlobalKey<FormState>();
  final _prompt = TextEditingController();
  var _isLoading = false;
  bool _valid = true;
  var statusCode = 0;
  final url = Uri.https("tasty-bear-76.loca.lt", "/text2img");
  Random random = Random();
  int? seed;
  Future<void> postRequest() async {
    setState(() {
      _isLoading = true;
      seed = random.nextInt(100);
    });
    final response = await http.post(
      url,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: json.encode({
        "prompt": _prompt.text,
        "negative_prompt": "string",
        "scheduler": "EulerAncestralDiscreteScheduler",
        "image_height": 512,
        "image_width": 512,
        "num_images": 1,
        "guidance_scale": 7,
        "steps": 150,
        "seed": seed
      }),
    );
    final responseBody = jsonDecode(response.body);
    statusCode = response.statusCode;
    if (statusCode != 404) {
      final base64Img = responseBody['images'].toString();
      widget.imageSource = base64Img.substring(1, base64Img.length - 1);
    } else {
      widget.imageSource = '';
    }
    setState(() {
      _isLoading = false;
    });
  }

  bool validator(String val) {
    for (var element in widget.item!.validation) {
      if (val.contains(element)) {
        _valid = true;
        return _valid;
      } else {
        _valid = false;
      }
    }
    return _valid;
  }

  @override
  void dispose() {
    super.dispose();
    _prompt.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: 350,
          decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.only(left: 10, bottom: 10, top: 5),
          child: Form(
            key: _key,
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter a promt";
                }
                if (!validator(value.toLowerCase())) {
                  return "The input must contain ${widget.item!.validation.map((e) => e)}";
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Description Of Image'),
              controller: _prompt,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        GenerateBtn(_isLoading, postRequest, widget.chosenValue, _key),
        widget.imageSource == null || _isLoading
            ? Container()
            : statusCode == 404
                ? const Err()
                : ImageWidget(widget.imageSource, _prompt.text)
      ],
    );
  }
}
