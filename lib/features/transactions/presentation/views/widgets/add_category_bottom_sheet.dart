import 'package:expense_tracker_app/core/theming/app_colors.dart';
import 'package:expense_tracker_app/core/theming/app_styles.dart';
import 'package:expense_tracker_app/core/utils/extensions.dart';
import 'package:expense_tracker_app/core/widgets/app_text_button.dart';
import 'package:expense_tracker_app/core/widgets/app_text_form_field.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/manager/dash_board_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCategoryBottomSheet extends StatefulWidget {
  const AddCategoryBottomSheet({super.key});

  @override
  State<AddCategoryBottomSheet> createState() => _AddCategoryBottomSheetState();
}

class _AddCategoryBottomSheetState extends State<AddCategoryBottomSheet> {
  late TextEditingController categoryNameController;
  late TextEditingController categoryCodeController;
  IconData? selectedIcon;

  @override
  void initState() {
    categoryNameController =
        context.read<DashBoardBloc>().categoryNameController;
    categoryCodeController =
        context.read<DashBoardBloc>().categoryCodeController;
    super.initState();
  }

  final List<IconData> icons = [
    Icons.fastfood,
    Icons.directions_car,
    Icons.home,
    Icons.shopping_bag,
    Icons.sports_soccer,
    Icons.local_movies,
    Icons.medical_services,
    Icons.work,
    Icons.school,
    Icons.card_giftcard,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Add New Category",
            style: AppTextStyles.font16DarkBlueMedium,
          ),
          const SizedBox(height: 16),
          AppTextFormField(
            controller: categoryNameController,
            hintText: 'Category Name',
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: icons.length,
            itemBuilder: (context, index) {
              final icon = icons[index];
              final isSelected = selectedIcon == icon;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIcon = icon;
                    categoryCodeController.text = icon.codePoint.toString();
                  });
                },
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor:
                      isSelected ? Colors.teal : AppColorsManager.basicGrey,
                  child: Icon(
                    icon,
                    color:
                        isSelected ? Colors.white : Colors.teal.withAlpha(100),
                    size: 28,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          AppTextButton(
              child: Text(
                "Save Category",
                style: AppTextStyles.font14WhiteRegular,
              ),
              onPressed: () {
                if (categoryNameController.text.isNotEmpty &&
                    selectedIcon != null) {
                  context.pop();
                } else {
                  _showOverlayHint(context, "pick category and name");
                }
              }),
        ],
      ),
    );
  }

  void _showOverlayHint(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.4,
        left: MediaQuery.of(context).size.width * 0.2,
        right: MediaQuery.of(context).size.width * 0.2,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);
    Future.delayed(const Duration(seconds: 2), () => entry.remove());
  }
}
