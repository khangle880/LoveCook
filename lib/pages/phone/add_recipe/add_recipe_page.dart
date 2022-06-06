import 'package:flutter/widgets.dart';
import 'package:lovecook/blocs/blocs.dart';
import 'package:lovecook/core/base/base.dart';

class AddRecipePage extends StatefulWidget {
  final AddRecipeBloc bloc;
  const AddRecipePage(this.bloc);

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends BaseState<AddRecipePage, AddRecipeBloc> {
  @override
  AddRecipeBloc get bloc => widget.bloc;
}
