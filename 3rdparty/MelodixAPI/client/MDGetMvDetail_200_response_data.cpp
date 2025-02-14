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

#include "MDGetMvDetail_200_response_data.h"

#include <QDebug>
#include <QJsonArray>
#include <QJsonDocument>
#include <QObject>

#include "MDHelpers.h"

namespace MelodixAPI {

MDGetMvDetail_200_response_data::MDGetMvDetail_200_response_data(QString json) {
    this->initializeModel();
    this->fromJson(json);
}

MDGetMvDetail_200_response_data::MDGetMvDetail_200_response_data() {
    this->initializeModel();
}

MDGetMvDetail_200_response_data::~MDGetMvDetail_200_response_data() {}

void MDGetMvDetail_200_response_data::initializeModel() {

    m_id_isSet = false;
    m_id_isValid = false;

    m_name_isSet = false;
    m_name_isValid = false;

    m_artist_id_isSet = false;
    m_artist_id_isValid = false;

    m_artist_name_isSet = false;
    m_artist_name_isValid = false;

    m_cover_isSet = false;
    m_cover_isValid = false;

    m_play_count_isSet = false;
    m_play_count_isValid = false;

    m_comment_count_isSet = false;
    m_comment_count_isValid = false;

    m_duration_isSet = false;
    m_duration_isValid = false;

    m_publish_time_isSet = false;
    m_publish_time_isValid = false;

    m_brs_isSet = false;
    m_brs_isValid = false;

    m_artists_isSet = false;
    m_artists_isValid = false;
}

void MDGetMvDetail_200_response_data::fromJson(QString jsonString) {
    QByteArray array(jsonString.toStdString().c_str());
    QJsonDocument doc = QJsonDocument::fromJson(array);
    QJsonObject jsonObject = doc.object();
    this->fromJsonObject(jsonObject);
}

void MDGetMvDetail_200_response_data::fromJsonObject(QJsonObject json) {

    m_id_isValid = ::MelodixAPI::fromJsonValue(m_id, json[QString("id")]);
    m_id_isSet = !json[QString("id")].isNull() && m_id_isValid;

    m_name_isValid = ::MelodixAPI::fromJsonValue(m_name, json[QString("name")]);
    m_name_isSet = !json[QString("name")].isNull() && m_name_isValid;

    m_artist_id_isValid = ::MelodixAPI::fromJsonValue(m_artist_id, json[QString("artistId")]);
    m_artist_id_isSet = !json[QString("artistId")].isNull() && m_artist_id_isValid;

    m_artist_name_isValid = ::MelodixAPI::fromJsonValue(m_artist_name, json[QString("artistName")]);
    m_artist_name_isSet = !json[QString("artistName")].isNull() && m_artist_name_isValid;

    m_cover_isValid = ::MelodixAPI::fromJsonValue(m_cover, json[QString("cover")]);
    m_cover_isSet = !json[QString("cover")].isNull() && m_cover_isValid;

    m_play_count_isValid = ::MelodixAPI::fromJsonValue(m_play_count, json[QString("playCount")]);
    m_play_count_isSet = !json[QString("playCount")].isNull() && m_play_count_isValid;

    m_comment_count_isValid = ::MelodixAPI::fromJsonValue(m_comment_count, json[QString("commentCount")]);
    m_comment_count_isSet = !json[QString("commentCount")].isNull() && m_comment_count_isValid;

    m_duration_isValid = ::MelodixAPI::fromJsonValue(m_duration, json[QString("duration")]);
    m_duration_isSet = !json[QString("duration")].isNull() && m_duration_isValid;

    m_publish_time_isValid = ::MelodixAPI::fromJsonValue(m_publish_time, json[QString("publishTime")]);
    m_publish_time_isSet = !json[QString("publishTime")].isNull() && m_publish_time_isValid;

    m_brs_isValid = ::MelodixAPI::fromJsonValue(m_brs, json[QString("brs")]);
    m_brs_isSet = !json[QString("brs")].isNull() && m_brs_isValid;

    m_artists_isValid = ::MelodixAPI::fromJsonValue(m_artists, json[QString("artists")]);
    m_artists_isSet = !json[QString("artists")].isNull() && m_artists_isValid;
}

QString MDGetMvDetail_200_response_data::asJson() const {
    QJsonObject obj = this->asJsonObject();
    QJsonDocument doc(obj);
    QByteArray bytes = doc.toJson();
    return QString(bytes);
}

QJsonObject MDGetMvDetail_200_response_data::asJsonObject() const {
    QJsonObject obj;
    if (m_id_isSet) {
        obj.insert(QString("id"), ::MelodixAPI::toJsonValue(m_id));
    }
    if (m_name_isSet) {
        obj.insert(QString("name"), ::MelodixAPI::toJsonValue(m_name));
    }
    if (m_artist_id_isSet) {
        obj.insert(QString("artistId"), ::MelodixAPI::toJsonValue(m_artist_id));
    }
    if (m_artist_name_isSet) {
        obj.insert(QString("artistName"), ::MelodixAPI::toJsonValue(m_artist_name));
    }
    if (m_cover_isSet) {
        obj.insert(QString("cover"), ::MelodixAPI::toJsonValue(m_cover));
    }
    if (m_play_count_isSet) {
        obj.insert(QString("playCount"), ::MelodixAPI::toJsonValue(m_play_count));
    }
    if (m_comment_count_isSet) {
        obj.insert(QString("commentCount"), ::MelodixAPI::toJsonValue(m_comment_count));
    }
    if (m_duration_isSet) {
        obj.insert(QString("duration"), ::MelodixAPI::toJsonValue(m_duration));
    }
    if (m_publish_time_isSet) {
        obj.insert(QString("publishTime"), ::MelodixAPI::toJsonValue(m_publish_time));
    }
    if (m_brs.size() > 0) {
        obj.insert(QString("brs"), ::MelodixAPI::toJsonValue(m_brs));
    }
    if (m_artists.size() > 0) {
        obj.insert(QString("artists"), ::MelodixAPI::toJsonValue(m_artists));
    }
    return obj;
}

qint32 MDGetMvDetail_200_response_data::getId() const {
    return m_id;
}
void MDGetMvDetail_200_response_data::setId(const qint32 &id) {
    m_id = id;
    m_id_isSet = true;
}

bool MDGetMvDetail_200_response_data::is_id_Set() const{
    return m_id_isSet;
}

bool MDGetMvDetail_200_response_data::is_id_Valid() const{
    return m_id_isValid;
}

QString MDGetMvDetail_200_response_data::getName() const {
    return m_name;
}
void MDGetMvDetail_200_response_data::setName(const QString &name) {
    m_name = name;
    m_name_isSet = true;
}

bool MDGetMvDetail_200_response_data::is_name_Set() const{
    return m_name_isSet;
}

bool MDGetMvDetail_200_response_data::is_name_Valid() const{
    return m_name_isValid;
}

qint32 MDGetMvDetail_200_response_data::getArtistId() const {
    return m_artist_id;
}
void MDGetMvDetail_200_response_data::setArtistId(const qint32 &artist_id) {
    m_artist_id = artist_id;
    m_artist_id_isSet = true;
}

bool MDGetMvDetail_200_response_data::is_artist_id_Set() const{
    return m_artist_id_isSet;
}

bool MDGetMvDetail_200_response_data::is_artist_id_Valid() const{
    return m_artist_id_isValid;
}

QString MDGetMvDetail_200_response_data::getArtistName() const {
    return m_artist_name;
}
void MDGetMvDetail_200_response_data::setArtistName(const QString &artist_name) {
    m_artist_name = artist_name;
    m_artist_name_isSet = true;
}

bool MDGetMvDetail_200_response_data::is_artist_name_Set() const{
    return m_artist_name_isSet;
}

bool MDGetMvDetail_200_response_data::is_artist_name_Valid() const{
    return m_artist_name_isValid;
}

QString MDGetMvDetail_200_response_data::getCover() const {
    return m_cover;
}
void MDGetMvDetail_200_response_data::setCover(const QString &cover) {
    m_cover = cover;
    m_cover_isSet = true;
}

bool MDGetMvDetail_200_response_data::is_cover_Set() const{
    return m_cover_isSet;
}

bool MDGetMvDetail_200_response_data::is_cover_Valid() const{
    return m_cover_isValid;
}

qint32 MDGetMvDetail_200_response_data::getPlayCount() const {
    return m_play_count;
}
void MDGetMvDetail_200_response_data::setPlayCount(const qint32 &play_count) {
    m_play_count = play_count;
    m_play_count_isSet = true;
}

bool MDGetMvDetail_200_response_data::is_play_count_Set() const{
    return m_play_count_isSet;
}

bool MDGetMvDetail_200_response_data::is_play_count_Valid() const{
    return m_play_count_isValid;
}

qint32 MDGetMvDetail_200_response_data::getCommentCount() const {
    return m_comment_count;
}
void MDGetMvDetail_200_response_data::setCommentCount(const qint32 &comment_count) {
    m_comment_count = comment_count;
    m_comment_count_isSet = true;
}

bool MDGetMvDetail_200_response_data::is_comment_count_Set() const{
    return m_comment_count_isSet;
}

bool MDGetMvDetail_200_response_data::is_comment_count_Valid() const{
    return m_comment_count_isValid;
}

qint32 MDGetMvDetail_200_response_data::getDuration() const {
    return m_duration;
}
void MDGetMvDetail_200_response_data::setDuration(const qint32 &duration) {
    m_duration = duration;
    m_duration_isSet = true;
}

bool MDGetMvDetail_200_response_data::is_duration_Set() const{
    return m_duration_isSet;
}

bool MDGetMvDetail_200_response_data::is_duration_Valid() const{
    return m_duration_isValid;
}

QString MDGetMvDetail_200_response_data::getPublishTime() const {
    return m_publish_time;
}
void MDGetMvDetail_200_response_data::setPublishTime(const QString &publish_time) {
    m_publish_time = publish_time;
    m_publish_time_isSet = true;
}

bool MDGetMvDetail_200_response_data::is_publish_time_Set() const{
    return m_publish_time_isSet;
}

bool MDGetMvDetail_200_response_data::is_publish_time_Valid() const{
    return m_publish_time_isValid;
}

QList<MDGetMvDetail_200_response_data_brs_inner> MDGetMvDetail_200_response_data::getBrs() const {
    return m_brs;
}
void MDGetMvDetail_200_response_data::setBrs(const QList<MDGetMvDetail_200_response_data_brs_inner> &brs) {
    m_brs = brs;
    m_brs_isSet = true;
}

bool MDGetMvDetail_200_response_data::is_brs_Set() const{
    return m_brs_isSet;
}

bool MDGetMvDetail_200_response_data::is_brs_Valid() const{
    return m_brs_isValid;
}

QList<MDGetMvDetail_200_response_data_artists_inner> MDGetMvDetail_200_response_data::getArtists() const {
    return m_artists;
}
void MDGetMvDetail_200_response_data::setArtists(const QList<MDGetMvDetail_200_response_data_artists_inner> &artists) {
    m_artists = artists;
    m_artists_isSet = true;
}

bool MDGetMvDetail_200_response_data::is_artists_Set() const{
    return m_artists_isSet;
}

bool MDGetMvDetail_200_response_data::is_artists_Valid() const{
    return m_artists_isValid;
}

bool MDGetMvDetail_200_response_data::isSet() const {
    bool isObjectUpdated = false;
    do {
        if (m_id_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_name_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_artist_id_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_artist_name_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_cover_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_play_count_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_comment_count_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_duration_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_publish_time_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_brs.size() > 0) {
            isObjectUpdated = true;
            break;
        }

        if (m_artists.size() > 0) {
            isObjectUpdated = true;
            break;
        }
    } while (false);
    return isObjectUpdated;
}

bool MDGetMvDetail_200_response_data::isValid() const {
    // only required properties are required for the object to be considered valid
    return m_id_isValid && m_name_isValid && m_artist_id_isValid && m_artist_name_isValid && m_cover_isValid && m_play_count_isValid && m_comment_count_isValid && m_duration_isValid && m_publish_time_isValid && m_brs_isValid && m_artists_isValid && true;
}

} // namespace MelodixAPI
