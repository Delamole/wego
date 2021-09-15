import Foundation
import AVKit
import Alamofire
import AlamofireImage

struct Excursion {
    var name: String
    var steps: [Step]
    var image: String
}

struct Step {
    var name: String
    var description: String
    var images: [String]
    var audio: String
}

class Loader: NSObject {
    
    static var shared = Loader()
    func loadImage(icon: String, completion: @escaping (UIImage) -> Void){
        AF.request(icon).responseImage { response in
            if case .success(let image) = response.result {
                print("image downloaded: \(image)")
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
}

//заглушки

let excursions: [Excursion] = [Excursion(name: "Сорок сороков купеческого Замоскворечья", steps: [
                                            Step(name: "шаг 1", description: "Есть в первопрестольной район, благодаря которому Москву именуют городом Сорока сороков. И это – Замоскворечье!", images: ["http://moscowwalking.ru/upload/iblock/9c8/1.jpg",
                                            ], audio: "musica"),
                                            Step(name: "шаг 2", description: "Благовест, зарождающийся в Кремлевских соборах, одними из первых подхватывали именно храмы за Москвой-рекой.", images: ["http://moscowwalking.ru/upload/resize_cache/iblock/667/760_560_2/2.jpg",
                                            ], audio: "musica")],
                                         image: "http://moscowwalking.ru/upload/resize_cache/iblock/667/760_560_2/2.jpg"),
                               Excursion(name: "Неизвестная Шаболовка - из прошлого в будущее", steps: [
                                            Step(name: "шаг 1", description: "Во время этой прогулки вы перенесетесь из 20 века в 18 век, и оттуда в 16-ый! Вы узнаете судьбу инженера серебряного века В.Г Шухова и фабрикантов 19 столетия.", images: ["http://moscowwalking.ru/upload/iblock/c0d/noroot_6.jpg",
                                                ], audio: "musica"),
                                            Step(name: "шаг 2", description: "Услышите, как икона Донской божьей матери защитила Москву от крымского хана.", images: ["http://moscowwalking.ru/upload/resize_cache/iblock/667/760_560_2/2.jpg",
                                                ], audio: "musica")],
                                            image: "http://moscowwalking.ru/upload/iblock/c0d/noroot_6.jpg")
]


