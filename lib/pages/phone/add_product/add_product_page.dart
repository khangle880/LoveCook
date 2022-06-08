import 'package:flutter/material.dart';

import '../../../blocs/blocs.dart';
import '../../../core/base/base.dart';
import '../../../data/data.dart';
import '../../../widgets/app_dialog/app_dialog.dart';
import '../../../widgets/widgets.dart';

class AddProductPage extends StatefulWidget {
  final AddProductBloc bloc;
  const AddProductPage(this.bloc);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends BaseState<AddProductPage, AddProductBloc> {
  final _formKey = GlobalKey<FormState>();

  @override
  AddProductBloc get bloc => widget.bloc;

  @override
  void onReceivePayload(Object? payload) {
    super.onReceivePayload(payload);
    if (payload is ProductModel?) {
      if (payload == null) {
        bloc.init();
      } else
        bloc.loadProduct(payload);
    }
  }

  @override
  bool get isCustomLayout => true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.white,
        body: StreamBuilder<AddProductState>(
          stream: bloc.stateStream,
          builder: (context, snp) {
            if (!snp.hasData || snp.data?.lookup == null)
              return Center(
                child: CircularProgressIndicator(),
              );
            final lookup = snp.data!.lookup!;
            final state = snp.data!;
            return Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        Text(
                          "Overview",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 10),
                        //? Name
                        InputTextWidget(
                          initValue: state.name,
                          hintText: 'Product name',
                          onChanged: (value) {
                            bloc.updateField(name: value);
                          },
                        ),
                        SizedBox(height: 10),
                        //? Description
                        InputTextWidget(
                          initValue: state.description,
                          hintText: 'Description',
                          maxLine: 4,
                          onChanged: (value) {
                            bloc.updateField(description: value);
                          },
                        ),
                        SizedBox(height: 10),
                        //? Submit
                        TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              var value = await bloc.saveProduct();
                              await Future.delayed(
                                  Duration(milliseconds: 1000));
                              Navigator.pop(context, value);
                            } else {
                              showDialog(
                                context: context,
                                builder: (_) => AppInformationDialog(
                                    content:
                                        "You need fullfill form before save!"),
                              );
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
