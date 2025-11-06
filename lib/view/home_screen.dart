import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:user_hub/controller/home_controller.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "All Users",
            style: TextStyle(fontSize: 20.sp,color: Colors.purple),
          ),
          centerTitle: true,
          scrolledUnderElevation: 0,
          backgroundColor: const Color(0xffF3E8FF),
        ),
        body: Padding(
          padding: EdgeInsets.all(17.w),
          child: RefreshIndicator(
            onRefresh: () async => await controller.fetchUserData(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //search field
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search by username...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                  ),
                  onChanged: (value) {
                    controller.filterUsers(userName: value);
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),

                //list of users

                Obx(
                  () {
                    if (controller.isLoading.value) {
                      return Expanded(child: _buildShimmerEffect());
                    }
                    final whatToShow = controller.searchResult.value.isNotEmpty
                        ? controller.searchData
                        : controller.getUserData;

                    return Expanded(
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final userDetail = whatToShow[index];
                            return Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: const Color(0xffF3E8FF),
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border(
                                    left: BorderSide(
                                        color: Colors.pink, width: 2),
                                    bottom: BorderSide(
                                        color: Colors.pink, width: 2)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customRow(
                                      title: "Name",
                                      subtitle: "${userDetail.name}"),
                                  customRow(
                                      title: "UserName",
                                      subtitle: "${userDetail.username}"),
                                  customRow(
                                      title: "Email",
                                      subtitle: "${userDetail.email}"),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: 16.h,
                              ),
                          itemCount: whatToShow.length),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          height: 100.h,
          margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
      ),
    );
  }


  Widget customRow({required String title, required String subtitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14.sp, color: Colors.black),
        ),
        Text(
          subtitle,
          style: TextStyle(fontSize: 14.sp, color: Colors.purple),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    );
  }
}
