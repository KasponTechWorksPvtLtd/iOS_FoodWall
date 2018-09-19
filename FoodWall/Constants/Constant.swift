//
//  Constant.swift
//  Office Manager
//
//  Created by Ramesh P on 24/04/17.
//  Copyright © 2017 Ramesh P. All rights reserved.
//

import Foundation
import UIKit


struct Constant {
    static let isLoggedIn = "isLoggedIn"
    static let isDownloaded = "isDownloaded"
    static let BASEURL = "http://52.35.246.28/food_wall/index.php/mobile/webservice?methodname="
    
    static let LOGIN_URL = "get_validate_user"
    static let CREATE_USER_LOGIN = "create_user"
    static let CREATE_EVENT = "create_events"
    static let GET_TIMELINE_ALL = "get_timeline_all"
    static let GET_EVENTS_ALL = "get_events_type_all"
    static let CREATE_LIKE = "create_events_likes"
    static let CREATE_GOING = "create_events_going"
    static let GET_EVENT_USER_LIKED =  "get_event_likes_user"
    static let GET_EVENT_COMMENT_ALL = "get_events_comments_all"
    static let CREATE_EVENT_COMMENTS = "create_edit_events_comments"
    static let CREATE_EDIT_COMMENTS = "create_edit_timeline_comments"
    static let GET_TIMELINE_COMMENTS_ALL = "get_timeline_comments_all"
    static let CREATE_QUESTION = "create_question"
    static let GET_IMAGES = "get_timeline_image_user"
    static let CREATE_DELETE_EVENT_COMMENTS = "create_delete_events_comments"
    static let CREATE_TIMELINE = "create_timeline"
    static let CREATE_TIMELINE_LIKES = "create_timeline_likes"
    static let GET_TIMELINE_LIKES_ALL = "get_timeline_likes_all"
    static let GET_PROFILE = "get_profile"
    static let DELETE_POST = "create_delete_timeline"
    static let CREATE_FOLLOWER = "create_follower"
    static let GET_FOLLOWER = "get_friend_follower"
    static let GET_FOLLOWERS = "get_follower"
    static let GET_FOLLOWINGS = "get_friend_following"
    static let UPDATE_PASSWORD = "update_change_password"
    static let UPDATE_FORGOT_PASSWORD = "update_forgot_password"
    static let UPDATE_VERIFYCODE = "update_verifycode"
    static let UPDATE_NEW_PASSWORD = "update_new_password"
    static let GET_TIMELINE_SINGLE = "get_timeline_single"
    static let UPDATE_USER_PROFILE = "update_user_profile"
    static let UPDATE_USER_PROFILE_IMAGE = "update_user_profile_image"
    //static let GET_TIMELINE_LIKES_ALL = "get_timeline_likes_all"
    static let CREATE_TIMELINE_IMAGE = "create_timeline_image"
    static let GET_QUESTION_ANSWER_ALL = "get_question_answer_all"
    static let CREATE_ANSWER = "create_answer"
    static let GET_ANSWER_ALL = "get_answer_all"
    static let CREATE_DELETE_QUESTION = "create_delete_question"
    static let CREATE_ANSWER_VOTES = "create_answer_votes"
    static let CREATE_DELETE_ANSWER = "create_delete_answer"
    static let CREATE_DELETE_QUESTION_FOLLOWER = "create_delete_question_follower"
    static let CREATE_QUESTION_REQUEST = "create_question_request"
    static let GET_ANSWER_COMMENT_ALL = "get_answer_comment_all"
    static let UNDO_POLL = "create_delete_answer_poll_undo"
     static let CREATE_EVENTS_COHOSTS = "create_events_cohosts"
    static let CREATE_EVENTS_SHARE = "create_events_share"
    static let GET_EVENTS_USER = "get_events_user"
    static let CREATE_DELETE_EVENTS = "create_delete_events"
    static let CREATE_POST = "create_edit_delete_events_discussion"
    static let GET_COHOSTS = "get_events_cohosts"
    static let GET_DISCUSSION_ALL = "get_events_discussion_all"
    static let CREATE_DISCUSSION_LIKES = "create_events_discussion_likes"
    static let GET_STORIES_ALL = "get_stories_all"
    static let CREATE_STORY = "create_stories"
    static let GET_EVENT_SINGLE = "get_events_single"
    static let CREATE_DELETE_STORIES = "create_delete_stories"
    static let GET_HISTORICAL_DATA = "get_historical"
    static let GET_REVIEW_ALL = "get_hotel_review_category_type"
    static let GET_AMBIANCE_IMAGES = "get_hotel_review_ambiance_image_all"
    static let GET_DISHES_IMAGES = "get_hotel_dish_type_all"
    static let CREATE_HOTEL_REVIEW_LIKES = "create_hotel_review_likes"
    static let GET_MY_BUCKET_LIST = "get_bucket_myself"
    static let GET_INDIVIDUAL_BUCKET_LIST = "get_bucket_individual_user"
    static let GET_GROUP_BUCKET_LIST = "get_bucket_group"
    static let CREATE_REVIEW = "create_hotel_review"
    static let CREATE_HOTEL_DISH_IMAGE = "create_hotel_review_dish_image"
    static let DELETE_HOTEL_REVIEW = "update_delete_hotel_review"
    static let GET_GROUP_USER = "get_group_user"
    static let CREATE_BUCKET_INDIVIDUAL = "create_bucket_individual_user"
    static let CREATE_BUCKET_MYSELF = "create_bucket_myself"
    static let CREATE_BUCKET_GROUP = "create_bucket_group"
    
    
    static let  CREATE_COMMENT_REPLY = "create_edit_timeline_comments_reply"
    static let CREATE_DELETE_COMMENT = "create_delete_timeline_comments"
    static let CREATE_DELETE_COMMENT_REPLY = "create_delete_timeline_comments_reply"
    static let CREATE_DELETE_HOTEL_REPLY = "create_delete_hotel_review_comments_reply"
    static let CREATE_LIKE_COMMENT_REPLY = "create_timeline_comments_likes"
    static let GET_REVIEW_LIKES_ALL = "get_hotel_review_likes_all"
    static let GET_REVIEW_COMMENTS_ALL = "get_hotel_review_comments_all"
    static let CREATE_EDIT_HOTEL_COMMENTS = "create_edit_hotel_review_comments"
    static let CREATE_EDIT_HOTEL_COMMENTS_REPLY = "create_edit_hotel_review_comments_reply"
    static let CREATE_DELETE_HOTEL_COMMENT = "create_delete_hotel_review_comments"
    static let GET_DISCUSSION_COMMENTS_ALL = "get_events_discussion_comments_all"
    static let CREATE_DISCUSSION_COMMENT = "create_edit_delete_events_discussion_comments"
    static let CREATE_EDIT_DELETE_DISCUSSION_REPLY = "create_edit_delete_events_discussion_comments_reply"
    static let CREATE_EDIT_ANSWER_REPLY = "create_edit_answer_comments_reply"
    static let get_QA_LIKES_ALL = "get_answer_comment_likes_all"
    
    
    
    
    
    static let GET_CHAT_FRIENDS_GROUP = "get_chat_friend_group"
    static let GET_GROUP_FRIENDS_USER = "get_group_friends_user"
    static let CREATE_GROUP = "create_group"
    static let CREATE_GROUP_FRIENDS    = "create_group_friends"
    static let EDIT_GROUP = "update_chat_group"
    static let GETGROUPUSER = "get_group_user"
    static let GETGROUPFRIENDS = "get_group_friends"
    static let UPDATEGETEXITUSER = "update_exit_chat_group_user"
    static let GETBUCKETINDIVIDUAL = "get_bucket_individual_user"
    static let GETBUCKETGROUP = "get_bucket_group_all"
    static let GET_CHAT_HISTORY = "get_chat_history"
    static let GET_SINGLE_CHAT_HISTORY = "get_chat_history_single"
    static let UPDATE_TYPING_STATUS = "update_chat_typing_status"
    static let GET_CHAT_TYPING_STATUS = "get_chat_typing_status"
    static let CREATE_GROUP_CHAT = "create_group_chat"
    static let CREATE_INDIVIDUAL_CHAT = "create_individual_chat"
    
    static let GET_COMMON_SEARCH = "get_common_search"
    static let GET_COMMON_SEARCH_RESULT = "get_common_search_result"
     static let CREATE_FOLLOWER_REQUEST = "create_follower_request"
     static let GET_FOLLOWER_REQUEST = "get_follower_request"
     static let GET_FOLLOWE_COUNT = "get_follower_request_count"
    // static let GET_FOLLOWE_COUNT = "get_follower_request_count"
     static let GET_NOTIFICATION_COUNT = "get_notifications_count"
      static let GET_ALL_NOTIFICATION = "get_notifications_all"
    
    
    //FOR LOGIN
    static let GET_AFTERLOGIN_USER = "get_afterlogin_user"
    
    
    
    
    
    
    static let SELECTED_USER_ID = "seluserid"
    static let POST_IMAGE = "postimage"
    static let USER_ID = "userID"
    static let EMAIL_ID = "emailid"
    static let FIRST_NAME = "firstname"
    static let LAST_NAME = "lastname"
    static let PICTURE = "picture"
    static let GENDER = "gender"
    static let DOB = "dateofbirth"
    static let IMAGE_VALUE = "imgval"
    static let UDID = "udid"
    static let LATITUDE = "latitude"
    static let LONGITUDE = "longitude"
    static let COUNTRY = "country"
    static let CURRENTLOCATION = "currentLocation"
    static let GCM_KEY = "gcmkey"
    static let TOKENID = "tokenid"
    static let TRAINING_DATA_MODEL = "TrainingContent"
    static let PROFILE_URL = "profurl"
    static let EVENT_ID = "eventid"
    static let PAGECUR = "pagecur"
    static let TIMELINE_ID = "timelineID"
    static let FOLLOWERID = "followerID"
    static let FOLLOW_ID = "followid"
    static let CREATED_BY_USERID = "createdby"
    static let EMAIL_FOR_PWD = "emailpwd"
    static let COMMENTS_USER_ID = "commentsuserid"
    static let QA_CREATEDBY = "qauserid"
    static let QUESTION_ID = "qaid"
    static let MONTH = "month"
    //static let SEARCH_LOCATION = "searchLocation"
    static let STORY_IMAGE = "storyImage"
    static let CAPTION = "caption"
    static let NEWVALUE = "newval"
}

extension UIColor {
    
    convenience init(hex: String) {
        
        let scanner = Scanner(string: hex)
        
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        
        let g = (rgbValue & 0xff00) >> 8
        
        let b = rgbValue & 0xff
        
        self.init(
            
            red: CGFloat(r) / 0xff,
            
            green: CGFloat(g) / 0xff,
            
            blue: CGFloat(b) / 0xff, alpha: 1
            
        )
        
    }
    
}



