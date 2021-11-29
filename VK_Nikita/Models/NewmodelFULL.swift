// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let news = try? newJSONDecoder().decode(News.self, from: jsonData)

import Foundation

// MARK: - News
struct News: Codable {
    let response: Response?
}

// MARK: - Response
struct Response: Codable {
    let items: [Item]?
    let groups: [Group]?
    let profiles: [Profile]?
    let nextFrom: String?

    enum CodingKeys: String, CodingKey {
        case items, groups, profiles
        case nextFrom = "next_from"
    }
}

// MARK: - Group
struct Group: Codable {
    let isMember, id: Int
    let photo100: String
    let isAdvertiser, isAdmin: Int
    let photo50, photo200: String
    let type, screenName, name: String
    let isClosed: Int

    enum CodingKeys: String, CodingKey {
        case isMember = "is_member"
        case id
        case photo100 = "photo_100"
        case isAdvertiser = "is_advertiser"
        case isAdmin = "is_admin"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
    }
}

// MARK: - Item
struct Item: Codable {
    let comments: Comments
    let canSetCategory: Bool
    let likes: Likes
    let reposts: Reposts
    let type, postType: String
    let date, sourceID: Int
    let text: String
    let canDoubtCategory: Bool
    let attachments: [Attachment]
    let markedAsAds, postID, signerID: Int
    let postSource: PostSource
    let views: Views

    enum CodingKeys: String, CodingKey {
        case comments
        case canSetCategory = "can_set_category"
        case likes, reposts, type
        case postType = "post_type"
        case date
        case sourceID = "source_id"
        case text
        case canDoubtCategory = "can_doubt_category"
        case attachments
        case markedAsAds = "marked_as_ads"
        case postID = "post_id"
        case signerID = "signer_id"
        case postSource = "post_source"
        case views
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let type: TypeEnum
    let photo: Photo?
    let audio: Audio?
}

// MARK: - Audio
struct Audio: Codable {
    let artist: String
    let id: Int
    let shortVideosAllowed: Bool
    let title: String
    let date, duration: Int
    let isHq, storiesAllowed, storiesCoverAllowed: Bool
    let ownerID: Int
    let url: String

    enum CodingKeys: String, CodingKey {
        case artist, id
        case shortVideosAllowed = "short_videos_allowed"
        case title, date, duration
        case isHq = "is_hq"
        case storiesAllowed = "stories_allowed"
        case storiesCoverAllowed = "stories_cover_allowed"
        case ownerID = "owner_id"
        case url
    }
}

// MARK: - Photo
struct Photo: Codable {
    let albumID, id, date: Int
    let text: String
    let userID: Int
    let sizes: [Sizes]
    let hasTags: Bool
    let ownerID: Int
    let accessKey: String

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case id, date, text
        case userID = "user_id"
        case sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
        case accessKey = "access_key"
    }
}

// MARK: - Size
struct Sizes: Codable {
    let width, height: Int
    let url: String
    let type: String
}

enum TypeEnum: String, Codable {
    case audio = "audio"
    case photo = "photo"
}

// MARK: - Comments
struct Comments: Codable {
    let count, canPost: Int
    let groupsCanPost: Bool

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
        case groupsCanPost = "groups_can_post"
    }
}

// MARK: - Likes
struct Likes: Codable {
    let canLike, canPublish, count, userLikes: Int

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case canPublish = "can_publish"
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - PostSource
struct PostSource: Codable {
    let type: String
}

// MARK: - Reposts
struct Reposts: Codable {
    let count, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Views
struct Views: Codable {
    let count: Int
}

// MARK: - Profile
struct Profile: Codable {
    let online, id: Int
    let photo100: String
    let lastName: String
    let photo50: String
    let onlineInfo: OnlineInfo
    let sex: Int
    let screenName, firstName: String

    enum CodingKeys: String, CodingKey {
        case online, id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case onlineInfo = "online_info"
        case sex
        case screenName = "screen_name"
        case firstName = "first_name"
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let visible, isMobile, isOnline: Bool
    let lastSeen: Int?

    enum CodingKeys: String, CodingKey {
        case visible
        case isMobile = "is_mobile"
        case isOnline = "is_online"
        case lastSeen = "last_seen"
    }
}
