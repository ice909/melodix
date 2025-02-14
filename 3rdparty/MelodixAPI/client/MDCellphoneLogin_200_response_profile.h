/**
 * MelodixAPI
 * Melodix API
 *
 * The version of the OpenAPI document: 1.0.0
 *
 * NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
 * https://openapi-generator.tech
 * Do not edit the class manually.
 */

/*
 * MDCellphoneLogin_200_response_profile.h
 *
 * 
 */

#ifndef MDCellphoneLogin_200_response_profile_H
#define MDCellphoneLogin_200_response_profile_H

#include <QJsonObject>

#include "MDCellphoneLogin_200_response_profile_avatarDetail.h"
#include "MDObject.h"
#include <QString>

#include "MDEnum.h"
#include "MDObject.h"

namespace MelodixAPI {
class MDCellphoneLogin_200_response_profile_avatarDetail;

class MDCellphoneLogin_200_response_profile : public MDObject {
public:
    MDCellphoneLogin_200_response_profile();
    MDCellphoneLogin_200_response_profile(QString json);
    ~MDCellphoneLogin_200_response_profile() override;

    QString asJson() const override;
    QJsonObject asJsonObject() const override;
    void fromJsonObject(QJsonObject json) override;
    void fromJson(QString jsonString) override;

    QString getBackgroundImgIdStr() const;
    void setBackgroundImgIdStr(const QString &background_img_id_str);
    bool is_background_img_id_str_Set() const;
    bool is_background_img_id_str_Valid() const;

    QString getAvatarImgIdStr() const;
    void setAvatarImgIdStr(const QString &avatar_img_id_str);
    bool is_avatar_img_id_str_Set() const;
    bool is_avatar_img_id_str_Valid() const;

    qint32 getUserType() const;
    void setUserType(const qint32 &user_type);
    bool is_user_type_Set() const;
    bool is_user_type_Valid() const;

    qint32 getVipType() const;
    void setVipType(const qint32 &vip_type);
    bool is_vip_type_Set() const;
    bool is_vip_type_Valid() const;

    qint32 getAuthStatus() const;
    void setAuthStatus(const qint32 &auth_status);
    bool is_auth_status_Set() const;
    bool is_auth_status_Valid() const;

    qint32 getDjStatus() const;
    void setDjStatus(const qint32 &dj_status);
    bool is_dj_status_Set() const;
    bool is_dj_status_Valid() const;

    QString getDetailDescription() const;
    void setDetailDescription(const QString &detail_description);
    bool is_detail_description_Set() const;
    bool is_detail_description_Valid() const;

    MDObject getExperts() const;
    void setExperts(const MDObject &experts);
    bool is_experts_Set() const;
    bool is_experts_Valid() const;

    qint32 getAccountStatus() const;
    void setAccountStatus(const qint32 &account_status);
    bool is_account_status_Set() const;
    bool is_account_status_Valid() const;

    QString getNickname() const;
    void setNickname(const QString &nickname);
    bool is_nickname_Set() const;
    bool is_nickname_Valid() const;

    qint32 getBirthday() const;
    void setBirthday(const qint32 &birthday);
    bool is_birthday_Set() const;
    bool is_birthday_Valid() const;

    qint32 getGender() const;
    void setGender(const qint32 &gender);
    bool is_gender_Set() const;
    bool is_gender_Valid() const;

    qint32 getProvince() const;
    void setProvince(const qint32 &province);
    bool is_province_Set() const;
    bool is_province_Valid() const;

    qint32 getCity() const;
    void setCity(const qint32 &city);
    bool is_city_Set() const;
    bool is_city_Valid() const;

    qint32 getAvatarImgId() const;
    void setAvatarImgId(const qint32 &avatar_img_id);
    bool is_avatar_img_id_Set() const;
    bool is_avatar_img_id_Valid() const;

    qint32 getBackgroundImgId() const;
    void setBackgroundImgId(const qint32 &background_img_id);
    bool is_background_img_id_Set() const;
    bool is_background_img_id_Valid() const;

    QString getAvatarUrl() const;
    void setAvatarUrl(const QString &avatar_url);
    bool is_avatar_url_Set() const;
    bool is_avatar_url_Valid() const;

    bool isFollowed() const;
    void setFollowed(const bool &followed);
    bool is_followed_Set() const;
    bool is_followed_Valid() const;

    QString getBackgroundUrl() const;
    void setBackgroundUrl(const QString &background_url);
    bool is_background_url_Set() const;
    bool is_background_url_Valid() const;

    bool isDefaultAvatar() const;
    void setDefaultAvatar(const bool &default_avatar);
    bool is_default_avatar_Set() const;
    bool is_default_avatar_Valid() const;

    bool isMutual() const;
    void setMutual(const bool &mutual);
    bool is_mutual_Set() const;
    bool is_mutual_Valid() const;

    QString getDescription() const;
    void setDescription(const QString &description);
    bool is_description_Set() const;
    bool is_description_Valid() const;

    qint32 getUserId() const;
    void setUserId(const qint32 &user_id);
    bool is_user_id_Set() const;
    bool is_user_id_Valid() const;

    QString getSignature() const;
    void setSignature(const QString &signature);
    bool is_signature_Set() const;
    bool is_signature_Valid() const;

    qint32 getAuthority() const;
    void setAuthority(const qint32 &authority);
    bool is_authority_Set() const;
    bool is_authority_Valid() const;

    qint32 getFolloweds() const;
    void setFolloweds(const qint32 &followeds);
    bool is_followeds_Set() const;
    bool is_followeds_Valid() const;

    qint32 getFollows() const;
    void setFollows(const qint32 &follows);
    bool is_follows_Set() const;
    bool is_follows_Valid() const;

    qint32 getArtistId() const;
    void setArtistId(const qint32 &artist_id);
    bool is_artist_id_Set() const;
    bool is_artist_id_Valid() const;

    qint32 getEventCount() const;
    void setEventCount(const qint32 &event_count);
    bool is_event_count_Set() const;
    bool is_event_count_Valid() const;

    MDCellphoneLogin_200_response_profile_avatarDetail getAvatarDetail() const;
    void setAvatarDetail(const MDCellphoneLogin_200_response_profile_avatarDetail &avatar_detail);
    bool is_avatar_detail_Set() const;
    bool is_avatar_detail_Valid() const;

    qint32 getPlaylistCount() const;
    void setPlaylistCount(const qint32 &playlist_count);
    bool is_playlist_count_Set() const;
    bool is_playlist_count_Valid() const;

    qint32 getPlaylistBeSubscribedCount() const;
    void setPlaylistBeSubscribedCount(const qint32 &playlist_be_subscribed_count);
    bool is_playlist_be_subscribed_count_Set() const;
    bool is_playlist_be_subscribed_count_Valid() const;

    virtual bool isSet() const override;
    virtual bool isValid() const override;

private:
    void initializeModel();

    QString m_background_img_id_str;
    bool m_background_img_id_str_isSet;
    bool m_background_img_id_str_isValid;

    QString m_avatar_img_id_str;
    bool m_avatar_img_id_str_isSet;
    bool m_avatar_img_id_str_isValid;

    qint32 m_user_type;
    bool m_user_type_isSet;
    bool m_user_type_isValid;

    qint32 m_vip_type;
    bool m_vip_type_isSet;
    bool m_vip_type_isValid;

    qint32 m_auth_status;
    bool m_auth_status_isSet;
    bool m_auth_status_isValid;

    qint32 m_dj_status;
    bool m_dj_status_isSet;
    bool m_dj_status_isValid;

    QString m_detail_description;
    bool m_detail_description_isSet;
    bool m_detail_description_isValid;

    MDObject m_experts;
    bool m_experts_isSet;
    bool m_experts_isValid;

    qint32 m_account_status;
    bool m_account_status_isSet;
    bool m_account_status_isValid;

    QString m_nickname;
    bool m_nickname_isSet;
    bool m_nickname_isValid;

    qint32 m_birthday;
    bool m_birthday_isSet;
    bool m_birthday_isValid;

    qint32 m_gender;
    bool m_gender_isSet;
    bool m_gender_isValid;

    qint32 m_province;
    bool m_province_isSet;
    bool m_province_isValid;

    qint32 m_city;
    bool m_city_isSet;
    bool m_city_isValid;

    qint32 m_avatar_img_id;
    bool m_avatar_img_id_isSet;
    bool m_avatar_img_id_isValid;

    qint32 m_background_img_id;
    bool m_background_img_id_isSet;
    bool m_background_img_id_isValid;

    QString m_avatar_url;
    bool m_avatar_url_isSet;
    bool m_avatar_url_isValid;

    bool m_followed;
    bool m_followed_isSet;
    bool m_followed_isValid;

    QString m_background_url;
    bool m_background_url_isSet;
    bool m_background_url_isValid;

    bool m_default_avatar;
    bool m_default_avatar_isSet;
    bool m_default_avatar_isValid;

    bool m_mutual;
    bool m_mutual_isSet;
    bool m_mutual_isValid;

    QString m_description;
    bool m_description_isSet;
    bool m_description_isValid;

    qint32 m_user_id;
    bool m_user_id_isSet;
    bool m_user_id_isValid;

    QString m_signature;
    bool m_signature_isSet;
    bool m_signature_isValid;

    qint32 m_authority;
    bool m_authority_isSet;
    bool m_authority_isValid;

    qint32 m_followeds;
    bool m_followeds_isSet;
    bool m_followeds_isValid;

    qint32 m_follows;
    bool m_follows_isSet;
    bool m_follows_isValid;

    qint32 m_artist_id;
    bool m_artist_id_isSet;
    bool m_artist_id_isValid;

    qint32 m_event_count;
    bool m_event_count_isSet;
    bool m_event_count_isValid;

    MDCellphoneLogin_200_response_profile_avatarDetail m_avatar_detail;
    bool m_avatar_detail_isSet;
    bool m_avatar_detail_isValid;

    qint32 m_playlist_count;
    bool m_playlist_count_isSet;
    bool m_playlist_count_isValid;

    qint32 m_playlist_be_subscribed_count;
    bool m_playlist_be_subscribed_count_isSet;
    bool m_playlist_be_subscribed_count_isValid;
};

} // namespace MelodixAPI

Q_DECLARE_METATYPE(MelodixAPI::MDCellphoneLogin_200_response_profile)

#endif // MDCellphoneLogin_200_response_profile_H
