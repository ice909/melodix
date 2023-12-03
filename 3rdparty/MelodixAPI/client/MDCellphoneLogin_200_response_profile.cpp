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

#include "MDCellphoneLogin_200_response_profile.h"

#include <QDebug>
#include <QJsonArray>
#include <QJsonDocument>
#include <QObject>

#include "MDHelpers.h"

namespace MelodixAPI {

MDCellphoneLogin_200_response_profile::MDCellphoneLogin_200_response_profile(QString json) {
    this->initializeModel();
    this->fromJson(json);
}

MDCellphoneLogin_200_response_profile::MDCellphoneLogin_200_response_profile() {
    this->initializeModel();
}

MDCellphoneLogin_200_response_profile::~MDCellphoneLogin_200_response_profile() {}

void MDCellphoneLogin_200_response_profile::initializeModel() {

    m_background_img_id_str_isSet = false;
    m_background_img_id_str_isValid = false;

    m_avatar_img_id_str_isSet = false;
    m_avatar_img_id_str_isValid = false;

    m_user_type_isSet = false;
    m_user_type_isValid = false;

    m_vip_type_isSet = false;
    m_vip_type_isValid = false;

    m_auth_status_isSet = false;
    m_auth_status_isValid = false;

    m_dj_status_isSet = false;
    m_dj_status_isValid = false;

    m_detail_description_isSet = false;
    m_detail_description_isValid = false;

    m_experts_isSet = false;
    m_experts_isValid = false;

    m_account_status_isSet = false;
    m_account_status_isValid = false;

    m_nickname_isSet = false;
    m_nickname_isValid = false;

    m_birthday_isSet = false;
    m_birthday_isValid = false;

    m_gender_isSet = false;
    m_gender_isValid = false;

    m_province_isSet = false;
    m_province_isValid = false;

    m_city_isSet = false;
    m_city_isValid = false;

    m_avatar_img_id_isSet = false;
    m_avatar_img_id_isValid = false;

    m_background_img_id_isSet = false;
    m_background_img_id_isValid = false;

    m_avatar_url_isSet = false;
    m_avatar_url_isValid = false;

    m_followed_isSet = false;
    m_followed_isValid = false;

    m_background_url_isSet = false;
    m_background_url_isValid = false;

    m_default_avatar_isSet = false;
    m_default_avatar_isValid = false;

    m_mutual_isSet = false;
    m_mutual_isValid = false;

    m_description_isSet = false;
    m_description_isValid = false;

    m_user_id_isSet = false;
    m_user_id_isValid = false;

    m_signature_isSet = false;
    m_signature_isValid = false;

    m_authority_isSet = false;
    m_authority_isValid = false;

    m_followeds_isSet = false;
    m_followeds_isValid = false;

    m_follows_isSet = false;
    m_follows_isValid = false;

    m_artist_id_isSet = false;
    m_artist_id_isValid = false;

    m_event_count_isSet = false;
    m_event_count_isValid = false;

    m_avatar_detail_isSet = false;
    m_avatar_detail_isValid = false;

    m_playlist_count_isSet = false;
    m_playlist_count_isValid = false;

    m_playlist_be_subscribed_count_isSet = false;
    m_playlist_be_subscribed_count_isValid = false;
}

void MDCellphoneLogin_200_response_profile::fromJson(QString jsonString) {
    QByteArray array(jsonString.toStdString().c_str());
    QJsonDocument doc = QJsonDocument::fromJson(array);
    QJsonObject jsonObject = doc.object();
    this->fromJsonObject(jsonObject);
}

void MDCellphoneLogin_200_response_profile::fromJsonObject(QJsonObject json) {

    m_background_img_id_str_isValid = ::MelodixAPI::fromJsonValue(m_background_img_id_str, json[QString("backgroundImgIdStr")]);
    m_background_img_id_str_isSet = !json[QString("backgroundImgIdStr")].isNull() && m_background_img_id_str_isValid;

    m_avatar_img_id_str_isValid = ::MelodixAPI::fromJsonValue(m_avatar_img_id_str, json[QString("avatarImgIdStr")]);
    m_avatar_img_id_str_isSet = !json[QString("avatarImgIdStr")].isNull() && m_avatar_img_id_str_isValid;

    m_user_type_isValid = ::MelodixAPI::fromJsonValue(m_user_type, json[QString("userType")]);
    m_user_type_isSet = !json[QString("userType")].isNull() && m_user_type_isValid;

    m_vip_type_isValid = ::MelodixAPI::fromJsonValue(m_vip_type, json[QString("vipType")]);
    m_vip_type_isSet = !json[QString("vipType")].isNull() && m_vip_type_isValid;

    m_auth_status_isValid = ::MelodixAPI::fromJsonValue(m_auth_status, json[QString("authStatus")]);
    m_auth_status_isSet = !json[QString("authStatus")].isNull() && m_auth_status_isValid;

    m_dj_status_isValid = ::MelodixAPI::fromJsonValue(m_dj_status, json[QString("djStatus")]);
    m_dj_status_isSet = !json[QString("djStatus")].isNull() && m_dj_status_isValid;

    m_detail_description_isValid = ::MelodixAPI::fromJsonValue(m_detail_description, json[QString("detailDescription")]);
    m_detail_description_isSet = !json[QString("detailDescription")].isNull() && m_detail_description_isValid;

    m_experts_isValid = ::MelodixAPI::fromJsonValue(m_experts, json[QString("experts")]);
    m_experts_isSet = !json[QString("experts")].isNull() && m_experts_isValid;

    m_account_status_isValid = ::MelodixAPI::fromJsonValue(m_account_status, json[QString("accountStatus")]);
    m_account_status_isSet = !json[QString("accountStatus")].isNull() && m_account_status_isValid;

    m_nickname_isValid = ::MelodixAPI::fromJsonValue(m_nickname, json[QString("nickname")]);
    m_nickname_isSet = !json[QString("nickname")].isNull() && m_nickname_isValid;

    m_birthday_isValid = ::MelodixAPI::fromJsonValue(m_birthday, json[QString("birthday")]);
    m_birthday_isSet = !json[QString("birthday")].isNull() && m_birthday_isValid;

    m_gender_isValid = ::MelodixAPI::fromJsonValue(m_gender, json[QString("gender")]);
    m_gender_isSet = !json[QString("gender")].isNull() && m_gender_isValid;

    m_province_isValid = ::MelodixAPI::fromJsonValue(m_province, json[QString("province")]);
    m_province_isSet = !json[QString("province")].isNull() && m_province_isValid;

    m_city_isValid = ::MelodixAPI::fromJsonValue(m_city, json[QString("city")]);
    m_city_isSet = !json[QString("city")].isNull() && m_city_isValid;

    m_avatar_img_id_isValid = ::MelodixAPI::fromJsonValue(m_avatar_img_id, json[QString("avatarImgId")]);
    m_avatar_img_id_isSet = !json[QString("avatarImgId")].isNull() && m_avatar_img_id_isValid;

    m_background_img_id_isValid = ::MelodixAPI::fromJsonValue(m_background_img_id, json[QString("backgroundImgId")]);
    m_background_img_id_isSet = !json[QString("backgroundImgId")].isNull() && m_background_img_id_isValid;

    m_avatar_url_isValid = ::MelodixAPI::fromJsonValue(m_avatar_url, json[QString("avatarUrl")]);
    m_avatar_url_isSet = !json[QString("avatarUrl")].isNull() && m_avatar_url_isValid;

    m_followed_isValid = ::MelodixAPI::fromJsonValue(m_followed, json[QString("followed")]);
    m_followed_isSet = !json[QString("followed")].isNull() && m_followed_isValid;

    m_background_url_isValid = ::MelodixAPI::fromJsonValue(m_background_url, json[QString("backgroundUrl")]);
    m_background_url_isSet = !json[QString("backgroundUrl")].isNull() && m_background_url_isValid;

    m_default_avatar_isValid = ::MelodixAPI::fromJsonValue(m_default_avatar, json[QString("defaultAvatar")]);
    m_default_avatar_isSet = !json[QString("defaultAvatar")].isNull() && m_default_avatar_isValid;

    m_mutual_isValid = ::MelodixAPI::fromJsonValue(m_mutual, json[QString("mutual")]);
    m_mutual_isSet = !json[QString("mutual")].isNull() && m_mutual_isValid;

    m_description_isValid = ::MelodixAPI::fromJsonValue(m_description, json[QString("description")]);
    m_description_isSet = !json[QString("description")].isNull() && m_description_isValid;

    m_user_id_isValid = ::MelodixAPI::fromJsonValue(m_user_id, json[QString("userId")]);
    m_user_id_isSet = !json[QString("userId")].isNull() && m_user_id_isValid;

    m_signature_isValid = ::MelodixAPI::fromJsonValue(m_signature, json[QString("signature")]);
    m_signature_isSet = !json[QString("signature")].isNull() && m_signature_isValid;

    m_authority_isValid = ::MelodixAPI::fromJsonValue(m_authority, json[QString("authority")]);
    m_authority_isSet = !json[QString("authority")].isNull() && m_authority_isValid;

    m_followeds_isValid = ::MelodixAPI::fromJsonValue(m_followeds, json[QString("followeds")]);
    m_followeds_isSet = !json[QString("followeds")].isNull() && m_followeds_isValid;

    m_follows_isValid = ::MelodixAPI::fromJsonValue(m_follows, json[QString("follows")]);
    m_follows_isSet = !json[QString("follows")].isNull() && m_follows_isValid;

    m_artist_id_isValid = ::MelodixAPI::fromJsonValue(m_artist_id, json[QString("artistId")]);
    m_artist_id_isSet = !json[QString("artistId")].isNull() && m_artist_id_isValid;

    m_event_count_isValid = ::MelodixAPI::fromJsonValue(m_event_count, json[QString("eventCount")]);
    m_event_count_isSet = !json[QString("eventCount")].isNull() && m_event_count_isValid;

    m_avatar_detail_isValid = ::MelodixAPI::fromJsonValue(m_avatar_detail, json[QString("avatarDetail")]);
    m_avatar_detail_isSet = !json[QString("avatarDetail")].isNull() && m_avatar_detail_isValid;

    m_playlist_count_isValid = ::MelodixAPI::fromJsonValue(m_playlist_count, json[QString("playlistCount")]);
    m_playlist_count_isSet = !json[QString("playlistCount")].isNull() && m_playlist_count_isValid;

    m_playlist_be_subscribed_count_isValid = ::MelodixAPI::fromJsonValue(m_playlist_be_subscribed_count, json[QString("playlistBeSubscribedCount")]);
    m_playlist_be_subscribed_count_isSet = !json[QString("playlistBeSubscribedCount")].isNull() && m_playlist_be_subscribed_count_isValid;
}

QString MDCellphoneLogin_200_response_profile::asJson() const {
    QJsonObject obj = this->asJsonObject();
    QJsonDocument doc(obj);
    QByteArray bytes = doc.toJson();
    return QString(bytes);
}

QJsonObject MDCellphoneLogin_200_response_profile::asJsonObject() const {
    QJsonObject obj;
    if (m_background_img_id_str_isSet) {
        obj.insert(QString("backgroundImgIdStr"), ::MelodixAPI::toJsonValue(m_background_img_id_str));
    }
    if (m_avatar_img_id_str_isSet) {
        obj.insert(QString("avatarImgIdStr"), ::MelodixAPI::toJsonValue(m_avatar_img_id_str));
    }
    if (m_user_type_isSet) {
        obj.insert(QString("userType"), ::MelodixAPI::toJsonValue(m_user_type));
    }
    if (m_vip_type_isSet) {
        obj.insert(QString("vipType"), ::MelodixAPI::toJsonValue(m_vip_type));
    }
    if (m_auth_status_isSet) {
        obj.insert(QString("authStatus"), ::MelodixAPI::toJsonValue(m_auth_status));
    }
    if (m_dj_status_isSet) {
        obj.insert(QString("djStatus"), ::MelodixAPI::toJsonValue(m_dj_status));
    }
    if (m_detail_description_isSet) {
        obj.insert(QString("detailDescription"), ::MelodixAPI::toJsonValue(m_detail_description));
    }
    if (m_experts_isSet) {
        obj.insert(QString("experts"), ::MelodixAPI::toJsonValue(m_experts));
    }
    if (m_account_status_isSet) {
        obj.insert(QString("accountStatus"), ::MelodixAPI::toJsonValue(m_account_status));
    }
    if (m_nickname_isSet) {
        obj.insert(QString("nickname"), ::MelodixAPI::toJsonValue(m_nickname));
    }
    if (m_birthday_isSet) {
        obj.insert(QString("birthday"), ::MelodixAPI::toJsonValue(m_birthday));
    }
    if (m_gender_isSet) {
        obj.insert(QString("gender"), ::MelodixAPI::toJsonValue(m_gender));
    }
    if (m_province_isSet) {
        obj.insert(QString("province"), ::MelodixAPI::toJsonValue(m_province));
    }
    if (m_city_isSet) {
        obj.insert(QString("city"), ::MelodixAPI::toJsonValue(m_city));
    }
    if (m_avatar_img_id_isSet) {
        obj.insert(QString("avatarImgId"), ::MelodixAPI::toJsonValue(m_avatar_img_id));
    }
    if (m_background_img_id_isSet) {
        obj.insert(QString("backgroundImgId"), ::MelodixAPI::toJsonValue(m_background_img_id));
    }
    if (m_avatar_url_isSet) {
        obj.insert(QString("avatarUrl"), ::MelodixAPI::toJsonValue(m_avatar_url));
    }
    if (m_followed_isSet) {
        obj.insert(QString("followed"), ::MelodixAPI::toJsonValue(m_followed));
    }
    if (m_background_url_isSet) {
        obj.insert(QString("backgroundUrl"), ::MelodixAPI::toJsonValue(m_background_url));
    }
    if (m_default_avatar_isSet) {
        obj.insert(QString("defaultAvatar"), ::MelodixAPI::toJsonValue(m_default_avatar));
    }
    if (m_mutual_isSet) {
        obj.insert(QString("mutual"), ::MelodixAPI::toJsonValue(m_mutual));
    }
    if (m_description_isSet) {
        obj.insert(QString("description"), ::MelodixAPI::toJsonValue(m_description));
    }
    if (m_user_id_isSet) {
        obj.insert(QString("userId"), ::MelodixAPI::toJsonValue(m_user_id));
    }
    if (m_signature_isSet) {
        obj.insert(QString("signature"), ::MelodixAPI::toJsonValue(m_signature));
    }
    if (m_authority_isSet) {
        obj.insert(QString("authority"), ::MelodixAPI::toJsonValue(m_authority));
    }
    if (m_followeds_isSet) {
        obj.insert(QString("followeds"), ::MelodixAPI::toJsonValue(m_followeds));
    }
    if (m_follows_isSet) {
        obj.insert(QString("follows"), ::MelodixAPI::toJsonValue(m_follows));
    }
    if (m_artist_id_isSet) {
        obj.insert(QString("artistId"), ::MelodixAPI::toJsonValue(m_artist_id));
    }
    if (m_event_count_isSet) {
        obj.insert(QString("eventCount"), ::MelodixAPI::toJsonValue(m_event_count));
    }
    if (m_avatar_detail.isSet()) {
        obj.insert(QString("avatarDetail"), ::MelodixAPI::toJsonValue(m_avatar_detail));
    }
    if (m_playlist_count_isSet) {
        obj.insert(QString("playlistCount"), ::MelodixAPI::toJsonValue(m_playlist_count));
    }
    if (m_playlist_be_subscribed_count_isSet) {
        obj.insert(QString("playlistBeSubscribedCount"), ::MelodixAPI::toJsonValue(m_playlist_be_subscribed_count));
    }
    return obj;
}

QString MDCellphoneLogin_200_response_profile::getBackgroundImgIdStr() const {
    return m_background_img_id_str;
}
void MDCellphoneLogin_200_response_profile::setBackgroundImgIdStr(const QString &background_img_id_str) {
    m_background_img_id_str = background_img_id_str;
    m_background_img_id_str_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_background_img_id_str_Set() const{
    return m_background_img_id_str_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_background_img_id_str_Valid() const{
    return m_background_img_id_str_isValid;
}

QString MDCellphoneLogin_200_response_profile::getAvatarImgIdStr() const {
    return m_avatar_img_id_str;
}
void MDCellphoneLogin_200_response_profile::setAvatarImgIdStr(const QString &avatar_img_id_str) {
    m_avatar_img_id_str = avatar_img_id_str;
    m_avatar_img_id_str_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_avatar_img_id_str_Set() const{
    return m_avatar_img_id_str_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_avatar_img_id_str_Valid() const{
    return m_avatar_img_id_str_isValid;
}

qint32 MDCellphoneLogin_200_response_profile::getUserType() const {
    return m_user_type;
}
void MDCellphoneLogin_200_response_profile::setUserType(const qint32 &user_type) {
    m_user_type = user_type;
    m_user_type_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_user_type_Set() const{
    return m_user_type_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_user_type_Valid() const{
    return m_user_type_isValid;
}

qint32 MDCellphoneLogin_200_response_profile::getVipType() const {
    return m_vip_type;
}
void MDCellphoneLogin_200_response_profile::setVipType(const qint32 &vip_type) {
    m_vip_type = vip_type;
    m_vip_type_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_vip_type_Set() const{
    return m_vip_type_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_vip_type_Valid() const{
    return m_vip_type_isValid;
}

qint32 MDCellphoneLogin_200_response_profile::getAuthStatus() const {
    return m_auth_status;
}
void MDCellphoneLogin_200_response_profile::setAuthStatus(const qint32 &auth_status) {
    m_auth_status = auth_status;
    m_auth_status_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_auth_status_Set() const{
    return m_auth_status_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_auth_status_Valid() const{
    return m_auth_status_isValid;
}

qint32 MDCellphoneLogin_200_response_profile::getDjStatus() const {
    return m_dj_status;
}
void MDCellphoneLogin_200_response_profile::setDjStatus(const qint32 &dj_status) {
    m_dj_status = dj_status;
    m_dj_status_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_dj_status_Set() const{
    return m_dj_status_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_dj_status_Valid() const{
    return m_dj_status_isValid;
}

QString MDCellphoneLogin_200_response_profile::getDetailDescription() const {
    return m_detail_description;
}
void MDCellphoneLogin_200_response_profile::setDetailDescription(const QString &detail_description) {
    m_detail_description = detail_description;
    m_detail_description_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_detail_description_Set() const{
    return m_detail_description_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_detail_description_Valid() const{
    return m_detail_description_isValid;
}

MDObject MDCellphoneLogin_200_response_profile::getExperts() const {
    return m_experts;
}
void MDCellphoneLogin_200_response_profile::setExperts(const MDObject &experts) {
    m_experts = experts;
    m_experts_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_experts_Set() const{
    return m_experts_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_experts_Valid() const{
    return m_experts_isValid;
}

qint32 MDCellphoneLogin_200_response_profile::getAccountStatus() const {
    return m_account_status;
}
void MDCellphoneLogin_200_response_profile::setAccountStatus(const qint32 &account_status) {
    m_account_status = account_status;
    m_account_status_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_account_status_Set() const{
    return m_account_status_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_account_status_Valid() const{
    return m_account_status_isValid;
}

QString MDCellphoneLogin_200_response_profile::getNickname() const {
    return m_nickname;
}
void MDCellphoneLogin_200_response_profile::setNickname(const QString &nickname) {
    m_nickname = nickname;
    m_nickname_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_nickname_Set() const{
    return m_nickname_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_nickname_Valid() const{
    return m_nickname_isValid;
}

qint32 MDCellphoneLogin_200_response_profile::getBirthday() const {
    return m_birthday;
}
void MDCellphoneLogin_200_response_profile::setBirthday(const qint32 &birthday) {
    m_birthday = birthday;
    m_birthday_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_birthday_Set() const{
    return m_birthday_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_birthday_Valid() const{
    return m_birthday_isValid;
}

qint32 MDCellphoneLogin_200_response_profile::getGender() const {
    return m_gender;
}
void MDCellphoneLogin_200_response_profile::setGender(const qint32 &gender) {
    m_gender = gender;
    m_gender_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_gender_Set() const{
    return m_gender_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_gender_Valid() const{
    return m_gender_isValid;
}

qint32 MDCellphoneLogin_200_response_profile::getProvince() const {
    return m_province;
}
void MDCellphoneLogin_200_response_profile::setProvince(const qint32 &province) {
    m_province = province;
    m_province_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_province_Set() const{
    return m_province_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_province_Valid() const{
    return m_province_isValid;
}

qint32 MDCellphoneLogin_200_response_profile::getCity() const {
    return m_city;
}
void MDCellphoneLogin_200_response_profile::setCity(const qint32 &city) {
    m_city = city;
    m_city_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_city_Set() const{
    return m_city_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_city_Valid() const{
    return m_city_isValid;
}

qint32 MDCellphoneLogin_200_response_profile::getAvatarImgId() const {
    return m_avatar_img_id;
}
void MDCellphoneLogin_200_response_profile::setAvatarImgId(const qint32 &avatar_img_id) {
    m_avatar_img_id = avatar_img_id;
    m_avatar_img_id_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_avatar_img_id_Set() const{
    return m_avatar_img_id_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_avatar_img_id_Valid() const{
    return m_avatar_img_id_isValid;
}

qint32 MDCellphoneLogin_200_response_profile::getBackgroundImgId() const {
    return m_background_img_id;
}
void MDCellphoneLogin_200_response_profile::setBackgroundImgId(const qint32 &background_img_id) {
    m_background_img_id = background_img_id;
    m_background_img_id_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_background_img_id_Set() const{
    return m_background_img_id_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_background_img_id_Valid() const{
    return m_background_img_id_isValid;
}

QString MDCellphoneLogin_200_response_profile::getAvatarUrl() const {
    return m_avatar_url;
}
void MDCellphoneLogin_200_response_profile::setAvatarUrl(const QString &avatar_url) {
    m_avatar_url = avatar_url;
    m_avatar_url_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_avatar_url_Set() const{
    return m_avatar_url_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_avatar_url_Valid() const{
    return m_avatar_url_isValid;
}

bool MDCellphoneLogin_200_response_profile::isFollowed() const {
    return m_followed;
}
void MDCellphoneLogin_200_response_profile::setFollowed(const bool &followed) {
    m_followed = followed;
    m_followed_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_followed_Set() const{
    return m_followed_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_followed_Valid() const{
    return m_followed_isValid;
}

QString MDCellphoneLogin_200_response_profile::getBackgroundUrl() const {
    return m_background_url;
}
void MDCellphoneLogin_200_response_profile::setBackgroundUrl(const QString &background_url) {
    m_background_url = background_url;
    m_background_url_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_background_url_Set() const{
    return m_background_url_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_background_url_Valid() const{
    return m_background_url_isValid;
}

bool MDCellphoneLogin_200_response_profile::isDefaultAvatar() const {
    return m_default_avatar;
}
void MDCellphoneLogin_200_response_profile::setDefaultAvatar(const bool &default_avatar) {
    m_default_avatar = default_avatar;
    m_default_avatar_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_default_avatar_Set() const{
    return m_default_avatar_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_default_avatar_Valid() const{
    return m_default_avatar_isValid;
}

bool MDCellphoneLogin_200_response_profile::isMutual() const {
    return m_mutual;
}
void MDCellphoneLogin_200_response_profile::setMutual(const bool &mutual) {
    m_mutual = mutual;
    m_mutual_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_mutual_Set() const{
    return m_mutual_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_mutual_Valid() const{
    return m_mutual_isValid;
}

QString MDCellphoneLogin_200_response_profile::getDescription() const {
    return m_description;
}
void MDCellphoneLogin_200_response_profile::setDescription(const QString &description) {
    m_description = description;
    m_description_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_description_Set() const{
    return m_description_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_description_Valid() const{
    return m_description_isValid;
}

qint32 MDCellphoneLogin_200_response_profile::getUserId() const {
    return m_user_id;
}
void MDCellphoneLogin_200_response_profile::setUserId(const qint32 &user_id) {
    m_user_id = user_id;
    m_user_id_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_user_id_Set() const{
    return m_user_id_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_user_id_Valid() const{
    return m_user_id_isValid;
}

QString MDCellphoneLogin_200_response_profile::getSignature() const {
    return m_signature;
}
void MDCellphoneLogin_200_response_profile::setSignature(const QString &signature) {
    m_signature = signature;
    m_signature_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_signature_Set() const{
    return m_signature_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_signature_Valid() const{
    return m_signature_isValid;
}

qint32 MDCellphoneLogin_200_response_profile::getAuthority() const {
    return m_authority;
}
void MDCellphoneLogin_200_response_profile::setAuthority(const qint32 &authority) {
    m_authority = authority;
    m_authority_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_authority_Set() const{
    return m_authority_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_authority_Valid() const{
    return m_authority_isValid;
}

qint32 MDCellphoneLogin_200_response_profile::getFolloweds() const {
    return m_followeds;
}
void MDCellphoneLogin_200_response_profile::setFolloweds(const qint32 &followeds) {
    m_followeds = followeds;
    m_followeds_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_followeds_Set() const{
    return m_followeds_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_followeds_Valid() const{
    return m_followeds_isValid;
}

qint32 MDCellphoneLogin_200_response_profile::getFollows() const {
    return m_follows;
}
void MDCellphoneLogin_200_response_profile::setFollows(const qint32 &follows) {
    m_follows = follows;
    m_follows_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_follows_Set() const{
    return m_follows_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_follows_Valid() const{
    return m_follows_isValid;
}

qint32 MDCellphoneLogin_200_response_profile::getArtistId() const {
    return m_artist_id;
}
void MDCellphoneLogin_200_response_profile::setArtistId(const qint32 &artist_id) {
    m_artist_id = artist_id;
    m_artist_id_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_artist_id_Set() const{
    return m_artist_id_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_artist_id_Valid() const{
    return m_artist_id_isValid;
}

qint32 MDCellphoneLogin_200_response_profile::getEventCount() const {
    return m_event_count;
}
void MDCellphoneLogin_200_response_profile::setEventCount(const qint32 &event_count) {
    m_event_count = event_count;
    m_event_count_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_event_count_Set() const{
    return m_event_count_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_event_count_Valid() const{
    return m_event_count_isValid;
}

MDCellphoneLogin_200_response_profile_avatarDetail MDCellphoneLogin_200_response_profile::getAvatarDetail() const {
    return m_avatar_detail;
}
void MDCellphoneLogin_200_response_profile::setAvatarDetail(const MDCellphoneLogin_200_response_profile_avatarDetail &avatar_detail) {
    m_avatar_detail = avatar_detail;
    m_avatar_detail_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_avatar_detail_Set() const{
    return m_avatar_detail_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_avatar_detail_Valid() const{
    return m_avatar_detail_isValid;
}

qint32 MDCellphoneLogin_200_response_profile::getPlaylistCount() const {
    return m_playlist_count;
}
void MDCellphoneLogin_200_response_profile::setPlaylistCount(const qint32 &playlist_count) {
    m_playlist_count = playlist_count;
    m_playlist_count_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_playlist_count_Set() const{
    return m_playlist_count_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_playlist_count_Valid() const{
    return m_playlist_count_isValid;
}

qint32 MDCellphoneLogin_200_response_profile::getPlaylistBeSubscribedCount() const {
    return m_playlist_be_subscribed_count;
}
void MDCellphoneLogin_200_response_profile::setPlaylistBeSubscribedCount(const qint32 &playlist_be_subscribed_count) {
    m_playlist_be_subscribed_count = playlist_be_subscribed_count;
    m_playlist_be_subscribed_count_isSet = true;
}

bool MDCellphoneLogin_200_response_profile::is_playlist_be_subscribed_count_Set() const{
    return m_playlist_be_subscribed_count_isSet;
}

bool MDCellphoneLogin_200_response_profile::is_playlist_be_subscribed_count_Valid() const{
    return m_playlist_be_subscribed_count_isValid;
}

bool MDCellphoneLogin_200_response_profile::isSet() const {
    bool isObjectUpdated = false;
    do {
        if (m_background_img_id_str_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_avatar_img_id_str_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_user_type_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_vip_type_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_auth_status_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_dj_status_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_detail_description_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_experts_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_account_status_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_nickname_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_birthday_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_gender_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_province_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_city_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_avatar_img_id_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_background_img_id_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_avatar_url_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_followed_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_background_url_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_default_avatar_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_mutual_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_description_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_user_id_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_signature_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_authority_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_followeds_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_follows_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_artist_id_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_event_count_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_avatar_detail.isSet()) {
            isObjectUpdated = true;
            break;
        }

        if (m_playlist_count_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_playlist_be_subscribed_count_isSet) {
            isObjectUpdated = true;
            break;
        }
    } while (false);
    return isObjectUpdated;
}

bool MDCellphoneLogin_200_response_profile::isValid() const {
    // only required properties are required for the object to be considered valid
    return m_background_img_id_str_isValid && m_avatar_img_id_str_isValid && m_user_type_isValid && m_vip_type_isValid && m_auth_status_isValid && m_dj_status_isValid && m_detail_description_isValid && m_experts_isValid && m_account_status_isValid && m_nickname_isValid && m_birthday_isValid && m_gender_isValid && m_province_isValid && m_city_isValid && m_avatar_img_id_isValid && m_background_img_id_isValid && m_avatar_url_isValid && m_followed_isValid && m_background_url_isValid && m_default_avatar_isValid && m_mutual_isValid && m_description_isValid && m_user_id_isValid && m_signature_isValid && m_authority_isValid && m_followeds_isValid && m_follows_isValid && m_artist_id_isValid && m_event_count_isValid && m_avatar_detail_isValid && m_playlist_count_isValid && m_playlist_be_subscribed_count_isValid && true;
}

} // namespace MelodixAPI
