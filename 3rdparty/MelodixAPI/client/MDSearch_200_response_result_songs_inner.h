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
 * MDSearch_200_response_result_songs_inner.h
 *
 * 
 */

#ifndef MDSearch_200_response_result_songs_inner_H
#define MDSearch_200_response_result_songs_inner_H

#include <QJsonObject>

#include "MDGetArtistSingle_200_response_songs_inner_ar_inner.h"
#include "MDSearch_200_response_result_songs_inner_al.h"
#include <QList>
#include <QString>

#include "MDEnum.h"
#include "MDObject.h"

namespace MelodixAPI {
class MDGetArtistSingle_200_response_songs_inner_ar_inner;
class MDSearch_200_response_result_songs_inner_al;

class MDSearch_200_response_result_songs_inner : public MDObject {
public:
    MDSearch_200_response_result_songs_inner();
    MDSearch_200_response_result_songs_inner(QString json);
    ~MDSearch_200_response_result_songs_inner() override;

    QString asJson() const override;
    QJsonObject asJsonObject() const override;
    void fromJsonObject(QJsonObject json) override;
    void fromJson(QString jsonString) override;

    QString getName() const;
    void setName(const QString &name);
    bool is_name_Set() const;
    bool is_name_Valid() const;

    qint32 getId() const;
    void setId(const qint32 &id);
    bool is_id_Set() const;
    bool is_id_Valid() const;

    QList<MDGetArtistSingle_200_response_songs_inner_ar_inner> getAr() const;
    void setAr(const QList<MDGetArtistSingle_200_response_songs_inner_ar_inner> &ar);
    bool is_ar_Set() const;
    bool is_ar_Valid() const;

    MDSearch_200_response_result_songs_inner_al getAl() const;
    void setAl(const MDSearch_200_response_result_songs_inner_al &al);
    bool is_al_Set() const;
    bool is_al_Valid() const;

    qint32 getDt() const;
    void setDt(const qint32 &dt);
    bool is_dt_Set() const;
    bool is_dt_Valid() const;

    qint32 getCopyright() const;
    void setCopyright(const qint32 &copyright);
    bool is_copyright_Set() const;
    bool is_copyright_Valid() const;

    bool isResourceState() const;
    void setResourceState(const bool &resource_state);
    bool is_resource_state_Set() const;
    bool is_resource_state_Valid() const;

    qint32 getVersion() const;
    void setVersion(const qint32 &version);
    bool is_version_Set() const;
    bool is_version_Valid() const;

    qint32 getSingle() const;
    void setSingle(const qint32 &single);
    bool is_single_Set() const;
    bool is_single_Valid() const;

    qint32 getMv() const;
    void setMv(const qint32 &mv);
    bool is_mv_Set() const;
    bool is_mv_Valid() const;

    qint32 getPublishTime() const;
    void setPublishTime(const qint32 &publish_time);
    bool is_publish_time_Set() const;
    bool is_publish_time_Valid() const;

    virtual bool isSet() const override;
    virtual bool isValid() const override;

private:
    void initializeModel();

    QString m_name;
    bool m_name_isSet;
    bool m_name_isValid;

    qint32 m_id;
    bool m_id_isSet;
    bool m_id_isValid;

    QList<MDGetArtistSingle_200_response_songs_inner_ar_inner> m_ar;
    bool m_ar_isSet;
    bool m_ar_isValid;

    MDSearch_200_response_result_songs_inner_al m_al;
    bool m_al_isSet;
    bool m_al_isValid;

    qint32 m_dt;
    bool m_dt_isSet;
    bool m_dt_isValid;

    qint32 m_copyright;
    bool m_copyright_isSet;
    bool m_copyright_isValid;

    bool m_resource_state;
    bool m_resource_state_isSet;
    bool m_resource_state_isValid;

    qint32 m_version;
    bool m_version_isSet;
    bool m_version_isValid;

    qint32 m_single;
    bool m_single_isSet;
    bool m_single_isValid;

    qint32 m_mv;
    bool m_mv_isSet;
    bool m_mv_isValid;

    qint32 m_publish_time;
    bool m_publish_time_isSet;
    bool m_publish_time_isValid;
};

} // namespace MelodixAPI

Q_DECLARE_METATYPE(MelodixAPI::MDSearch_200_response_result_songs_inner)

#endif // MDSearch_200_response_result_songs_inner_H
