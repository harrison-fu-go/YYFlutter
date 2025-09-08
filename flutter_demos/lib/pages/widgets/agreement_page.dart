/* File: agreement_page.dart
 * Created by GYGES.Harrison on 2025/1/27
 * Copyright © 2024 GYGES Limited.
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../languages/languages.dart';

class AgreementPage extends StatelessWidget {
  const AgreementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('agreement_title') ?? '用户协议'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, 'agreement_last_updated'),
            const SizedBox(height: 16),
            
            _buildSectionTitle(context, 'agreement_introduction'),
            _buildSectionContent(context, 'agreement_intro_content'),
            const SizedBox(height: 16),
            
            _buildSectionTitle(context, 'agreement_acceptance'),
            _buildSectionContent(context, 'agreement_acceptance_content'),
            const SizedBox(height: 16),
            
            _buildSectionTitle(context, 'agreement_usage'),
            _buildSectionContent(context, 'agreement_usage_content'),
            const SizedBox(height: 16),
            
            _buildSectionTitle(context, 'agreement_privacy'),
            _buildSectionContent(context, 'agreement_privacy_content'),
            const SizedBox(height: 16),
            
            _buildSectionTitle(context, 'agreement_liability'),
            _buildSectionContent(context, 'agreement_liability_content'),
            const SizedBox(height: 16),
            
            _buildSectionTitle(context, 'agreement_changes'),
            _buildSectionContent(context, 'agreement_changes_content'),
            const SizedBox(height: 16),
            
            _buildSectionTitle(context, 'agreement_contact'),
            _buildSectionContent(context, 'agreement_contact_content'),
            const SizedBox(height: 32),
            
            _buildAcceptButton(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String key) {
    return Text(
      AppLocalizations.of(context).translate(key) ?? key,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildSectionContent(BuildContext context, String key) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        AppLocalizations.of(context).translate(key) ?? key,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _buildAcceptButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // 标记用户已同意协议
          _markAgreementAccepted();
          Get.back();
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
        ),
        child: Text(
          AppLocalizations.of(context).translate('agreement_accept') ?? '我同意',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _markAgreementAccepted() {
    // 这里可以保存用户同意状态到本地存储
    // 例如使用 SharedPreferences 或 GetStorage
    print('用户已同意协议');
  }
}