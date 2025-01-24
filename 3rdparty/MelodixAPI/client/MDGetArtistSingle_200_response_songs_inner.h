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
 * MDGetArtistSingle_200_response_songs_inner.h
 *
 * 
 */

#ifndef MDGetArtistSingle_200_response_songs_inner_H
#define MDGetArtistSingle_200_response_songs_inner_H

#include <QJsonObject>

#include "MDSearch_200_response_result_songs_inner_ar_inner.h"
#include <QList>
#include <QString>

#include "MDEnum.h"
#include "MDObject.h"

namespace MelodixAPI {
class MDSearch_200_response_result_songs_inner_ar_inner;

class MDGetArtistSingle_200_response_songs_inner : public MDObject {
public:
    MDGetArtistSingle_200_response_songs_inner();
    MDGetArtistSingle_200_response_songs_inner(QString json);
    ~MDGetArtistSingle_200_response_songs_inner() override;

    QString asJson() const override;
    QJsonObject asJsonObject() const override;
    void fromJsonObject(QJsonObject json) override;
    void fromJson(QString jsonString) override;

    QString getName() const;
    void setName(const QString &name);
    bool is_name_Set() const;
    bool is_name_Valid() const;

    QString getId() const;
    void setId(const QString &id);
    bool is_id_Set() const;
    bool is_id_Valid() const;

    QList<MDSearch_200_response_result_songs_inner_ar_inner> getAr() const;
    void setAr(const QList<MDSearch_200_response_result_songs_inner_ar_inner> &ar);
    bool is_ar_Set() const;
    bool is_ar_Valid() const;

    QString getAl() const;
    void setAl(const QString &al);
    bool is_al_Set() const;
    bool is_al_Valid() const;

    qint32 getDt() const;
    void setDt(const qint32 &dt);
    bool is_dt_Set() const;
    bool is_dt_Valid() const;

    qint32 getPublishTime() const;
    void setPublishTime(const qint32 &publish_time);
    bool is_publish_time_Set() const;
    bool is_publish_time_Valid() const;

    QString getPic() const;
    void setPic(const QString &pic);
    bool is_pic_Set() const;
    bool is_pic_Valid() const;

    qint32 getDuration() const;
    void setDuration(const qint32 &duration);
    bool is_duration_Set() const;
    bool is_duration_Valid() const;

    virtual bool isSet() const override;
    virtual bool isValid() const override;

private:
    void initializeModel();

    QString m_name;
    bool m_name_isSet;
    bool m_name_isValid;

    QString m_id;
    bool m_id_isSet;
    bool m_id_isValid;

    QList<MDSearch_200_response_result_songs_inner_ar_inner> m_ar;
    bool m_ar_isSet;
    bool m_ar_isValid;

    QString m_al;
    bool m_al_isSet;
    bool m_al_isValid;

    qint32 m_dt;
    bool m_dt_isSet;
    bool m_dt_isValid;

    qint32 m_publish_time;
    bool m_publish_time_isSet;
    bool m_publish_time_isValid;

    QString m_pic;
    bool m_pic_isSet;
    bool m_pic_isValid;

    qint32 m_duration;
    bool m_duration_isSet;
    bool m_duration_isValid;
};

} // namespace MelodixAPI

Q_DECLARE_METATYPE(MelodixAPI::MDGetArtistSingle_200_response_songs_inner)

#endif // MDGetArtistSingle_200_response_songs_inner_H
