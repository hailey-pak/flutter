import 'package:flutter/material.dart';


class MarkerCategory {
  final String id;
  final String label;
  final Icon icon;
  bool visible = true;
  List<MarkerCategory>? subCategories;

  MarkerCategory({
    required this.id,
    required this.label,
    required this.icon,
  });
}

class MarkerCategoryWidget extends StatefulWidget {

  final List<MarkerCategory> list;

  const MarkerCategoryWidget({super.key, required this.list,});


  @override
  State<MarkerCategoryWidget> createState() => _MarkerCategoryWidgetState();
}

class _MarkerCategoryWidgetState extends State<MarkerCategoryWidget> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    widget.list.map((MarkerCategory item) {
      if (item.subCategories != null) {
        return ExpansionPanelList.radio(
          children: widget.list.map<ExpansionPanelRadio>((MarkerCategory item) {
            return ExpansionPanelRadio(
                value: item.id,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(item.label),
                  );
                },
                body: SingleChildScrollView(
                  child: Container(
                    child: _buildPanel(),
                  ),
                ));
          }).toList(),
        );
      }
      return ListTile(

      );

    });




    return ExpansionPanelList.radio(
      children: widget.list.map<ExpansionPanelRadio>((MarkerCategory item) {
        return ExpansionPanelRadio(
            value: item.id,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(item.label),
              );
            },
            body: SingleChildScrollView(
              child: Container(
                child: _buildPanel(),
              ),
            ));
      }).toList(),
    );
  }


}
