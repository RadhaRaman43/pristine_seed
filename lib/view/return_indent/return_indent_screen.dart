import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:navigation_drawer_flutter/viewModel/return_indent_vm/return_indent_vm.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../custom_drawer.dart';

class ReturnIndentScreen extends StatelessWidget {
  ReturnIndentScreen({super.key});

  final return_indent_page_controller = Get.put(ReturnIndentViewModel());

  Size size = Get.size;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(RoutesName.homeScreen);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'Return Indent',
                style: GoogleFonts.poppins(
                  color: AllColors.whiteColor,
                  fontSize: AllFontSize.twentee,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              Obx(() {
                // Ensure the list is not empty before accessing the first element
                  return Visibility(
                    visible: return_indent_page_controller.is_done.value==0,
                    child: IconButton(
                      onPressed: () {
                        return_indent_page_controller.location_code_controller.clear();
                        Get.toNamed(RoutesName.newReturnIndentScreen);
                      },
                      icon: Icon(Icons.add),
                    ),
                  );

              })

            ],
          ),
          iconTheme: IconThemeData(
            color: AllColors.whiteColor, // Change this to the desired color
          ),
          backgroundColor: AllColors.primaryDark1,
        ),
        drawer: CustomDrawer(),
        body: Container(
          width: double.infinity,
          height: size.height,
          child: Column(
            children: [
              Obx(
                () {
                  return Container(
                    margin: EdgeInsets.only(top: 0.3),
                    child: Visibility(
                      visible: return_indent_page_controller.loading.value,
                      child: LinearProgressIndicator(
                        backgroundColor: AllColors.textColor,
                        color: AllColors.primaryDark1,
                      ),
                    ),
                  );
                },
              ),

              Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                     controller:return_indent_page_controller.global_search_controller,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: AllColors.primaryDark1), // Customize the border color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.grey), // Customize the border color
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () async {
                               // return_indent_page_controller.is_done.value=0;
                                return_indent_page_controller.pageNumber=0;
                                return_indent_page_controller.ReturnIndentList(return_indent_page_controller.pageNumber,global_search_value:return_indent_page_controller.global_search_controller.text);

                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                return_indent_page_controller.global_search_controller.clear();
                                return_indent_page_controller.pageNumber=0;
                                return_indent_page_controller.ReturnIndentList(return_indent_page_controller.pageNumber);


                                // Add clear functionality here
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(height: size.height*0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(() {
                           return
                            ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.all(2),
                              backgroundColor:return_indent_page_controller.is_done.value==0?AllColors.primaryDark1:AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                  side: BorderSide(color: AllColors.grayColor)),
                              //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                              //CircleAvatar
                              label: Text('Pending',
                                  style: GoogleFonts.poppins(
                                    color:return_indent_page_controller.is_done.value==0?AllColors.whiteColor:AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w500,
                                  )),
                              onPressed: () {
                                return_indent_page_controller.is_done.value=0;
                                return_indent_page_controller.pageNumber=0;
                                return_indent_page_controller.ReturnIndentList(return_indent_page_controller.pageNumber);

                              }, //Text
                            );
                          },),

                        SizedBox(width: 5,),
                       Obx(() {
                           return
                              ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.all(2),
                              backgroundColor:return_indent_page_controller.is_done.value==1?AllColors.primaryDark1:AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                  side: BorderSide(color: AllColors.grayColor)),
                              //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                              //CircleAvatar
                              label: Text('Complete',
                                  style: GoogleFonts.poppins(
                                    color:return_indent_page_controller.is_done.value==1?AllColors.whiteColor:AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w500,
                                  )),
                              onPressed: () {
                                return_indent_page_controller.is_done.value=1;
                                return_indent_page_controller.pageNumber=0;
                                return_indent_page_controller.ReturnIndentList(return_indent_page_controller.pageNumber);

                              }, //Text
                            );
                          },)

                      ],
                    ),
                    // SizedBox(height: size.height*0.01,),

                  ],
                ),
              ),







              Obx(
                () => bindListView(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bindListView(BuildContext context) {
    if (return_indent_page_controller.return_indent_list.isNotEmpty &&
        return_indent_page_controller.return_indent_list != null &&
        return_indent_page_controller.return_indent_list.length > 0) {
      ScrollController scrollController = ScrollController();
        scrollController.addListener(() {

          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            // You have reached the end of the list
            int total_page = (return_indent_page_controller.total_rows /
                return_indent_page_controller.rowsPerPage)
                .toInt();
            if ((return_indent_page_controller.total_rows %
                return_indent_page_controller.rowsPerPage) >
                0) total_page += 1;

            print(
                "last index ${return_indent_page_controller.pageNumber} ${return_indent_page_controller.total_rows} ${return_indent_page_controller.rowsPerPage} ${total_page}");

            if (return_indent_page_controller.pageNumber + 1 != total_page) {
              return_indent_page_controller.ReturnIndentList(
                  return_indent_page_controller.pageNumber+1,);
              this.return_indent_page_controller.pageNumber += 1;
            }
          }
        });
      return Expanded(
        child: ListView.separated(
            itemBuilder: (context, index) {
              return BindReturnList(context, index);
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 0.5,
                color: AllColors.primaryDark1,
              );
            },
            itemCount: return_indent_page_controller.return_indent_list.length),
      );
    } else {
      return Center(
        //child: Image.asset("assests/images/no_record_found.gif",),
        child: Image.asset(
          "assests/images/no_data_remove.png",
          width: 300,
          height: 180,
        ),
      );
    }
  }

  BindReturnList(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        return_indent_page_controller.return_no=return_indent_page_controller.return_indent_list[index].returnNo!;
        return_indent_page_controller.list_location_code=return_indent_page_controller.return_indent_list[index].locationCode!;
        //return_indent_page_controller.ReturnIndentHeaderCreate(return_indent_page_controller.return_indent_list[index].returnNo.toString(),return_indent_page_controller.return_indent_list[index].locationCode.toString(),"ListView");
        return_indent_page_controller.ReturnIndentHeaderCreate("ListView");
      },
      child: ListTile(
        title:Table(
          columnWidths: {
            0:FlexColumnWidth(0.4),
            1:FlexColumnWidth(1),

          },
          children: [
            TableRow(
              children: [
                Text(
                  'Return No.:',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  return_indent_page_controller.return_indent_list[index].returnNo??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w300,
                  ),
                )


              ]
            ),
            TableRow(
                children: [
                  Text(
                    'Location:',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Text(
                    return_indent_page_controller.return_indent_list[index].locationCode??"",
                    style: GoogleFonts.poppins(
                      color: AllColors.textColor,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w300,
                    ),
                  ),

                ]
            ),

          ],
        ),
       subtitle: Column(
         children: [
           Row(
             children: [
               Text(
                 'Status:',
                 style: GoogleFonts.poppins(
                   color: AllColors.primaryDark1,
                   fontSize: AllFontSize.fourtine,
                   fontWeight: FontWeight.w500,
                 ),
               ),
               Spacer(),
               Text(
                 return_indent_page_controller.return_indent_list[index].isDone==0?"Pending":"Completed",
                 style: GoogleFonts.poppins(
                   color: AllColors.redColor,
                   fontSize: AllFontSize.fourtine,
                   fontWeight: FontWeight.w300,
                 ),
               ),
             ],
           ),
           Row(
             children: [
               Spacer(),
               Text( return_indent_page_controller.return_indent_list[index].createdBy??"",
                 style: GoogleFonts.poppins(
                   color: AllColors.textColor,
                   fontSize: AllFontSize.twelve,
                   fontWeight: FontWeight.w300,
                 ),
                 textAlign: TextAlign.end,
               )
             ],
           ),

         ],
       ),


       /* Column(
          children: [
            Row(
              children: [
                Text(
                  'Return No.:',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: size.width*.03,),
                Text(
                  return_indent_page_controller.return_indent_list[index].returnNo??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Location:',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: size.width*.06,),
                Text(
                  return_indent_page_controller.return_indent_list[index].locationCode??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Return No.:',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: size.width*.03,),
                Text(
                  return_indent_page_controller.return_indent_list[index].returnNo??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ],
        ),*/
      ),
    );
  }
}
