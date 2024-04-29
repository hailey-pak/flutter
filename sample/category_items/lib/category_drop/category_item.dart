import 'package:flutter/material.dart';

class CategoryItem {
  final String id;
  final String label;
  final IconData icon;
  Color? iconColor;
  bool visible = true;
  List<CategoryItem> subCategories = [];

  CategoryItem({
    required this.id,
    required this.label,
    required this.icon,
    Color? iconColor,
    List<CategoryItem>? subCategories,
  }) {
    iconColor != null ? this.iconColor = iconColor : null;
    subCategories != null ? this.subCategories = subCategories : [];
  }
}


List<CategoryItem> categoryItems = [
  CategoryItem(
    id: 'PC0100',
    icon: Icons.circle,
    iconColor: Colors.red,
    label: '도로 및 광장',
    subCategories: [
      CategoryItem(id: 'PC0101', icon: Icons.directions_walk, label: '산책로/보행로'),
      CategoryItem(id: 'PC0102', icon: Icons.account_balance, label: '광장'),
      CategoryItem(id: 'PC0103', icon: Icons.branding_watermark, label: '교량'),
      CategoryItem(id: 'PC0104', icon: Icons.stacked_line_chart, label: '계단'),
      CategoryItem(id: 'PC0105', icon: Icons.emoji_transportation_sharp, label: '기타도로시설'),
    ],
  ),
  CategoryItem(
    id: 'PC0200',
    icon: Icons.circle,
    iconColor: Colors.orange,
    label: '조경시설',
    subCategories: [
      CategoryItem(id: 'PC0201', icon: Icons.shopping_cart, label: '조각/조형물'),
      CategoryItem(id: 'PC0202', icon: Icons.account_tree, label: '문주/열주'),
      CategoryItem(id: 'PC0203', icon: Icons.water_rounded, label: '식수대/플랜터'),
      CategoryItem(id: 'PC0204', icon: Icons.watch, label: '솟대'),
      CategoryItem(id: 'PC0205', icon: Icons.wallet_giftcard, label: '수경시설 (바닥분수)'),
      CategoryItem(id: 'PC0206', icon: Icons.wallet_membership_rounded, label: '수경시설 (분수/분수대)'),
      CategoryItem(id: 'PC0207', icon: Icons.qr_code, label: '수경시설 (바닥/음악분수)'),
      CategoryItem(id: 'PC0208', icon: Icons.warehouse_rounded, label: '수경시설 (벽천/인공폭포)'),
      CategoryItem(id: 'PC0209', icon: Icons.query_builder_outlined, label: '수경시설 (계류)'),
      CategoryItem(id: 'PC0210', icon: Icons.radio, label: '수경시설 (연못)'),
      CategoryItem(id: 'PC0211', icon: Icons.e_mobiledata, label: '기타수경시설'),
      CategoryItem(id: 'PC0212', icon: Icons.radar, label: '기타조경시설'),
    ],
  ),
  CategoryItem(
    id: 'PC0300',
    icon: Icons.circle,
    iconColor: Colors.yellow,
    label: '휴양시설',
    subCategories: [
      CategoryItem(id: 'PC0301', icon: Icons.chair, label: '의자'),
      CategoryItem(id: 'PC0302', icon: Icons.chair_alt, label: '정자'),
      CategoryItem(id: 'PC0303', icon: Icons.table_bar, label: '파고라'),
      CategoryItem(id: 'PC0304', icon: Icons.deck, label: '데크'),
      CategoryItem(id: 'PC0305', icon: Icons.wallet, label: '앉음벽'),
      CategoryItem(id: 'PC0306', icon: Icons.table_restaurant_outlined, label: '야외탁자 (테이블)'),
      CategoryItem(id: 'PC0307', icon: Icons.wash_outlined, label: '야유회장/피크닉장'),
      CategoryItem(id: 'PC0308', icon: Icons.earbuds, label: '휴양시설바닥'),
      CategoryItem(id: 'PC0308', icon: Icons.eco_sharp, label: '경로당/노인쉼터'),
      CategoryItem(id: 'PC0309', icon: Icons.account_balance, label: '기타휴양시설'),
    ],
  ),
  CategoryItem(
    id: 'PC0400',
    icon: Icons.circle,
    iconColor: Colors.green,
    label: '유희시설',
    subCategories: [
      CategoryItem(id: 'PC0401', label: '어린이놀이시설', icon: Icons.child_care),
      CategoryItem(id: 'PC0402', label: '물놀이시설', icon: Icons.water_drop),
      CategoryItem(id: 'PC0403', label: '놀이공간바닥', icon: Icons.play_for_work),
      CategoryItem(id: 'PC0404', label: '기타유희시설', icon: Icons.account_box_rounded),
    ],
  ),
  CategoryItem(
    id: 'PC0500',
    icon: Icons.circle,
    iconColor: Colors.blue,
    label: '운동시설',
    subCategories: [
      CategoryItem(id: 'PC0501', label: '운동기구', icon: Icons.sports),
      CategoryItem(id: 'PC0502', label: '운동코트', icon: Icons.sports_basketball),
      CategoryItem(id: 'PC0503', label: '운동시설바닥', icon: Icons.sports_baseball),
      CategoryItem(id: 'PC0504', label: '기타운동시설', icon: Icons.sports_gymnastics),
    ],
  ),
  CategoryItem(
    id: 'PC0600',
    icon: Icons.circle,
    iconColor: Colors.indigoAccent,
    label: '교양시설',
    subCategories: [
      CategoryItem(id: 'PC0601', label: '공연장/무대시설', icon: Icons.theater_comedy),
      CategoryItem(id: 'PC0602', label: '기타교양시설', icon: Icons.theaters),
    ],
  ),
  CategoryItem(
    id: 'PC0700',
    icon: Icons.circle,
    iconColor: Colors.purple,
    label: '편익시설',
    subCategories: [
      CategoryItem(id: 'PC0701', label: '화장실', icon: Icons.man),
      CategoryItem(id: 'PC0702', label: '주차장', icon: Icons.local_parking),
      CategoryItem(id: 'PC0703', label: '음수대/급수전', icon: Icons.water_drop_outlined),
      CategoryItem(id: 'PC0704', label: '자전거보관대', icon: Icons.bike_scooter),
      CategoryItem(id: 'PC0705', label: '기타편익시설', icon: Icons.toc),
    ],
  ),
  CategoryItem(
    id: 'PC0800',
    icon: Icons.circle,
    iconColor: Colors.pink,
    label: '도시농업시설',
    subCategories: [
      CategoryItem(id: 'PC0801', label: '도시텃밭', icon: Icons.density_small),
      CategoryItem(id: 'PC0802', label: '온실/온상/퇴비장', icon: Icons.dashboard_customize),
      CategoryItem(id: 'PC0803', label: '관수 및 급수시설', icon: Icons.waterfall_chart),
      CategoryItem(id: 'PC0804', label: '세면장', icon: Icons.clean_hands_rounded),
      CategoryItem(id: 'PC0805', label: '농기구세척장', icon: Icons.baby_changing_station),
      CategoryItem(id: 'PC0806', label: '기타도시농업시설', icon: Icons.back_hand),
    ],
  ),
  CategoryItem(
    id: 'PC0900',
    icon: Icons.circle,
    iconColor: Colors.brown,
    label: '공원관리시설',
    subCategories: [
      CategoryItem(id: 'PC0901', label: '펜스/울타리', icon: Icons.fence),
      CategoryItem(id: 'PC0902', label: '안내,표지판', icon: Icons.signpost),
      CategoryItem(id: 'PC0903', label: '기타안내표지판', icon: Icons.sign_language),
      CategoryItem(id: 'PC0904', label: '볼라드/출입방지시설', icon: Icons.blinds),
      CategoryItem(id: 'PC0905', label: 'CCTV', icon: Icons.tv),
      CategoryItem(id: 'PC0906', label: '휴지통', icon: Icons.delete_forever),
      CategoryItem(id: 'PC0907', label: '관리시설', icon: Icons.manage_accounts),
    ],
  ),
];