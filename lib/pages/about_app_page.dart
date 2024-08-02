import 'package:flutter/material.dart';
import '../utils/colors.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About App'),
        backgroundColor: AppColors.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildHeaderSection(),
            const SizedBox(height: 20),
            _buildDescriptionSection(),
            const SizedBox(height: 20),
            _buildFeaturesSection(),
            const SizedBox(height: 20),
            _buildDeveloperInfoSection(),
            const SizedBox(height: 20),
            _buildVersionInfoSection(),
            const SizedBox(height: 20),
            _buildContactInfoSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DrinkIt',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.mainColor,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Your one-stop app for all your favorite beverages!',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.listColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About DrinkIt',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.styleColor,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'DrinkIt is an innovative application that allows you to discover and order a wide range of beverages right from your phone. Whether you are looking for refreshing juices, delicious smoothies, or premium cocktails, DrinkIt has something for everyone!',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.mainListColor,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Features',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.styleColor,
          ),
        ),
        SizedBox(height: 8),
        _FeatureList(),
      ],
    );
  }

  Widget _buildDeveloperInfoSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Developers',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.styleColor,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'DrinkIt was created by Njagah, an enthusiastic developer passionate about bringing innovative solutions to the beverage industry. With a focus on quality and user experience, we strive to deliver the best app for our users.',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.mainListColor,
          ),
        ),
      ],
    );
  }

  Widget _buildVersionInfoSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Version',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.styleColor,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'DrinkIt v1.0.0',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.smallColor,
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfoSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Us',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.styleColor,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'If you have any questions or feedback, please feel free to contact us at support@drinkit.com. We would love to hear from you!',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.mainListColor,
          ),
        ),
      ],
    );
  }
}

class _FeatureList extends StatelessWidget {
  const _FeatureList();

  @override
  Widget build(BuildContext context) {
    final features = [
      'Wide selection of drinks',
      'Easy and secure ordering',
      'Exclusive promotions and discounts',
      'User-friendly interface',
      'Fast delivery options',
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: features.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.check, color: AppColors.mainColor),
          title: Text(
            features[index],
            style: const TextStyle(color: AppColors.smallColor),
          ),
        );
      },
    );
  }
}
