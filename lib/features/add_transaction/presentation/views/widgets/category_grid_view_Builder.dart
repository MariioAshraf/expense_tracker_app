import 'package:expense_tracker_app/features/add_transaction/presentation/views/widgets/add_category_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../dashboard/presentation/manager/dash_board_bloc.dart';
import '../../../data/models/category_model.dart';
import '../../manager/add_transaction_bloc.dart';
import 'category_item.dart';

class CategoryGridViewBuilder extends StatefulWidget {
  const CategoryGridViewBuilder({super.key});

  @override
  State<CategoryGridViewBuilder> createState() =>
      _CategoryGridViewBuilderState();
}

class _CategoryGridViewBuilderState extends State<CategoryGridViewBuilder> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final addTransactionBloc = AddTransactionBloc.get(context);
    final dashBoardBloc = DashBoardBloc.get(context);
    final categoryNameController = addTransactionBloc.categoryNameController;
    final defaultCategories = CategoryModel.defaultCategories;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: defaultCategories.length + 1,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 20.w,
          mainAxisSpacing: 5.h,
          crossAxisCount: 3,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (context, index) {
          if (index < defaultCategories.length) {
            final category = defaultCategories[index];
            final isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  categoryNameController.text = category.name;
                  addTransactionBloc.categoryIconController.text =
                      category.icon.codePoint.toString();
                });
              },
              child: CategoryItem(isSelected: isSelected, category: category),
            );
          } else {
            // Add Category Item
            return _buildAddCategoryButton(
                context, dashBoardBloc, addTransactionBloc);
          }
        },
      ),
    );
  }

  GestureDetector _buildAddCategoryButton(BuildContext context,
      DashBoardBloc dashBoardBloc, AddTransactionBloc addTransactionBloc) {
    return GestureDetector(
      onTap: () {
        _showAddCategorySheet(context, dashBoardBloc, addTransactionBloc);
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.teal.withAlpha(130),
            child: Icon(Icons.add, color: Colors.teal, size: 28),
          ),
          SizedBox(height: 6),
          Text(
            "Add Category",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  void _showAddCategorySheet(BuildContext context, DashBoardBloc dashBoardBloc,
      AddTransactionBloc addTransactionBloc) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
          ),
          child: const AddCategoryBottomSheet()),
    ).whenComplete(() {
      addTransactionBloc.categoryNameController.text =
          dashBoardBloc.categoryNameController.text;
      addTransactionBloc.categoryIconController.text =
          dashBoardBloc.categoryCodeController.text;
    });
  }
}
