import 'package:app/models/brand_model.dart';
import 'package:app/theme.dart';
import 'package:app/localization_service.dart';
import 'package:app/network/network_urls.dart';
import 'package:app/components/my_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class BrandWidget extends StatelessWidget {
  final BrandModel brandModel;
  final VoidCallback? onTap;
  final bool showDescription;
  final bool isSelected;

  const BrandWidget({
    super.key,
    required this.brandModel,
    this.onTap,
    this.showDescription = false,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? MyTheme.buttonColor : MyTheme.borderColor,
          borderRadius: BorderRadius.circular(MyTheme.buttonsRadius),
          border: Border.all(
            color: isSelected ? MyTheme.buttonColor : MyTheme.borderColor,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: MyTheme.shadowColor,
              blurRadius: 10,
              spreadRadius: 0.1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Brand Logo and Name Row
            Row(
              children: [
                // Brand Logo
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(MyTheme.buttonsRadius),
                    border: Border.all(
                      color: MyTheme.borderColor,
                      width: 1,
                    ),
                  ),
                  child: brandModel.LogoUrl != null &&
                          brandModel.LogoUrl!.isNotEmpty
                      ? ClipRRect(
                          borderRadius:
                              BorderRadius.circular(MyTheme.buttonsRadius - 1),
                          child: Image.network(
                            "${NetworkURLs.getMediaServer()}${brandModel.LogoUrl}",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: MyTheme.cardColor,
                                child: Icon(
                                  Icons.business,
                                  color: MyTheme.secondaryColor,
                                  size: 40,
                                ),
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                color: MyTheme.cardColor,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                    color: MyTheme.buttonColor,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(
                          color: MyTheme.cardColor,
                          child: Icon(
                            Icons.business,
                            color: MyTheme.secondaryColor,
                            size: 40,
                          ),
                        ),
                ),
                const SizedBox(width: 16),
                // Brand Name and Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: LocalizationService.getCurrentLocale()
                                    .languageCode ==
                                "ar"
                            ? brandModel.NameAr ?? "brandScreen.unknownBrand".tr
                            : brandModel.NameEn ??
                                "brandScreen.unknownBrand".tr,
                        color: isSelected
                            ? MyTheme.offWhiteColor
                            : MyTheme.textColor,
                        fontWeight: FontWeight.bold,
                        size: MyTheme.textSizeLarge,
                      ),
                      const SizedBox(height: 4),
                      if (brandModel.WebSiteUrl != null &&
                          brandModel.WebSiteUrl!.isNotEmpty)
                        InkWell(
                          onTap: () async {
                            await launchUrl(Uri.parse(brandModel.WebSiteUrl!));
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.language,
                                size: 16,
                                color: isSelected
                                    ? MyTheme.offWhiteColor.withOpacity(0.8)
                                    : MyTheme.secondaryColor,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: MyText(
                                  text: brandModel.WebSiteUrl!,
                                  color: isSelected
                                      ? MyTheme.offWhiteColor.withOpacity(0.8)
                                      : MyTheme.secondaryColor,
                                  size: MyTheme.textSizeXXSmall,
                                  textDecoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      // const SizedBox(height: 4),
                      // ,
                    ],
                  ),
                ),
                // Selection Indicator
              ],
            ),

            // Description (if enabled)
            if (showDescription &&
                ((LocalizationService.getCurrentLocale().languageCode == "ar" &&
                        brandModel.DescriptionAr != null &&
                        brandModel.DescriptionAr!.isNotEmpty) ||
                    (LocalizationService.getCurrentLocale().languageCode ==
                            "en" &&
                        brandModel.DescriptionEn != null &&
                        brandModel.DescriptionEn!.isNotEmpty)))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? MyTheme.mainColor.withOpacity(0.1)
                          : MyTheme.borderColor,
                      borderRadius:
                          BorderRadius.circular(MyTheme.buttonsRadius),
                    ),
                    child: MyText(
                      text:
                          LocalizationService.getCurrentLocale().languageCode ==
                                  "ar"
                              ? brandModel.DescriptionAr!
                              : brandModel.DescriptionEn!,
                      color: isSelected
                          ? MyTheme.offWhiteColor
                          : MyTheme.textColor,
                      size: MyTheme.textSizeXSmall,
                    ),
                  ),
                ],
              ),

            // Created/Updated Info
            // if (brandModel.CreatedAt != null || brandModel.UpdatedAt != null)
            //   Padding(
            //     padding: const EdgeInsets.only(top: 12),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         if (brandModel.CreatedAt != null)
            //           Row(
            //             children: [
            //               Icon(
            //                 Icons.calendar_today,
            //                 size: 14,
            //                 color: isSelected
            //                     ? MyTheme.offWhiteColor.withOpacity(0.6)
            //                     : MyTheme.secondaryColor,
            //               ),
            //               const SizedBox(width: 4),
            //               MyText(
            //                 text: "brandScreen.created".tr +
            //                     ": ${_formatDate(brandModel.CreatedAt!)}",
            //                 color: isSelected
            //                     ? MyTheme.offWhiteColor.withOpacity(0.6)
            //                     : MyTheme.secondaryColor,
            //                 size: MyTheme.textSizeXXSmall,
            //               ),
            //             ],
            //           ),
            //         if (brandModel.UpdatedAt != null)
            //           Row(
            //             children: [
            //               Icon(
            //                 Icons.update,
            //                 size: 14,
            //                 color: isSelected
            //                     ? MyTheme.offWhiteColor.withOpacity(0.6)
            //                     : MyTheme.secondaryColor,
            //               ),
            //               const SizedBox(width: 4),
            //               MyText(
            //                 text: "brandScreen.updated".tr +
            //                     ": ${_formatDate(brandModel.UpdatedAt!)}",
            //                 color: isSelected
            //                     ? MyTheme.offWhiteColor.withOpacity(0.6)
            //                     : MyTheme.secondaryColor,
            //                 size: MyTheme.textSizeXXSmall,
            //               ),
            //             ],
            //           ),
            //       ],
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
