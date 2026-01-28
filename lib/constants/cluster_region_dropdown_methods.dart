import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../CRM_Directory/CRM_Models/AccountMaster_model/cluster_modal.dart';
import 'app_colors.dart';
import 'app_font_size.dart';

class ClusterRegionMethod {
  static Widget bindClusterNameFilter(
      BuildContext context, {
        required List<ClusterModal> items,
        required TextEditingController controller,
        required RxList<ClusterModal> selectedList,
        required VoidCallback onDone,
      }) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.text.isNotEmpty) {
        final names = controller.text.split(',');
        selectedList.clear();
        selectedList.assignAll(
          names.map((e) => ClusterModal(geoValue: e.trim())).toList(),
        );
      } else {
        if (items.isNotEmpty && selectedList.isEmpty) {
          selectedList.assignAll(items);
          controller.text = items.map((e) => e.geoValue).join(', ');
          onDone();
        }
      }
    });

    return Obx(() {
      final selected = selectedList;
      final selectedText =
      selected.isEmpty ? null : selected.map((e) => e.geoValue).join(', ');

      return GestureDetector(
        onTap: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) {
              final searchController = TextEditingController();
              final tempSelected = <ClusterModal>[];
              tempSelected.addAll(selectedList);

              final allItems = items;

              return StatefulBuilder(builder: (context, setState) {
                final query = searchController.text.toLowerCase();
                final filtered = query.isEmpty
                    ? allItems
                    : allItems
                    .where((c) =>
                    (c.geoValue ?? "")
                        .toLowerCase()
                        .contains(query))
                    .toList();


                final allSelected = allItems.isNotEmpty &&
                    allItems.every((item) =>
                        tempSelected.any((sel) => sel.geoValue == item.geoValue));
                /*final allSelected =
                    allItems.isNotEmpty &&
                        tempSelected.length == allItems.length;*/

                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Container(
                          width: 50,
                          height: 4,
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(2)),
                        ),
                        const SizedBox(height: 12),

                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Select Clusters',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AllColors.primaryDark1),
                                ),
                              ),
                              IconButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(),
                                icon: Icon(Icons.close,
                                    color: AllColors.primaryDark1,
                                    weight: 700),
                              )
                            ],
                          ),
                        ),


                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(8)),
                              isDense: true,
                              suffixIcon:
                              searchController.text.isNotEmpty
                                  ? IconButton(
                                icon:
                                const Icon(Icons.clear),
                                onPressed: () {
                                  searchController.clear();
                                  setState(() {});
                                },
                              )
                                  : null,
                            ),
                            onChanged: (v) => setState(() {}),
                          ),
                        ),

                        const SizedBox(height: 8),


                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CheckboxListTile(
                            title: const Text('Select All'),
                            value: allSelected,
                            onChanged: (val) {
                              setState(() {
                                if (val == true) {
                                  tempSelected
                                    ..clear()
                                    ..addAll(allItems);
                                } else {
                                  tempSelected.clear();
                                }
                              });
                            },
                          ),
                        ),

                        const Divider(height: 1),


                        Expanded(
                          child: filtered.isEmpty
                              ? const Center(
                              child: Text('No clusters found'))
                              : ListView.builder(
                            padding:
                            const EdgeInsets.symmetric(
                                vertical: 8),
                            itemCount: filtered.length,
                            itemBuilder: (context, idx) {
                              final item = filtered[idx];
                              final isSel =
                              tempSelected.contains(item);

                              return CheckboxListTile(
                                title:
                                Text(item.geoValue ?? ""),
                                value: isSel,
                                onChanged: (v) {
                                  setState(() {
                                    if (v == true) {
                                      if (!isSel)
                                        tempSelected.add(item);
                                    } else {
                                      tempSelected.remove(item);
                                    }
                                  });
                                },
                              );
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    AllColors.green,
                                    shadowColor:
                                    AllColors.green,
                                    foregroundColor:
                                    AllColors.primaryDark1,
                                    side: BorderSide(
                                        color: AllColors.primaryDark1,
                                        width: 1),
                                    shape:
                                    RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    selectedList.assignAll(
                                        tempSelected);
                                    controller.text = tempSelected
                                        .map((e) => e.geoValue)
                                        .join(', ');
                                    onDone();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Done',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          );
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: "Cluster Name",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 14),
          ),
          child: Row(
            children: [
              Expanded(
                child: selectedText == null
                    ? Text(
                  "Select Cluster",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: AllFontSize.sisxteen,
                  ),
                )
                    : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    selectedText,
                    style: const TextStyle(
                        color: Colors.black),
                  ),
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      );
    });
  }
}
