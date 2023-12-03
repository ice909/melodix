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
 * MDGetRecommendedPlaylist_200_response_result_inner.h
 *
 * 
 */

#ifndef MDGetRecommendedPlaylist_200_response_result_inner_H
#define MDGetRecommendedPlaylist_200_response_result_inner_H

#include <QJsonObject>

#include <QString>

#include "MDEnum.h"
#include "MDObject.h"

namespace MelodixAPI {

class MDGetRecommendedPlaylist_200_response_result_inner : public MDObject {
public:
    MDGetRecommendedPlaylist_200_response_result_inner();
    MDGetRecommendedPlaylist_200_response_result_inner(QString json);
    ~MDGetRecommendedPlaylist_200_response_result_inner() override;

    QString asJson() const override;
    QJsonObject asJsonObject() const override;
    void fromJsonObject(QJsonObject json) override;
    void fromJson(QString jsonString) override;

    double getId() const;
    void setId(const double &id);
    bool is_id_Set() const;
    bool is_id_Valid() const;

    qint32 getType() const;
    void setType(const qint32 &type);
    bool is_type_Set() const;
    bool is_type_Valid() const;

    QString getName() const;
    void setName(const QString &name);
    bool is_name_Set() const;
    bool is_name_Valid() const;

    QString getPicUrl() const;
    void setPicUrl(const QString &pic_url);
    bool is_pic_url_Set() const;
    bool is_pic_url_Valid() const;

    qint32 getPlayCount() const;
    void setPlayCount(const qint32 &play_count);
    bool is_play_count_Set() const;
    bool is_play_count_Valid() const;

    qint32 getTrackCount() const;
    void setTrackCount(const qint32 &track_count);
    bool is_track_count_Set() const;
    bool is_track_count_Valid() const;

    virtual bool isSet() const override;
    virtual bool isValid() const override;

private:
    void initializeModel();

    double m_id;
    bool m_id_isSet;
    bool m_id_isValid;

    qint32 m_type;
    bool m_type_isSet;
    bool m_type_isValid;

    QString m_name;
    bool m_name_isSet;
    bool m_name_isValid;

    QString m_pic_url;
    bool m_pic_url_isSet;
    bool m_pic_url_isValid;

    qint32 m_play_count;
    bool m_play_count_isSet;
    bool m_play_count_isValid;

    qint32 m_track_count;
    bool m_track_count_isSet;
    bool m_track_count_isValid;
};

} // namespace MelodixAPI

Q_DECLARE_METATYPE(MelodixAPI::MDGetRecommendedPlaylist_200_response_result_inner)

#endif // MDGetRecommendedPlaylist_200_response_result_inner_H
