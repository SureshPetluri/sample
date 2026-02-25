import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ServiceCategory {
  final String id;
  final String title;
  final String imageUrl;
  final int count;
  final List<ServiceItem> items;

  ServiceCategory({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.count,
    required this.items,
  });
}

class ServiceItem {
  final String id;
  final String title;

  ServiceItem({required this.id, required this.title});
}

final serviceCategoriesProvider = Provider<List<ServiceCategory>>((ref) {
  return [
    ServiceCategory(
      id: '1',
      title: 'Ranching',
      imageUrl: 'assets/images/ranching.png',
      count: 6,
      items: [
        ServiceItem(id: '11', title: 'Animal Husbandry'),
        ServiceItem(id: '12', title: 'Animal Nutrition'),
        ServiceItem(id: '13', title: 'Sheep & Goat Farming'),
        ServiceItem(id: '14', title: 'Pasture Management'),
        ServiceItem(id: '15', title: 'Farm Equipment'),
        ServiceItem(id: '16', title: 'Rural Entrepreneurship'),
        ServiceItem(id: '16', title: 'Rural Entrepreneurship'),
        ServiceItem(id: '16', title: 'Rural Entrepreneurship'),
        ServiceItem(id: '16', title: 'Rural Entrepreneurship'),
        ServiceItem(id: '16', title: 'Rural Entrepreneurship'),
      ],
    ),
    ServiceCategory(
      id: '2',
      title: 'Astronomy',
      imageUrl: 'assets/images/astronomy.png',
      count: 4,
      items: [
        ServiceItem(id: '21', title: 'Telescopes'),
        ServiceItem(id: '22', title: 'Stargazing'),
        ServiceItem(id: '23', title: 'Astrophotography'),
        ServiceItem(id: '24', title: 'Space Exploration'),
      ],
    ),
    ServiceCategory(
      id: '3',
      title: 'Travel',
      imageUrl: 'assets/images/travel.png',
      count: 25,
      items: [
        ServiceItem(id: '31', title: 'Backpacking'),
        ServiceItem(id: '32', title: 'Luxury Travel'),
        ServiceItem(id: '33', title: 'Solo Travel'),
        ServiceItem(id: '34', title: 'Adventure Travel'),
      ],
    ),
    ServiceCategory(
      id: '4',
      title: 'Fitness and\nWellness',
      imageUrl: 'assets/images/fitness.png',
      count: 6,
      items: [
        ServiceItem(id: '41', title: 'Yoga'),
        ServiceItem(id: '42', title: 'Weightlifting'),
        ServiceItem(id: '43', title: 'Cardio'),
        ServiceItem(id: '44', title: 'Nutrition'),
      ],
    ),
    ServiceCategory(
      id: '5',
      title: 'Chess',
      imageUrl: 'assets/images/chess.png',
      count: 3,
      items: [
        ServiceItem(id: '51', title: 'Openings'),
        ServiceItem(id: '52', title: 'Endgames'),
        ServiceItem(id: '53', title: 'Tactics'),
      ],
    ),
    ServiceCategory(
      id: '5',
      title: 'Chess',
      imageUrl: 'assets/images/chess.png',
      count: 3,
      items: [
        ServiceItem(id: '51', title: 'Openings'),
        ServiceItem(id: '52', title: 'Endgames'),
        ServiceItem(id: '53', title: 'Tactics'),
      ],
    ),
    ServiceCategory(
      id: '5',
      title: 'Chess',
      imageUrl: 'assets/images/chess.png',
      count: 3,
      items: [
        ServiceItem(id: '51', title: 'Openings'),
        ServiceItem(id: '52', title: 'Endgames'),
        ServiceItem(id: '53', title: 'Tactics'),
      ],
    ),
    ServiceCategory(
      id: '5',
      title: 'Chess',
      imageUrl: 'assets/images/chess.png',
      count: 3,
      items: [
        ServiceItem(id: '51', title: 'Openings'),
        ServiceItem(id: '52', title: 'Endgames'),
        ServiceItem(id: '53', title: 'Tactics'),
      ],
    ),
    ServiceCategory(
      id: '5',
      title: 'Chess',
      imageUrl: 'assets/images/chess.png',
      count: 3,
      items: [
        ServiceItem(id: '51', title: 'Openings'),
        ServiceItem(id: '52', title: 'Endgames'),
        ServiceItem(id: '53', title: 'Tactics'),
      ],
    ),
    ServiceCategory(
      id: '5',
      title: 'Chess',
      imageUrl: 'assets/images/chess.png',
      count: 3,
      items: [
        ServiceItem(id: '51', title: 'Openings'),
        ServiceItem(id: '52', title: 'Endgames'),
        ServiceItem(id: '53', title: 'Tactics'),
      ],
    ),
    ServiceCategory(
      id: '5',
      title: 'Chess',
      imageUrl: 'assets/images/chess.png',
      count: 3,
      items: [
        ServiceItem(id: '51', title: 'Openings'),
        ServiceItem(id: '52', title: 'Endgames'),
        ServiceItem(id: '53', title: 'Tactics'),
      ],
    ),
    ServiceCategory(
      id: '5',
      title: 'Chess',
      imageUrl: 'assets/images/chess.png',
      count: 3,
      items: [
        ServiceItem(id: '51', title: 'Openings'),
        ServiceItem(id: '52', title: 'Endgames'),
        ServiceItem(id: '53', title: 'Tactics'),
      ],
    ),
    ServiceCategory(
      id: '5',
      title: 'Chess',
      imageUrl: 'assets/images/chess.png',
      count: 3,
      items: [
        ServiceItem(id: '51', title: 'Openings'),
        ServiceItem(id: '52', title: 'Endgames'),
        ServiceItem(id: '53', title: 'Tactics'),
      ],
    ),
    ServiceCategory(
      id: '5',
      title: 'Chess',
      imageUrl: 'assets/images/chess.png',
      count: 3,
      items: [
        ServiceItem(id: '51', title: 'Openings'),
        ServiceItem(id: '52', title: 'Endgames'),
        ServiceItem(id: '53', title: 'Tactics'),
      ],
    ),
    ServiceCategory(
      id: '5',
      title: 'Chess',
      imageUrl: 'assets/images/chess.png',
      count: 3,
      items: [
        ServiceItem(id: '51', title: 'Openings'),
        ServiceItem(id: '52', title: 'Endgames'),
        ServiceItem(id: '53', title: 'Tactics'),
      ],
    ),
    ServiceCategory(
      id: '5',
      title: 'Chess',
      imageUrl: 'assets/images/chess.png',
      count: 3,
      items: [
        ServiceItem(id: '51', title: 'Openings'),
        ServiceItem(id: '52', title: 'Endgames'),
        ServiceItem(id: '53', title: 'Tactics'),
      ],
    ),
    ServiceCategory(
      id: '5',
      title: 'Chess',
      imageUrl: 'assets/images/chess.png',
      count: 3,
      items: [
        ServiceItem(id: '51', title: 'Openings'),
        ServiceItem(id: '52', title: 'Endgames'),
        ServiceItem(id: '53', title: 'Tactics'),
      ],
    ),
    ServiceCategory(
      id: '5',
      title: 'Chess',
      imageUrl: 'assets/images/chess.png',
      count: 3,
      items: [
        ServiceItem(id: '51', title: 'Openings'),
        ServiceItem(id: '52', title: 'Endgames'),
        ServiceItem(id: '53', title: 'Tactics'),
      ],
    ),
    ServiceCategory(
      id: '5',
      title: 'Chess',
      imageUrl: 'assets/images/chess.png',
      count: 3,
      items: [
        ServiceItem(id: '51', title: 'Openings'),
        ServiceItem(id: '52', title: 'Endgames'),
        ServiceItem(id: '53', title: 'Tactics'),
      ],
    ),
    ServiceCategory(
      id: '5',
      title: 'Chess',
      imageUrl: 'assets/images/chess.png',
      count: 3,
      items: [
        ServiceItem(id: '51', title: 'Openings'),
        ServiceItem(id: '52', title: 'Endgames'),
        ServiceItem(id: '53', title: 'Tactics'),
      ],
    ),

  ];
});

final selectedCategoryIndexProvider = StateProvider<int>((ref) => 0);
