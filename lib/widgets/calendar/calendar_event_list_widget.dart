import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home/constants/proxy.dart';
import 'package:home/widgets/proxy/divider/proxy_divider_widget.dart';
import 'package:home/widgets/proxy/text/proxy_text_widget.dart';

class CalendarEventListWidget extends StatelessWidget {
  final List<String> eventList;

  const CalendarEventListWidget({
    Key? key,
    required this.eventList,
  }) : super(key: key);

  Widget _separatorBuilder(BuildContext context, int index) {
    return const ProxyDividerHorizontalWidget();
  }

  Widget _listItemBuilder(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ProxyTextWidget(
        text: eventList[index],
        fontSize: ProxyFontSize.extraSmall,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: eventList.length,
      itemBuilder: _listItemBuilder,
      separatorBuilder: _separatorBuilder,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
