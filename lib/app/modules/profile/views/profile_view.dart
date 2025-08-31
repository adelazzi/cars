import 'package:cars/app/modules/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';
import 'package:cars/app/modules/profile/controllers/profile_controller.dart';


class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  final usercontroller = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.backgroundColor(context),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MainColors.backgroundColor(context),
        centerTitle: true,
        title: Text(
          'My Profile',
          style: TextStyles.titleMedium(context)
              .copyWith(color: MainColors.primaryColor),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.settings, color: MainColors.primaryColor),
              onPressed: () {}
              //=> Get.toNamed('/settings'),
              ),
          IconButton(
            icon: Icon(Icons.refresh, color: MainColors.primaryColor),
            onPressed: () {
              usercontroller.setUser();
            },
          ),
        ],
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildProfileHeader(context),
                  const SizedBox(height: 20),
                  _buildQuickActions(context),
                  const SizedBox(height: 20),
                  _buildMyCars(context),
                  const SizedBox(height: 20),
                  _buildRecentActivity(context),
                  const SizedBox(height: 20),
                  _buildAccountOptions(context),
                ],
              ),
            )),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 45,
                backgroundColor: MainColors.primaryColor.withOpacity(0.2),
                backgroundImage: NetworkImage(
                    usercontroller.currentUser.value.imageProfileUrl!
                    // ?? StringsAssets.defaultAvatar
                    ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: MainColors.primaryColor,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.camera_alt,
                        size: 15, color: Colors.white),
                    onPressed: () => controller.updateProfilePicture(),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${usercontroller.currentUser.value.name ?? 'User'} ${usercontroller.currentUser.value.familyName ?? ''}',
                  style: TextStyles.titleMedium(context),
                ),
                const SizedBox(height: 5),
                Text(
                  usercontroller.currentUser.value.phoneNumber ??
                      'Add phone number',
                  style: TextStyles.bodySmall(context),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 16, color: MainColors.primaryColor),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        usercontroller.currentUser.value.address ??
                            'Add address',
                        style: TextStyles.bodySmall(context),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: MainColors.primaryColor),
            onPressed: () => controller.navigateToEditProfile(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionItem(context, Icons.directions_car, 'My Cars',
              () => controller.navigateToCars()),
          _buildActionItem(context, Icons.build, 'Maintenance',
              () => controller.navigateToMaintenance()),
          _buildActionItem(context, Icons.favorite, 'Favorites',
              () => controller.navigateToFavorites()),
          _buildActionItem(context, Icons.history, 'History',
              () => controller.navigateToHistory()),
        ],
      ),
    );
  }

  Widget _buildActionItem(
      BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: MainColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: MainColors.primaryColor),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyles.labelSmall(context)),
        ],
      ),
    );
  }

  Widget _buildMyCars(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('My Cars', style: TextStyles.titleSmall(context)),
                TextButton(
                  onPressed: () => controller.navigateToCars(),
                  child: Text('See all',
                      style: TextStyles.labelSmall(context)
                          .copyWith(color: MainColors.primaryColor)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemCount: controller.cars.length + 1,
              itemBuilder: (context, index) {
                if (index == controller.cars.length) {
                  return _buildAddCarCard(context);
                }
                return _buildCarCard(context, index);
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildCarCard(BuildContext context, int index) {
    final car = controller.cars[index];
    return Container(
      width: 180,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: MainColors.primaryColor.withOpacity(0.05),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                car.imageUrl, //?? StringsAssets.defaultCarImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Text(
                '${car.make} ${car.model}',
                style:
                    TextStyles.bodySmall(context).copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCarCard(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.navigateToAddCar(),
      child: Container(
        width: 180,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MainColors.primaryColor.withOpacity(0.05),
          border: Border.all(
              color: MainColors.primaryColor,
              width: 1,
              style: BorderStyle.solid),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_circle_outline,
                color: MainColors.primaryColor, size: 32),
            const SizedBox(height: 8),
            Text(
              'Add New Car',
              style: TextStyles.bodySmall(context)
                  .copyWith(color: MainColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Activity', style: TextStyles.titleSmall(context)),
          const SizedBox(height: 12),
          _buildActivityItem(
              context, 'Oil Change', 'Toyota Camry', '2 days ago'),
          const Divider(),
          _buildActivityItem(
              context, 'Tire Rotation', 'Honda Civic', '1 week ago'),
          const Divider(),
          _buildActivityItem(
              context, 'Car Inspection', 'Toyota Camry', '3 weeks ago'),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
      BuildContext context, String title, String subtitle, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: MainColors.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.build,
                color: MainColors.primaryColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyles.bodyMedium(context)),
                Text(subtitle, style: TextStyles.bodySmall(context)),
              ],
            ),
          ),
          Text(time,
              style:
                  TextStyles.bodyLarge(context).copyWith(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildAccountOptions(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildOptionItem(
            context,
            Icons.payment,
            'Payment Methods',
            () => controller.navigateToPaymentMethods(),
          ),
          const Divider(height: 1),
          _buildOptionItem(
            context,
            Icons.support_agent,
            'Support',
            () => controller.navigateToSupport(),
          ),
          const Divider(height: 1),
          _buildOptionItem(
            context,
            Icons.info_outline,
            'About App',
            () => controller.navigateToAbout(),
          ),
          const Divider(height: 1),
          _buildOptionItem(
            context,
            Icons.logout,
            'Logout',
            () => controller.logout(),
            textColor: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildOptionItem(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap, {
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? MainColors.primaryColor),
      title: Text(
        label,
        style: TextStyles.bodyMedium(context).copyWith(color: textColor),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
