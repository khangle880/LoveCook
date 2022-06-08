import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../../resources/colors.dart';

class PickLookup<T> extends StatelessWidget {
  const PickLookup({
    Key? key,
    this.onChanged,
    this.onSaved,
    this.value,
    required this.getText,
    required this.hintText,
    required this.items,
  }) : super(key: key);
  final String Function(T item) getText;
  final Function(T?)? onChanged;
  final Function(T?)? onSaved;
  final String hintText;
  final T? value;
  final List<T> items;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      value: value,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(20, 0, 10, 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      isExpanded: true,
      hint: Text(
        hintText,
        style: TextStyle(fontSize: 14, color: AppColors.grayNormal),
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black45,
      ),
      iconSize: 30,
      buttonHeight: 40,
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: items
          .map((item) => DropdownMenuItem<T>(
                value: item,
                child: Text(
                  getText(item),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      selectedItemBuilder: (_) => items
          .map(
            (item) => DropdownMenuItem<T>(
                value: item,
                child: Text(
                  getText(item),
                  style: const TextStyle(
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
          )
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select an option.';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (value) {
        onChanged?.call(value);
      },
      onSaved: (value) {
        onSaved?.call(value);
      },
    );
  }
}

class MultiPickLookup<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T item) getText;
  final Function(List<T>?)? onChanged;
  final Function(List<T>?)? onSaved;
  final String hintText;
  final List<T>? selectedItems;
  const MultiPickLookup({
    Key? key,
    required this.items,
    required this.getText,
    required this.hintText,
    this.onChanged,
    this.onSaved,
    this.selectedItems,
  }) : super(key: key);

  @override
  State<MultiPickLookup<T>> createState() => _MultiPickLookupState<T>();
}

class _MultiPickLookupState<T> extends State<MultiPickLookup<T>> {
  late List<T> selectedItems;

  @override
  void initState() {
    selectedItems = widget.selectedItems ?? [];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (selectedItems != widget.selectedItems) {
      selectedItems = widget.selectedItems ?? [];
      setState(() {});
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      value: selectedItems.isEmpty ? null : selectedItems.first,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(20, 0, 10, 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      isExpanded: true,
      hint: Text(
        widget.hintText,
        style: TextStyle(fontSize: 14, color: AppColors.grayNormal),
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black45,
      ),
      iconSize: 30,
      buttonHeight: 40,
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: widget.items
          .map(
            (item) => DropdownMenuItem<T>(
              value: item,
              enabled: false,
              child: StatefulBuilder(
                builder: (context, menuSetState) {
                  final _isSelected = selectedItems.contains(item);
                  return InkWell(
                    onTap: () {
                      _isSelected
                          ? selectedItems.remove(item)
                          : selectedItems.add(item);
                      //This rebuilds the StatefulWidget to update the button's text
                      setState(() {});
                      //This rebuilds the dropdownMenu Widget to update the check mark
                      menuSetState(() {});
                    },
                    child: Container(
                      height: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.getText(item),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          if (_isSelected)
                            SizedBox(
                              height: 15,
                              width: 15,
                              child: const Icon(Icons.check),
                            )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
          .toList(),
      selectedItemBuilder: (context) {
        return widget.items.map(
          (item) {
            return Container(
              child: Text(
                selectedItems.map((e) => widget.getText(e)).join(', '),
                style: const TextStyle(
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            );
          },
        ).toList();
      },
      validator: (value) {
        if (selectedItems.isEmpty) {
          return 'Please select an option.';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (value) {
        widget.onChanged?.call(selectedItems);
      },
      onSaved: (value) {
        widget.onSaved?.call(selectedItems);
      },
    );
  }
}
