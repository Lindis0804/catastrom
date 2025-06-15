import 'package:template/data/models/plan/plan.model.dart';

abstract class Mock {
  List<Plan> plans = [
    Plan(
        id: 1,
        createdBy: 'hieuld',
        tripCode: "HT2024",
        price: 5000000,
        tripIntent: "Đi tắm biển Hà Tĩnh",
        intentDescription: "Tắm biển, thưởng thức hải sản tươi ngon",
        type: "Du lịch",
        numberOfParticipants: 5,
        mainLocations: ["Hà Tĩnh", "Nghệ An"],
        name: 'Du hí Hà Tĩnh',
        address: 'Hà Tĩnh',
        startTime: DateTime(2024, 11, 17),
        endTime: DateTime(2024, 11, 20),
        imageUrl:
            'https://images.baoangiang.com.vn/image/fckeditor/upload/2023/20231102/images/T11.jpg'),
    Plan(
        id: 2,
        tripCode: "HT2024",
        createdBy: 'hieuld',
        price: 5000000,
        tripIntent: "Đi tắm biển Hà Tĩnh",
        intentDescription: "Tắm biển, thưởng thức hải sản tươi ngon",
        type: "Du lịch",
        numberOfParticipants: 5,
        mainLocations: ["Hà Tĩnh", "Nghệ An"],
        name: 'Tắm biển cửa lò',
        address: 'Cửa Lò, Nghệ An',
        startTime: DateTime(2024, 10, 17),
        endTime: DateTime(2024, 10, 21),
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/6/61/Cualovedem.jpg')
  ];
}
