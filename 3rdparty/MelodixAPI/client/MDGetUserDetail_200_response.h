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
 * MDGetUserDetail_200_response.h
 *
 * 
 */

#ifndef MDGetUserDetail_200_response_H
#define MDGetUserDetail_200_response_H

#include <QJsonObject>

#include "MDGetUserDetail_200_response_bindings_inner.h"
#include "MDGetUserDetail_200_response_identify.h"
#include "MDGetUserDetail_200_response_products_inner.h"
#include "MDGetUserDetail_200_response_profile.h"
#include "MDGetUserDetail_200_response_profileVillageInfo.h"
#include "MDGetUserDetail_200_response_userPoint.h"
#include <QList>

#include "MDEnum.h"
#include "MDObject.h"

namespace MelodixAPI {
class MDGetUserDetail_200_response_identify;
class MDGetUserDetail_200_response_products_inner;
class MDGetUserDetail_200_response_userPoint;
class MDGetUserDetail_200_response_profile;
class MDGetUserDetail_200_response_bindings_inner;
class MDGetUserDetail_200_response_profileVillageInfo;

class MDGetUserDetail_200_response : public MDObject {
public:
    MDGetUserDetail_200_response();
    MDGetUserDetail_200_response(QString json);
    ~MDGetUserDetail_200_response() override;

    QString asJson() const override;
    QJsonObject asJsonObject() const override;
    void fromJsonObject(QJsonObject json) override;
    void fromJson(QString jsonString) override;

    MDGetUserDetail_200_response_identify getIdentify() const;
    void setIdentify(const MDGetUserDetail_200_response_identify &identify);
    bool is_identify_Set() const;
    bool is_identify_Valid() const;

    QList<MDGetUserDetail_200_response_products_inner> getProducts() const;
    void setProducts(const QList<MDGetUserDetail_200_response_products_inner> &products);
    bool is_products_Set() const;
    bool is_products_Valid() const;

    qint32 getLevel() const;
    void setLevel(const qint32 &level);
    bool is_level_Set() const;
    bool is_level_Valid() const;

    qint32 getListenSongs() const;
    void setListenSongs(const qint32 &listen_songs);
    bool is_listen_songs_Set() const;
    bool is_listen_songs_Valid() const;

    MDGetUserDetail_200_response_userPoint getUserPoint() const;
    void setUserPoint(const MDGetUserDetail_200_response_userPoint &user_point);
    bool is_user_point_Set() const;
    bool is_user_point_Valid() const;

    bool isMobileSign() const;
    void setMobileSign(const bool &mobile_sign);
    bool is_mobile_sign_Set() const;
    bool is_mobile_sign_Valid() const;

    bool isPcSign() const;
    void setPcSign(const bool &pc_sign);
    bool is_pc_sign_Set() const;
    bool is_pc_sign_Valid() const;

    MDGetUserDetail_200_response_profile getProfile() const;
    void setProfile(const MDGetUserDetail_200_response_profile &profile);
    bool is_profile_Set() const;
    bool is_profile_Valid() const;

    bool isPeopleCanSeeMyPlayRecord() const;
    void setPeopleCanSeeMyPlayRecord(const bool &people_can_see_my_play_record);
    bool is_people_can_see_my_play_record_Set() const;
    bool is_people_can_see_my_play_record_Valid() const;

    QList<MDGetUserDetail_200_response_bindings_inner> getBindings() const;
    void setBindings(const QList<MDGetUserDetail_200_response_bindings_inner> &bindings);
    bool is_bindings_Set() const;
    bool is_bindings_Valid() const;

    bool isAdValid() const;
    void setAdValid(const bool &ad_valid);
    bool is_ad_valid_Set() const;
    bool is_ad_valid_Valid() const;

    qint32 getCode() const;
    void setCode(const qint32 &code);
    bool is_code_Set() const;
    bool is_code_Valid() const;

    bool isNewUser() const;
    void setNewUser(const bool &new_user);
    bool is_new_user_Set() const;
    bool is_new_user_Valid() const;

    bool isRecallUser() const;
    void setRecallUser(const bool &recall_user);
    bool is_recall_user_Set() const;
    bool is_recall_user_Valid() const;

    qint32 getCreateTime() const;
    void setCreateTime(const qint32 &create_time);
    bool is_create_time_Set() const;
    bool is_create_time_Valid() const;

    qint32 getCreateDays() const;
    void setCreateDays(const qint32 &create_days);
    bool is_create_days_Set() const;
    bool is_create_days_Valid() const;

    MDGetUserDetail_200_response_profileVillageInfo getProfileVillageInfo() const;
    void setProfileVillageInfo(const MDGetUserDetail_200_response_profileVillageInfo &profile_village_info);
    bool is_profile_village_info_Set() const;
    bool is_profile_village_info_Valid() const;

    virtual bool isSet() const override;
    virtual bool isValid() const override;

private:
    void initializeModel();

    MDGetUserDetail_200_response_identify m_identify;
    bool m_identify_isSet;
    bool m_identify_isValid;

    QList<MDGetUserDetail_200_response_products_inner> m_products;
    bool m_products_isSet;
    bool m_products_isValid;

    qint32 m_level;
    bool m_level_isSet;
    bool m_level_isValid;

    qint32 m_listen_songs;
    bool m_listen_songs_isSet;
    bool m_listen_songs_isValid;

    MDGetUserDetail_200_response_userPoint m_user_point;
    bool m_user_point_isSet;
    bool m_user_point_isValid;

    bool m_mobile_sign;
    bool m_mobile_sign_isSet;
    bool m_mobile_sign_isValid;

    bool m_pc_sign;
    bool m_pc_sign_isSet;
    bool m_pc_sign_isValid;

    MDGetUserDetail_200_response_profile m_profile;
    bool m_profile_isSet;
    bool m_profile_isValid;

    bool m_people_can_see_my_play_record;
    bool m_people_can_see_my_play_record_isSet;
    bool m_people_can_see_my_play_record_isValid;

    QList<MDGetUserDetail_200_response_bindings_inner> m_bindings;
    bool m_bindings_isSet;
    bool m_bindings_isValid;

    bool m_ad_valid;
    bool m_ad_valid_isSet;
    bool m_ad_valid_isValid;

    qint32 m_code;
    bool m_code_isSet;
    bool m_code_isValid;

    bool m_new_user;
    bool m_new_user_isSet;
    bool m_new_user_isValid;

    bool m_recall_user;
    bool m_recall_user_isSet;
    bool m_recall_user_isValid;

    qint32 m_create_time;
    bool m_create_time_isSet;
    bool m_create_time_isValid;

    qint32 m_create_days;
    bool m_create_days_isSet;
    bool m_create_days_isValid;

    MDGetUserDetail_200_response_profileVillageInfo m_profile_village_info;
    bool m_profile_village_info_isSet;
    bool m_profile_village_info_isValid;
};

} // namespace MelodixAPI

Q_DECLARE_METATYPE(MelodixAPI::MDGetUserDetail_200_response)

#endif // MDGetUserDetail_200_response_H
