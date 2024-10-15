import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../shared/sharedDesigne.dart';


class ctr_AutoCompleteFilter extends StatelessWidget {
  List<String>? lstData;
  late Icons? sufixIcon;
  late bool isEnabled = true;
  late InputBorder border = OutlineInputBorder();
  late TextInputType textType;
  late String lable;
  late Icon? prefixIcon;
  late Color? listBackColor;
  late String? selectedValue;
  late String? Function(String?)? OnValidate;
  late String? Function(String?)? OnChanged;
  late String? Function(String?)? OnSubmitted;
  late String? Function()? OnTap;
  late String? Function()? OnClearSelect;
  late String? Function(String?)? OnSelectItem;

  ctr_AutoCompleteFilter({
    Key? Key,
    this.lstData,
    this.sufixIcon,
    // this.IsobscureText = false,
    // this.txtController,
    // this.listViewController,
    this.isEnabled = true,
    this.border = const OutlineInputBorder(),
    this.textType = TextInputType.text,
    this.lable = '',
    this.prefixIcon,
    this.listBackColor = Colors.white,
    this.selectedValue = '',
    this.OnValidate,
    this.OnChanged,
    this.OnSubmitted,
    this.OnSelectItem,
    this.OnTap,
    this.OnClearSelect,
  }) : super(key: Key);

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Autocomplete<String>(
        onSelected: (value) {
          selectedValue = value;
          print(selectedValue);
          OnSelectItem!(selectedValue);
        },
        // البناء من لسته نصية
        optionsBuilder: (textEditingValue) {
          return lstData!.where((String item) {
            return item.toLowerCase().contains(textEditingValue.text.toLowerCase());
          });
        },
        fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
          textEditingController.text = selectedValue ?? '';
          // txtController = textEditingController;
          return Stack(
            children: [
              TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                keyboardType: textType,
                style:  const TextStyle(fontSize: 17, color: Colors.black, height: 0.3),
                decoration: InputDecoration(
                  enabled: isEnabled,
                  labelText: lable,
                  border: border,
                  prefixIcon: prefixIcon,
                  suffixIcon: IconButton(
                    onPressed: () {
                      selectedValue = '';
                      textEditingController.clear();
                      // txtController!.clear();
                      OnClearSelect!();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
                validator: OnValidate,
                onChanged: OnChanged,
                onFieldSubmitted: OnSubmitted,
                onTap: OnTap,
              ),
              Positioned(
                left: 30,
                top: 3,
                child: IconButton(
                  onPressed: () {
                    print(textEditingController.value);
                    textEditingController.selection = TextSelection(baseOffset: 0, extentOffset: 0);
                  },
                  icon: Icon(
                    Icons.hide_image_outlined,
                    color: sharedDesigne.primaryColor,
                    size: 25,
                  ),
                ),
              ),
            ],
          );
        },
        optionsViewBuilder: (context, onSelected, options) {
          return Conditional.single(
            context: context,
            conditionBuilder: (context) => options.length > 0,
            widgetBuilder: (context) =>
                Align(
              alignment: AlignmentDirectional.topStart,
              child: Container(
                width: 290,
                height: 200,
                color: listBackColor,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => onSelected(options.elementAt(index)),
                      child: Text(
                        options.elementAt(index),
                        style: selectedValue == options.elementAt(index)
                            ? const TextStyle(fontSize: 16, color: Colors.red)
                            : const TextStyle(fontSize: 16),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
