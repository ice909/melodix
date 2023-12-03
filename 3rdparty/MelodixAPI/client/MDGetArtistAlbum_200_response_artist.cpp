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

#include "MDGetArtistAlbum_200_response_artist.h"

#include <QDebug>
#include <QJsonArray>
#include <QJsonDocument>
#include <QObject>

#include "MDHelpers.h"

namespace MelodixAPI {

MDGetArtistAlbum_200_response_artist::MDGetArtistAlbum_200_response_artist(QString json) {
    this->initializeModel();
    this->fromJson(json);
}

MDGetArtistAlbum_200_response_artist::MDGetArtistAlbum_200_response_artist() {
    this->initializeModel();
}

MDGetArtistAlbum_200_response_artist::~MDGetArtistAlbum_200_response_artist() {}

void MDGetArtistAlbum_200_response_artist::initializeModel() {

    m_followed_isSet = false;
    m_followed_isValid = false;

    m_album_size_isSet = false;
    m_album_size_isValid = false;

    m_pic_url_isSet = false;
    m_pic_url_isValid = false;

    m_img1v1_url_isSet = false;
    m_img1v1_url_isValid = false;

    m_name_isSet = false;
    m_name_isValid = false;

    m_id_isSet = false;
    m_id_isValid = false;
}

void MDGetArtistAlbum_200_response_artist::fromJson(QString jsonString) {
    QByteArray array(jsonString.toStdString().c_str());
    QJsonDocument doc = QJsonDocument::fromJson(array);
    QJsonObject jsonObject = doc.object();
    this->fromJsonObject(jsonObject);
}

void MDGetArtistAlbum_200_response_artist::fromJsonObject(QJsonObject json) {

    m_followed_isValid = ::MelodixAPI::fromJsonValue(m_followed, json[QString("followed")]);
    m_followed_isSet = !json[QString("followed")].isNull() && m_followed_isValid;

    m_album_size_isValid = ::MelodixAPI::fromJsonValue(m_album_size, json[QString("albumSize")]);
    m_album_size_isSet = !json[QString("albumSize")].isNull() && m_album_size_isValid;

    m_pic_url_isValid = ::MelodixAPI::fromJsonValue(m_pic_url, json[QString("picUrl")]);
    m_pic_url_isSet = !json[QString("picUrl")].isNull() && m_pic_url_isValid;

    m_img1v1_url_isValid = ::MelodixAPI::fromJsonValue(m_img1v1_url, json[QString("img1v1Url")]);
    m_img1v1_url_isSet = !json[QString("img1v1Url")].isNull() && m_img1v1_url_isValid;

    m_name_isValid = ::MelodixAPI::fromJsonValue(m_name, json[QString("name")]);
    m_name_isSet = !json[QString("name")].isNull() && m_name_isValid;

    m_id_isValid = ::MelodixAPI::fromJsonValue(m_id, json[QString("id")]);
    m_id_isSet = !json[QString("id")].isNull() && m_id_isValid;
}

QString MDGetArtistAlbum_200_response_artist::asJson() const {
    QJsonObject obj = this->asJsonObject();
    QJsonDocument doc(obj);
    QByteArray bytes = doc.toJson();
    return QString(bytes);
}

QJsonObject MDGetArtistAlbum_200_response_artist::asJsonObject() const {
    QJsonObject obj;
    if (m_followed_isSet) {
        obj.insert(QString("followed"), ::MelodixAPI::toJsonValue(m_followed));
    }
    if (m_album_size_isSet) {
        obj.insert(QString("albumSize"), ::MelodixAPI::toJsonValue(m_album_size));
    }
    if (m_pic_url_isSet) {
        obj.insert(QString("picUrl"), ::MelodixAPI::toJsonValue(m_pic_url));
    }
    if (m_img1v1_url_isSet) {
        obj.insert(QString("img1v1Url"), ::MelodixAPI::toJsonValue(m_img1v1_url));
    }
    if (m_name_isSet) {
        obj.insert(QString("name"), ::MelodixAPI::toJsonValue(m_name));
    }
    if (m_id_isSet) {
        obj.insert(QString("id"), ::MelodixAPI::toJsonValue(m_id));
    }
    return obj;
}

bool MDGetArtistAlbum_200_response_artist::isFollowed() const {
    return m_followed;
}
void MDGetArtistAlbum_200_response_artist::setFollowed(const bool &followed) {
    m_followed = followed;
    m_followed_isSet = true;
}

bool MDGetArtistAlbum_200_response_artist::is_followed_Set() const{
    return m_followed_isSet;
}

bool MDGetArtistAlbum_200_response_artist::is_followed_Valid() const{
    return m_followed_isValid;
}

qint32 MDGetArtistAlbum_200_response_artist::getAlbumSize() const {
    return m_album_size;
}
void MDGetArtistAlbum_200_response_artist::setAlbumSize(const qint32 &album_size) {
    m_album_size = album_size;
    m_album_size_isSet = true;
}

bool MDGetArtistAlbum_200_response_artist::is_album_size_Set() const{
    return m_album_size_isSet;
}

bool MDGetArtistAlbum_200_response_artist::is_album_size_Valid() const{
    return m_album_size_isValid;
}

QString MDGetArtistAlbum_200_response_artist::getPicUrl() const {
    return m_pic_url;
}
void MDGetArtistAlbum_200_response_artist::setPicUrl(const QString &pic_url) {
    m_pic_url = pic_url;
    m_pic_url_isSet = true;
}

bool MDGetArtistAlbum_200_response_artist::is_pic_url_Set() const{
    return m_pic_url_isSet;
}

bool MDGetArtistAlbum_200_response_artist::is_pic_url_Valid() const{
    return m_pic_url_isValid;
}

QString MDGetArtistAlbum_200_response_artist::getImg1v1Url() const {
    return m_img1v1_url;
}
void MDGetArtistAlbum_200_response_artist::setImg1v1Url(const QString &img1v1_url) {
    m_img1v1_url = img1v1_url;
    m_img1v1_url_isSet = true;
}

bool MDGetArtistAlbum_200_response_artist::is_img1v1_url_Set() const{
    return m_img1v1_url_isSet;
}

bool MDGetArtistAlbum_200_response_artist::is_img1v1_url_Valid() const{
    return m_img1v1_url_isValid;
}

QString MDGetArtistAlbum_200_response_artist::getName() const {
    return m_name;
}
void MDGetArtistAlbum_200_response_artist::setName(const QString &name) {
    m_name = name;
    m_name_isSet = true;
}

bool MDGetArtistAlbum_200_response_artist::is_name_Set() const{
    return m_name_isSet;
}

bool MDGetArtistAlbum_200_response_artist::is_name_Valid() const{
    return m_name_isValid;
}

qint32 MDGetArtistAlbum_200_response_artist::getId() const {
    return m_id;
}
void MDGetArtistAlbum_200_response_artist::setId(const qint32 &id) {
    m_id = id;
    m_id_isSet = true;
}

bool MDGetArtistAlbum_200_response_artist::is_id_Set() const{
    return m_id_isSet;
}

bool MDGetArtistAlbum_200_response_artist::is_id_Valid() const{
    return m_id_isValid;
}

bool MDGetArtistAlbum_200_response_artist::isSet() const {
    bool isObjectUpdated = false;
    do {
        if (m_followed_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_album_size_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_pic_url_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_img1v1_url_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_name_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_id_isSet) {
            isObjectUpdated = true;
            break;
        }
    } while (false);
    return isObjectUpdated;
}

bool MDGetArtistAlbum_200_response_artist::isValid() const {
    // only required properties are required for the object to be considered valid
    return m_followed_isValid && m_album_size_isValid && m_pic_url_isValid && m_img1v1_url_isValid && m_name_isValid && m_id_isValid && true;
}

} // namespace MelodixAPI
