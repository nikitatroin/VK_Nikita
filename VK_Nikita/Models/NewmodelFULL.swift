
import Foundation

// MARK: - NewsModel
struct NewsModel: Codable {
    let response: NewsResponse
}

// MARK: - Response
struct NewsResponse: Codable {
    let items: [NewsItem]
    let groups: [Group]
    let profiles: [Profile]
    let nextFrom: String

    enum CodingKeys: String, CodingKey {
        case items, groups, profiles
        case nextFrom = "next_from"
    }
}

// MARK: - Group
struct Group: Codable {
    let id: Int
    let photo100, photo50, photo200: String
    let type, screenName, name: String
    let isClosed: Int

    enum CodingKeys: String, CodingKey {
        case id
        case photo100 = "photo_100"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
    }
}

// MARK: - Item
struct NewsItem: Codable {
    let comments: NewsComments
    let canSetCategory: Bool
    let likes: NewsLikes
    let reposts: NewsReposts
    let type, postType: String
    let date, sourceID: Int
    let text: String
    let canDoubtCategory: Bool
    let attachments: [Attachment]
    let markedAsAds, postID: Int
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
        case postSource = "post_source"
        case views
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let type: String
    let link: Link
}

// MARK: - Link
struct Link: Codable {
    let title, caption: String
    let url: String
    let linkDescription: String
    let photo: NewsPhoto

    enum CodingKeys: String, CodingKey {
        case title, caption, url
        case linkDescription = "description"
        case photo
    }
}

// MARK: - Photo
struct NewsPhoto: Codable {
    let albumID, id, date: Int
    let text: String
    let userID: Int
    let sizes: [NewsSize]
    let hasTags: Bool
    let ownerID: Int

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case id, date, text
        case userID = "user_id"
        case sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
    }
}

// MARK: - Size
struct NewsSize: Codable {
    let width, height: Int
    let url: String
    let type: String
}

// MARK: - Comments
struct NewsComments: Codable {
    let count, canPost: Int
    let groupsCanPost: Bool

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
        case groupsCanPost = "groups_can_post"
    }
}

// MARK: - Likes
struct NewsLikes: Codable {
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
struct NewsReposts: Codable {
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

    enum CodingKeys: String, CodingKey {
        case visible
        case isMobile = "is_mobile"
        case isOnline = "is_online"
    }
}
