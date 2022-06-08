import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../blocs/blocs.dart';
import '../../../../data/data.dart';
import '../../../../extensions/extensions.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../resources/colors.dart';
import '../../../../utils/app_config.dart';
import '../../../../widgets/widgets.dart';

class CookStepSection extends StatelessWidget {
  const CookStepSection(
      {Key? key, required this.steps, required this.lookup, required this.bloc})
      : super(key: key);
  final List<CookStepModel> steps;
  final LookupModel lookup;
  final AddRecipeBloc bloc;

  @override
  Widget build(BuildContext context) {
    Widget errorWidget = Container(
      color: AppColors.grayLight,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Assets.images.png.defaultRecipe.image(),
      ),
    );
    return Column(
      children: [
        ...steps
            .map((e) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ((steps.indexOf(e) + 1).toString() + ".").s12w400(),
                    SizedBox(width: 3),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          e.content!.s12w400(
                            config: TextStyleExtConfig(maxLines: 10),
                          ),
                          SizedBox(height: 5),
                          if ((e.photoUrls ?? []).isNotEmpty)
                            SizedBox(
                              width: double.infinity,
                              height: 100,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  ...(e.photoUrls ?? []).map((e) =>
                                      CachedNetworkImage(
                                        imageUrl:
                                            AppConfig.instance.formatLink(e),
                                        placeholder: (context, url) => Center(
                                          child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            errorWidget,
                                        fit: BoxFit.cover,
                                      )),
                                ],
                              ),
                            ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return AddCookStepWidget(
                              lookup: lookup,
                              onSaved: (step) {
                                bloc.updateField(
                                    steps: steps
                                      ..replaceRange(
                                        steps.indexOf(e),
                                        steps.indexOf(e) + 1,
                                        [step],
                                      ));
                              },
                              step: e,
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Assets.images.svg.icEditProject
                            .svg(width: 25, height: 25, color: Colors.blue),
                      ),
                    ),
                  ],
                ))
            .toList(),
        TextButton(
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return AddCookStepWidget(
                  lookup: lookup,
                  onSaved: (CookStepModel step) {
                    bloc.updateField(steps: steps..add(step));
                  },
                );
              },
            );
          },
          child: const Text('Add cook step'),
        ),
      ],
    );
  }
}

class AddCookStepWidget extends StatefulWidget {
  const AddCookStepWidget({
    Key? key,
    this.step,
    required this.lookup,
    required this.onSaved,
  }) : super(key: key);

  final CookStepModel? step;
  final LookupModel lookup;
  final Function(CookStepModel step) onSaved;

  @override
  State<AddCookStepWidget> createState() => _AddCookStepWidgetState();
}

class _AddCookStepWidgetState extends State<AddCookStepWidget> {
  late CookStepModel newStep;

  @override
  void initState() {
    newStep = widget.step ?? CookStepModel();
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
              '${widget.step != null ? "Update" : "Add"} Cook Step',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            InputTextWidget(
              initValue: widget.step?.content,
              hintText: 'Content',
              maxLine: 4,
              onChanged: (value) {
                newStep = newStep.copyWith(content: value);
              },
            ),
            // TODO: add photos
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                widget.onSaved(newStep);
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