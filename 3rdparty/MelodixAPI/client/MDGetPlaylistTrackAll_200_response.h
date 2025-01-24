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
 * MDGetPlaylistTrackAll_200_response.h
 *
 * 
 */

#ifndef MDGetPlaylistTrackAll_200_response_H
#define MDGetPlaylistTrackAll_200_response_H

#include <QJsonObject>

#include "MDGetPlaylistTrackAll_200_response_privileges_inner.h"
#include "MDGetPlaylistTrackAll_200_response_songs_inner.h"
#include <QList>

#include "MDEnum.h"
#include "MDObject.h"

namespace MelodixAPI {
class MDGetPlaylistTrackAll_200_response_songs_inner;
class MDGetPlaylistTrackAll_200_response_privileges_inner;

class MDGetPlaylistTrackAll_200_response : public MDObject {
public:
    MDGetPlaylistTrackAll_200_response();
    MDGetPlaylistTrackAll_200_response(QString json);
    ~MDGetPlaylistTrackAll_200_response() override;

    QString asJson() const override;
    QJsonObject asJsonObject() const override;
    void fromJsonObject(QJsonObject json) override;
    void fromJson(QString jsonString) override;

    QList<MDGetPlaylistTrackAll_200_response_songs_inner> getSongs() const;
    void setSongs(const QList<MDGetPlaylistTrackAll_200_response_songs_inner> &songs);
    bool is_songs_Set() const;
    bool is_songs_Valid() const;

    qint32 getCode() const;
    void setCode(const qint32 &code);
    bool is_code_Set() const;
    bool is_code_Valid() const;

    QList<MDGetPlaylistTrackAll_200_response_privileges_inner> getPrivileges() const;
    void setPrivileges(const QList<MDGetPlaylistTrackAll_200_response_privileges_inner> &privileges);
    bool is_privileges_Set() const;
    bool is_privileges_Valid() const;

    virtual bool isSet() const override;
    virtual bool isValid() const override;

private:
    void initializeModel();

    QList<MDGetPlaylistTrackAll_200_response_songs_inner> m_songs;
    bool m_songs_isSet;
    bool m_songs_isValid;

    qint32 m_code;
    bool m_code_isSet;
    bool m_code_isValid;

    QList<MDGetPlaylistTrackAll_200_response_privileges_inner> m_privileges;
    bool m_privileges_isSet;
    bool m_privileges_isValid;
};

} // namespace MelodixAPI

Q_DECLARE_METATYPE(MelodixAPI::MDGetPlaylistTrackAll_200_response)

#endif // MDGetPlaylistTrackAll_200_response_H
