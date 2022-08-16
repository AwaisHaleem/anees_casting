import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Models/category.dart';
import '../../../../Widget/adaptive_indecator.dart';
import '../../../../Widget/customautocomplete.dart';
import '../../../../Widget/dropDown.dart';
import '../../../../Widget/input_feild.dart';
import '../../../../Widget/submitbutton.dart';
import '../../../../contant.dart';

class AddProductFeilds extends StatefulWidget {
  @override
  State<AddProductFeilds> createState() => _AddProductFeildsState();
}

class _AddProductFeildsState extends State<AddProductFeilds> {
  final _prodNameController = TextEditingController();

  final _prodLengthController = TextEditingController();

  final _prodWidthController = TextEditingController();

  bool isFirst = true;

  String prodUnit = "CM";

  Category? category;

  Uint8List? image;

  String? downloadImgUrl;

  bool isLoading = false;

  @override
  void didChangeDependencies() {
    if (isFirst) {
      isFirst = false;
      Provider.of<Categories>(context, listen: false).fetchAndUpdateCat();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<Category> categories =
        Provider.of<Categories>(context, listen: true).categories;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              width: width(context) * 80,
              height: height(context) * 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: primaryColor.withOpacity(0.5),
                    width: 2,
                    style: BorderStyle.solid,
                  )),
              child: image != null
                  ? Image.memory(
                      image!,
                      fit: BoxFit.contain,
                    )
                  : Container(),
            ),
            Positioned(
                right: 1,
                bottom: 1,
                child: IconButton(
                    onPressed: () async {
                      FilePickerResult? result1 =
                          await FilePicker.platform.pickFiles();
                      setState(() {
                        image = result1?.files.first.bytes;
                      });
                    },
                    icon: Icon(
                      Icons.add_a_photo_outlined,
                      color: primaryColor.withOpacity(0.5),
                      size: 30,
                    ))),
          ],
        ),
        SizedBox(
          height: height(context) * 5,
        ),
        CustomAutoComplete(
          categories: categories,
          onChange: (Category cat) {
            category = cat;
          },
        ),
        SizedBox(
          height: height(context) * 2,
        ),
        InputFeild(
            hinntText: 'Enter Article Number',
            validatior: () {},
            inputController: _prodNameController),
        SizedBox(
          height: height(context) * 2,
        ),
        Row(
          children: [
            Expanded(
              child: InputFeild(
                  hinntText: 'Length',
                  validatior: () {},
                  inputController: _prodLengthController),
            ),
            SizedBox(
              width: width(context) * 3,
            ),
            Expanded(
              child: InputFeild(
                  hinntText: 'Width',
                  validatior: () {},
                  inputController: _prodWidthController),
            ),
          ],
        ),
        SizedBox(
          height: height(context) * 2,
        ),
        Row(
          children: [
            Expanded(flex: 2, child: Container()),
            Expanded(
              flex: 4,
              child: CustomDropDown(
                items: const ['Cm', 'MM'],
                onChanged: (String value) {
                  prodUnit = value;
                },
              ),
            ),
            Expanded(flex: 2, child: Container()),
          ],
        ),
        SizedBox(
          height: height(context) * 5,
        ),
        isLoading
            ? AdaptiveIndecator(
                color: primaryColor,
              )
            : SubmitButton(
                height: height(context),
                width: width(context),
                onTap: () {
                  // args["action"] == "add"
                  //     ? _addProduct(image)
                  //     : _editProduct(
                  //         img: image,
                  //         prodId: (args["product"] as Product).id,
                  //         imageUrl: (args["product"] as Product).image);
                },
                title: 'Add Design',
              )
      ],
    );
  }
}
