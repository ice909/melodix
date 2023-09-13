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
 * MDGetSimiMv_200_response_mvs_inner.h
 *
 * 
 */

#ifndef MDGetSimiMv_200_response_mvs_inner_H
#define MDGetSimiMv_200_response_mvs_inner_H

#include <QJsonObject>

#include "MDGetSimiMv_200_response_mvs_inner_artists_inner.h"
#include <QList>
#include <QString>

#include "MDEnum.h"
#include "MDObject.h"

namespace MelodixAPI {
class MDGetSimiMv_200_response_mvs_inner_artists_inner;

class MDGetSimiMv_200_response_mvs_inner : public MDObject {
public:
    MDGetSimiMv_200_response_mvs_inner();
    MDGetSimiMv_200_response_mvs_inner(QString json);
    ~MDGetSimiMv_200_response_mvs_inner() override;

    QString asJson() const override;
    QJsonObject asJsonObject() const override;
    void fromJsonObject(QJsonObject json) override;
    void fromJson(QString jsonString) override;

    qint32 getId() const;
    void setId(const qint32 &id);
    bool is_id_Set() const;
    bool is_id_Valid() const;

    QString getCover() const;
    void setCover(const QString &cover);
    bool is_cover_Set() const;
    bool is_cover_Valid() const;

    QString getName() const;
    void setName(const QString &name);
    bool is_name_Set() const;
    bool is_name_Valid() const;

    qint32 getPlayCount() const;
    void setPlayCount(const qint32 &play_count);
    bool is_play_count_Set() const;
    bool is_play_count_Valid() const;

    QString getBriefDesc() const;
    void setBriefDesc(const QString &brief_desc);
    bool is_brief_desc_Set() const;
    bool is_brief_desc_Valid() const;

    QString getArtistName() const;
    void setArtistName(const QString &artist_name);
    bool is_artist_name_Set() const;
    bool is_artist_name_Valid() const;

    qint32 getArtistId() const;
    void setArtistId(const qint32 &artist_id);
    bool is_artist_id_Set() const;
    bool is_artist_id_Valid() const;

    qint32 getDuration() const;
    void setDuration(const qint32 &duration);
    bool is_duration_Set() const;
    bool is_duration_Valid() const;

    qint32 getMark() const;
    void setMark(const qint32 &mark);
    bool is_mark_Set() const;
    bool is_mark_Valid() const;

    QList<MDGetSimiMv_200_response_mvs_inner_artists_inner> getArtists() const;
    void setArtists(const QList<MDGetSimiMv_200_response_mvs_inner_artists_inner> &artists);
    bool is_artists_Set() const;
    bool is_artists_Valid() const;

    QString getAlg() const;
    void setAlg(const QString &alg);
    bool is_alg_Set() const;
    bool is_alg_Valid() const;

    virtual bool isSet() const override;
    virtual bool isValid() const override;

private:
    void initializeModel();

    qint32 m_id;
    bool m_id_isSet;
    bool m_id_isValid;

    QString m_cover;
    bool m_cover_isSet;
    bool m_cover_isValid;

    QString m_name;
    bool m_name_isSet;
    bool m_name_isValid;

    qint32 m_play_count;
    bool m_play_count_isSet;
    bool m_play_count_isValid;

    QString m_brief_desc;
    bool m_brief_desc_isSet;
    bool m_brief_desc_isValid;

    QString m_artist_name;
    bool m_artist_name_isSet;
    bool m_artist_name_isValid;

    qint32 m_artist_id;
    bool m_artist_id_isSet;
    bool m_artist_id_isValid;

    qint32 m_duration;
    bool m_duration_isSet;
    bool m_duration_isValid;

    qint32 m_mark;
    bool m_mark_isSet;
    bool m_mark_isValid;

    QList<MDGetSimiMv_200_response_mvs_inner_artists_inner> m_artists;
    bool m_artists_isSet;
    bool m_artists_isValid;

    QString m_alg;
    bool m_alg_isSet;
    bool m_alg_isValid;
};

} // namespace MelodixAPI

Q_DECLARE_METATYPE(MelodixAPI::MDGetSimiMv_200_response_mvs_inner)

#endif // MDGetSimiMv_200_response_mvs_inner_H
