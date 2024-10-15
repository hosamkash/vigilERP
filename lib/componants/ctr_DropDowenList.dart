import 'package:flutter/material.dart';

class ctr_DropDowenList extends StatefulWidget {
  @override
  _ctr_DropDowenListState createState() => _ctr_DropDowenListState();

  // bool? autoSelectedFrist;
  int? selectedValue;
  String hintLable;
  bool showClearIcon;
  List<DropDowenDataSource> lstDataSource;
  TextStyle? itemsTextStyle;
  TextStyle? hintTextStyle;
   EdgeInsets? padding;
   double? height;
  double? menuMaxHeightValue;
  BorderRadius? borderRadius;
  late int? Function(int? selectedID)? OnChanged;
  late String? Function(int?)? OnValidate;

  ctr_DropDowenList({
    // this.autoSelectedFrist,
    this.selectedValue,
    this.showClearIcon = true,
    this.hintLable = '',
    this.lstDataSource = const [],
    this.itemsTextStyle,
    this.hintTextStyle,
    this.padding,
    this.height,
    this.menuMaxHeightValue,
    this.borderRadius,
    this.OnChanged,
    this.OnValidate,
  });
}

class DropDowenDataSource {
  final int? branchID;
  final int valueMember;
  final String displayMember;
  final String displayMemberMore;

  DropDowenDataSource({required this.valueMember, required this.displayMember, this.displayMemberMore = '', this.branchID});
}

class _ctr_DropDowenListState extends State<ctr_DropDowenList> {
  @override
  Widget build(BuildContext context) {
    // print(widget.selectedValue != null && widget.lstDataSource.any((xx) => xx.valueMember == widget.selectedValue));
    // if (widget.selectedValue != null && !widget.lstDataSource.any((xx) => xx.valueMember == widget.selectedValue)) {
    //   return Container(
    //     color: Colors.white,
    //     child: const Text('العنصر المختار كقيمة افتراضية خطأ'),
    //   );
    // }

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: widget.padding ?? EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 5),
            height: widget.height ?? 45,
            child: DropdownButtonFormField<int>(
              value: widget.selectedValue,
              hint: Text(widget.hintLable),
              style:  const TextStyle(fontSize: 17, color: Colors.black, height: 0.2),
              iconSize: 22,

              items: widget.lstDataSource.map((selectedItem) {

                return DropdownMenuItem<int>(
                  value: selectedItem.valueMember,
                  child: Text('${selectedItem.displayMember}${selectedItem.displayMemberMore.isEmpty ? '' : ' ${selectedItem.displayMemberMore}'}'),
                );
              }).toList(),
              onChanged: (int? newId) {
                setState(() {
                  widget.selectedValue = newId;
                  if (widget.OnChanged != null) {
                    widget.OnChanged!(widget.selectedValue!);
                    print('Selected Id ${widget.selectedValue}');
                  }
                });
              },
              validator: widget.OnValidate,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
              ),
              dropdownColor: Colors.white,
              elevation: 2,
              menuMaxHeight: widget.menuMaxHeightValue ?? 250,
              borderRadius: widget.borderRadius,
            ),
          ),
        ),
        if (widget.showClearIcon == true)
          IconButton(
            onPressed: () {
              setState(() {
                // print('selectedValue --------- ${widget.selectedValue}');
                widget.selectedValue = null;
                widget.OnChanged!(null);
              });
            },
            icon: const Icon(Icons.clear),
            color: Colors.black,
          ),
      ],
    );
  }
}
