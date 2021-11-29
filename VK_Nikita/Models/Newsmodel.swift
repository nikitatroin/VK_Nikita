//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)
//
//import Foundation
//
//// MARK: - Response
//struct Response: Codable {
//    let items: [ResponseItem]?
//}
//
//// MARK: - ResponseItem
//struct ResponseItem: Codable {
//    let date: Int?
//    let text: String?
//    let attachments: [ItemAttachment]?
//    let photos: Photos?
//
//
//    enum CodingKeys: String, CodingKey {
//        case date
//        case text
//        case attachments
//        case photos
//    }
//}
//// MARK: - Sizes
//struct Sizes: Codable {
//    let url: String?
//}
//
//// MARK: - ItemAttachment
//struct ItemAttachment: Codable {
//    let type: AttachmentType?
//    let photo: Photo?
//    let video: Video?
//}
//
//// MARK: - Photo
//struct Photo: Codable {
//    let text: String?
//    let sizes: [Sizes]
//
//
//    enum CodingKeys: String, CodingKey {
//        case text
//        case sizes
//    }
//}
//
//enum AttachmentType: String, Codable {
//    case link = "link"
//    case photo = "photo"
//    case video = "video"
//}
//
//// MARK: - Video
//struct Video: Codable {
//    let firstFrame1280: String?
//    let title: String?
//
//
//    enum CodingKeys: String, CodingKey {
//        case firstFrame1280 = "first_frame_1280"
//        case title
//    }
//}
//
//
//// MARK: - Photos
//struct Photos: Codable {
//    let count: Int
//    let items: [PhotosItem]
//}
//
//// MARK: - PhotosItem
//struct PhotosItem: Codable {
//    let text: String
//    let sizes: [Sizes]
//
//    enum CodingKeys: String, CodingKey {
//        case text
//        case sizes
//    }
//}
