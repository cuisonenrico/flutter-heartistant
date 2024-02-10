import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/styles/spacers.dart';
import 'package:flutter_heartistant/features/styles/styles.dart';
import 'package:flutter_heartistant/features/widgets/floating_container.dart';
import 'package:flutter_heartistant/utilities/colors.dart';
import 'package:flutter_heartistant/utilities/decorations.dart';
import 'package:flutter_heartistant/utilities/extensions/build_context_ext.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';

const double _iconSize = 12.0;

class TableListView extends StatelessWidget {
  TableListView({
    required this.headers,
    required this.rowData,
    this.onActionPressed,
    this.title,
    this.padding,
    this.actionIcon,
    super.key,
  })  : assert(rowData.every((element) => element.length == headers.length),
            "Label headers must always be equal to the number of data in a row"),
        assert((actionIcon != null && onActionPressed != null) || (actionIcon == null && onActionPressed == null),
            'actionIcon and onActionPressed should be both null or not null');

  final List<String> headers;
  final List<List<String>> rowData;
  final String? title;
  final EdgeInsets? padding;
  final IconData? actionIcon;

  final void Function(int id)? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: defaultHalfSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotNullOrEmpty) ...[
            Text(
              title!,
              style: TextStyles.headline3,
            ),
            const VerticalSpace(defaultHalfSpacing),
          ],
          FloatingContainer(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(defaultHalfRadius)),
              color: Colors.white,
              boxShadow: [defaultShadow],
            ),
            margin: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...headers
                        .map(
                          (header) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(defaultHalfPadding),
                              child: Text(
                                header,
                                textAlign: TextAlign.left,
                                style: TextStyles.label4,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    if (onActionPressed != null) const HorizontalSpace(_iconSize + defaultHalfSpacing),
                  ],
                ),
                const Divider(),
                ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: rowData.length,
                  itemBuilder: (_, index) {
                    final color = index % 2 == 0.0 ? Colors.white : lightGrey;

                    return Container(
                      color: color,
                      width: context.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...rowData[index]
                              .map(
                                (data) => Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(defaultHalfPadding),
                                    child: Text(
                                      data,
                                      textAlign: TextAlign.left,
                                      style: TextStyles.body3.copyWith(fontSize: 10),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          if (onActionPressed != null)
                            Padding(
                              padding: const EdgeInsets.only(right: defaultHalfPadding),
                              child: InkWell(
                                onTap: () => onActionPressed?.call(index),
                                child: Icon(
                                  actionIcon,
                                  size: _iconSize,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const Divider(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
