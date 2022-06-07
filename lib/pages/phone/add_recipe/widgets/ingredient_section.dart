
import 'package:flutter/material.dart';

import '../../../../blocs/blocs.dart';
import '../../../../data/data.dart';
import '../../../../extensions/extensions.dart';
import '../../../../gen/assets.gen.dart';
import 'widgets.dart';

class IngredientSection extends StatelessWidget {
  const IngredientSection(
      {Key? key,
      required this.ingredients,
      required this.lookup,
      required this.bloc})
      : super(key: key);
  final List<IngredientModel> ingredients;
  final LookupModel lookup;
  final AddRecipeBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...ingredients
            .map((e) => Column(
                  children: [
                    Row(
                      children: [
                        (e.name! + " (${e.type!.names!.join(' - ')})").s12w400(
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        Spacer(),
                        (e.quantity!.round().toString() + " " + e.unit!.name!)
                            .s12w400(
                                style: TextStyle(fontWeight: FontWeight.w500)),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return AddIngredientWidget(
                                  lookup: lookup,
                                  onSaved: (IngredientModel ingredient) {
                                    bloc.updateField(
                                        ingredients: ingredients
                                          ..replaceRange(
                                            ingredients.indexOf(e),
                                            ingredients.indexOf(e) + 1,
                                            [ingredient],
                                          ));
                                  },
                                  ingredient: e,
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Assets.images.svg.icEditProject
                                .svg(width: 25, height: 25, color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                    Divider(color: Colors.black)
                  ],
                ))
            .toList(),
        TextButton(
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return AddIngredientWidget(
                  lookup: lookup,
                  onSaved: (IngredientModel ingredient) {
                    bloc.updateField(ingredients: ingredients..add(ingredient));
                  },
                );
              },
            );
          },
          child: const Text('Add ingredient'),
        ),
      ],
    );
  }
}

class AddIngredientWidget extends StatefulWidget {
  const AddIngredientWidget({
    Key? key,
    this.ingredient,
    required this.lookup,
    required this.onSaved,
  }) : super(key: key);

  final IngredientModel? ingredient;
  final LookupModel lookup;
  final Function(IngredientModel ingredient) onSaved;

  @override
  State<AddIngredientWidget> createState() => _AddIngredientWidgetState();
}

class _AddIngredientWidgetState extends State<AddIngredientWidget> {
  late IngredientModel newIngredient;

  @override
  void initState() {
    newIngredient = widget.ingredient ?? IngredientModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '${widget.ingredient != null ? "Update" : "Add"} Ingredient',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  child: InputTextWidget(
                    initValue: widget.ingredient?.name,
                    hintText: 'Name',
                    onChanged: (value) {
                      newIngredient = newIngredient.copyWith(name: value);
                    },
                  ),
                ),
                Container(
                  width: 150,
                  child: PickLookup<IngredientTypeModel>(
                    value: widget.ingredient?.type,
                    items: widget.lookup.ingredientTypes!,
                    getText: (item) => item.names!.join(' - '),
                    hintText: "Type",
                    onChanged: (value) {
                      newIngredient = newIngredient.copyWith(type: value);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  child: InputTextWidget(
                    initValue: widget.ingredient?.quantity == null
                        ? null
                        : widget.ingredient!.quantity.toString(),
                    hintText: 'Quantity',
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      newIngredient = newIngredient.copyWith(
                          quantity: double.tryParse(value));
                    },
                  ),
                ),
                Container(
                  width: 150,
                  child: PickLookup<UnitModel>(
                    value: widget.ingredient?.unit,
                    items: widget.lookup.units!,
                    getText: (item) => item.name!,
                    hintText: "Unit",
                    onChanged: (value) {
                      newIngredient = newIngredient.copyWith(unit: value);
                    },
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                widget.onSaved(newIngredient);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
