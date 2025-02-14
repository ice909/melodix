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

#include "MDGetSongDetail_200_response_songs_inner.h"

#include <QDebug>
#include <QJsonArray>
#include <QJsonDocument>
#include <QObject>

#include "MDHelpers.h"

namespace MelodixAPI {

MDGetSongDetail_200_response_songs_inner::MDGetSongDetail_200_response_songs_inner(QString json) {
    this->initializeModel();
    this->fromJson(json);
}

MDGetSongDetail_200_response_songs_inner::MDGetSongDetail_200_response_songs_inner() {
    this->initializeModel();
}

MDGetSongDetail_200_response_songs_inner::~MDGetSongDetail_200_response_songs_inner() {}

void MDGetSongDetail_200_response_songs_inner::initializeModel() {

    m_name_isSet = false;
    m_name_isValid = false;

    m_id_isSet = false;
    m_id_isValid = false;

    m_ar_isSet = false;
    m_ar_isValid = false;

    m_al_isSet = false;
    m_al_isValid = false;

    m_dt_isSet = false;
    m_dt_isValid = false;

    m_publish_time_isSet = false;
    m_publish_time_isValid = false;
}

void MDGetSongDetail_200_response_songs_inner::fromJson(QString jsonString) {
    QByteArray array(jsonString.toStdString().c_str());
    QJsonDocument doc = QJsonDocument::fromJson(array);
    QJsonObject jsonObject = doc.object();
    this->fromJsonObject(jsonObject);
}

void MDGetSongDetail_200_response_songs_inner::fromJsonObject(QJsonObject json) {

    m_name_isValid = ::MelodixAPI::fromJsonValue(m_name, json[QString("name")]);
    m_name_isSet = !json[QString("name")].isNull() && m_name_isValid;

    m_id_isValid = ::MelodixAPI::fromJsonValue(m_id, json[QString("id")]);
    m_id_isSet = !json[QString("id")].isNull() && m_id_isValid;

    m_ar_isValid = ::MelodixAPI::fromJsonValue(m_ar, json[QString("ar")]);
    m_ar_isSet = !json[QString("ar")].isNull() && m_ar_isValid;

    m_al_isValid = ::MelodixAPI::fromJsonValue(m_al, json[QString("al")]);
    m_al_isSet = !json[QString("al")].isNull() && m_al_isValid;

    m_dt_isValid = ::MelodixAPI::fromJsonValue(m_dt, json[QString("dt")]);
    m_dt_isSet = !json[QString("dt")].isNull() && m_dt_isValid;

    m_publish_time_isValid = ::MelodixAPI::fromJsonValue(m_publish_time, json[QString("publishTime")]);
    m_publish_time_isSet = !json[QString("publishTime")].isNull() && m_publish_time_isValid;
}

QString MDGetSongDetail_200_response_songs_inner::asJson() const {
    QJsonObject obj = this->asJsonObject();
    QJsonDocument doc(obj);
    QByteArray bytes = doc.toJson();
    return QString(bytes);
}

QJsonObject MDGetSongDetail_200_response_songs_inner::asJsonObject() const {
    QJsonObject obj;
    if (m_name_isSet) {
        obj.insert(QString("name"), ::MelodixAPI::toJsonValue(m_name));
    }
    if (m_id_isSet) {
        obj.insert(QString("id"), ::MelodixAPI::toJsonValue(m_id));
    }
    if (m_ar.size() > 0) {
        obj.insert(QString("ar"), ::MelodixAPI::toJsonValue(m_ar));
    }
    if (m_al.isSet()) {
        obj.insert(QString("al"), ::MelodixAPI::toJsonValue(m_al));
    }
    if (m_dt_isSet) {
        obj.insert(QString("dt"), ::MelodixAPI::toJsonValue(m_dt));
    }
    if (m_publish_time_isSet) {
        obj.insert(QString("publishTime"), ::MelodixAPI::toJsonValue(m_publish_time));
    }
    return obj;
}

QString MDGetSongDetail_200_response_songs_inner::getName() const {
    return m_name;
}
void MDGetSongDetail_200_response_songs_inner::setName(const QString &name) {
    m_name = name;
    m_name_isSet = true;
}

bool MDGetSongDetail_200_response_songs_inner::is_name_Set() const{
    return m_name_isSet;
}

bool MDGetSongDetail_200_response_songs_inner::is_name_Valid() const{
    return m_name_isValid;
}

qint32 MDGetSongDetail_200_response_songs_inner::getId() const {
    return m_id;
}
void MDGetSongDetail_200_response_songs_inner::setId(const qint32 &id) {
    m_id = id;
    m_id_isSet = true;
}

bool MDGetSongDetail_200_response_songs_inner::is_id_Set() const{
    return m_id_isSet;
}

bool MDGetSongDetail_200_response_songs_inner::is_id_Valid() const{
    return m_id_isValid;
}

QList<MDGetSongDetail_200_response_songs_inner_ar_inner> MDGetSongDetail_200_response_songs_inner::getAr() const {
    return m_ar;
}
void MDGetSongDetail_200_response_songs_inner::setAr(const QList<MDGetSongDetail_200_response_songs_inner_ar_inner> &ar) {
    m_ar = ar;
    m_ar_isSet = true;
}

bool MDGetSongDetail_200_response_songs_inner::is_ar_Set() const{
    return m_ar_isSet;
}

bool MDGetSongDetail_200_response_songs_inner::is_ar_Valid() const{
    return m_ar_isValid;
}

MDGetSongDetail_200_response_songs_inner_al MDGetSongDetail_200_response_songs_inner::getAl() const {
    return m_al;
}
void MDGetSongDetail_200_response_songs_inner::setAl(const MDGetSongDetail_200_response_songs_inner_al &al) {
    m_al = al;
    m_al_isSet = true;
}

bool MDGetSongDetail_200_response_songs_inner::is_al_Set() const{
    return m_al_isSet;
}

bool MDGetSongDetail_200_response_songs_inner::is_al_Valid() const{
    return m_al_isValid;
}

qint32 MDGetSongDetail_200_response_songs_inner::getDt() const {
    return m_dt;
}
void MDGetSongDetail_200_response_songs_inner::setDt(const qint32 &dt) {
    m_dt = dt;
    m_dt_isSet = true;
}

bool MDGetSongDetail_200_response_songs_inner::is_dt_Set() const{
    return m_dt_isSet;
}

bool MDGetSongDetail_200_response_songs_inner::is_dt_Valid() const{
    return m_dt_isValid;
}

qint32 MDGetSongDetail_200_response_songs_inner::getPublishTime() const {
    return m_publish_time;
}
void MDGetSongDetail_200_response_songs_inner::setPublishTime(const qint32 &publish_time) {
    m_publish_time = publish_time;
    m_publish_time_isSet = true;
}

bool MDGetSongDetail_200_response_songs_inner::is_publish_time_Set() const{
    return m_publish_time_isSet;
}

bool MDGetSongDetail_200_response_songs_inner::is_publish_time_Valid() const{
    return m_publish_time_isValid;
}

bool MDGetSongDetail_200_response_songs_inner::isSet() const {
    bool isObjectUpdated = false;
    do {
        if (m_name_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_id_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_ar.size() > 0) {
            isObjectUpdated = true;
            break;
        }

        if (m_al.isSet()) {
            isObjectUpdated = true;
            break;
        }

        if (m_dt_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_publish_time_isSet) {
            isObjectUpdated = true;
            break;
        }
    } while (false);
    return isObjectUpdated;
}

bool MDGetSongDetail_200_response_songs_inner::isValid() const {
    // only required properties are required for the object to be considered valid
    return true;
}

} // namespace MelodixAPI
