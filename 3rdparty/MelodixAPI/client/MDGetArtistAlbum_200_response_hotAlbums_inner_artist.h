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
 * MDGetArtistAlbum_200_response_hotAlbums_inner_artist.h
 *
 * 
 */

#ifndef MDGetArtistAlbum_200_response_hotAlbums_inner_artist_H
#define MDGetArtistAlbum_200_response_hotAlbums_inner_artist_H

#include <QJsonObject>

#include <QString>

#include "MDEnum.h"
#include "MDObject.h"

namespace MelodixAPI {

class MDGetArtistAlbum_200_response_hotAlbums_inner_artist : public MDObject {
public:
    MDGetArtistAlbum_200_response_hotAlbums_inner_artist();
    MDGetArtistAlbum_200_response_hotAlbums_inner_artist(QString json);
    ~MDGetArtistAlbum_200_response_hotAlbums_inner_artist() override;

    QString asJson() const override;
    QJsonObject asJsonObject() const override;
    void fromJsonObject(QJsonObject json) override;
    void fromJson(QString jsonString) override;

    qint32 getMusicSize() const;
    void setMusicSize(const qint32 &music_size);
    bool is_music_size_Set() const;
    bool is_music_size_Valid() const;

    qint32 getAlbumSize() const;
    void setAlbumSize(const qint32 &album_size);
    bool is_album_size_Set() const;
    bool is_album_size_Valid() const;

    QString getPicUrl() const;
    void setPicUrl(const QString &pic_url);
    bool is_pic_url_Set() const;
    bool is_pic_url_Valid() const;

    QString getImg1v1Url() const;
    void setImg1v1Url(const QString &img1v1_url);
    bool is_img1v1_url_Set() const;
    bool is_img1v1_url_Valid() const;

    QString getName() const;
    void setName(const QString &name);
    bool is_name_Set() const;
    bool is_name_Valid() const;

    qint32 getId() const;
    void setId(const qint32 &id);
    bool is_id_Set() const;
    bool is_id_Valid() const;

    virtual bool isSet() const override;
    virtual bool isValid() const override;

private:
    void initializeModel();

    qint32 m_music_size;
    bool m_music_size_isSet;
    bool m_music_size_isValid;

    qint32 m_album_size;
    bool m_album_size_isSet;
    bool m_album_size_isValid;

    QString m_pic_url;
    bool m_pic_url_isSet;
    bool m_pic_url_isValid;

    QString m_img1v1_url;
    bool m_img1v1_url_isSet;
    bool m_img1v1_url_isValid;

    QString m_name;
    bool m_name_isSet;
    bool m_name_isValid;

    qint32 m_id;
    bool m_id_isSet;
    bool m_id_isValid;
};

} // namespace MelodixAPI

Q_DECLARE_METATYPE(MelodixAPI::MDGetArtistAlbum_200_response_hotAlbums_inner_artist)

#endif // MDGetArtistAlbum_200_response_hotAlbums_inner_artist_H
