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

#include "MDSearch_200_response_result_songs_inner.h"

#include <QDebug>
#include <QJsonArray>
#include <QJsonDocument>
#include <QObject>

#include "MDHelpers.h"

namespace MelodixAPI {

MDSearch_200_response_result_songs_inner::MDSearch_200_response_result_songs_inner(QString json) {
    this->initializeModel();
    this->fromJson(json);
}

MDSearch_200_response_result_songs_inner::MDSearch_200_response_result_songs_inner() {
    this->initializeModel();
}

MDSearch_200_response_result_songs_inner::~MDSearch_200_response_result_songs_inner() {}

void MDSearch_200_response_result_songs_inner::initializeModel() {

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

    m_copyright_isSet = false;
    m_copyright_isValid = false;

    m_resource_state_isSet = false;
    m_resource_state_isValid = false;

    m_version_isSet = false;
    m_version_isValid = false;

    m_single_isSet = false;
    m_single_isValid = false;

    m_mv_isSet = false;
    m_mv_isValid = false;

    m_publish_time_isSet = false;
    m_publish_time_isValid = false;

    m_pic_isSet = false;
    m_pic_isValid = false;

    m_duration_isSet = false;
    m_duration_isValid = false;
}

void MDSearch_200_response_result_songs_inner::fromJson(QString jsonString) {
    QByteArray array(jsonString.toStdString().c_str());
    QJsonDocument doc = QJsonDocument::fromJson(array);
    QJsonObject jsonObject = doc.object();
    this->fromJsonObject(jsonObject);
}

void MDSearch_200_response_result_songs_inner::fromJsonObject(QJsonObject json) {

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

    m_copyright_isValid = ::MelodixAPI::fromJsonValue(m_copyright, json[QString("copyright")]);
    m_copyright_isSet = !json[QString("copyright")].isNull() && m_copyright_isValid;

    m_resource_state_isValid = ::MelodixAPI::fromJsonValue(m_resource_state, json[QString("resourceState")]);
    m_resource_state_isSet = !json[QString("resourceState")].isNull() && m_resource_state_isValid;

    m_version_isValid = ::MelodixAPI::fromJsonValue(m_version, json[QString("version")]);
    m_version_isSet = !json[QString("version")].isNull() && m_version_isValid;

    m_single_isValid = ::MelodixAPI::fromJsonValue(m_single, json[QString("single")]);
    m_single_isSet = !json[QString("single")].isNull() && m_single_isValid;

    m_mv_isValid = ::MelodixAPI::fromJsonValue(m_mv, json[QString("mv")]);
    m_mv_isSet = !json[QString("mv")].isNull() && m_mv_isValid;

    m_publish_time_isValid = ::MelodixAPI::fromJsonValue(m_publish_time, json[QString("publishTime")]);
    m_publish_time_isSet = !json[QString("publishTime")].isNull() && m_publish_time_isValid;

    m_pic_isValid = ::MelodixAPI::fromJsonValue(m_pic, json[QString("pic")]);
    m_pic_isSet = !json[QString("pic")].isNull() && m_pic_isValid;

    m_duration_isValid = ::MelodixAPI::fromJsonValue(m_duration, json[QString("duration")]);
    m_duration_isSet = !json[QString("duration")].isNull() && m_duration_isValid;
}

QString MDSearch_200_response_result_songs_inner::asJson() const {
    QJsonObject obj = this->asJsonObject();
    QJsonDocument doc(obj);
    QByteArray bytes = doc.toJson();
    return QString(bytes);
}

QJsonObject MDSearch_200_response_result_songs_inner::asJsonObject() const {
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
    if (m_al_isSet) {
        obj.insert(QString("al"), ::MelodixAPI::toJsonValue(m_al));
    }
    if (m_dt_isSet) {
        obj.insert(QString("dt"), ::MelodixAPI::toJsonValue(m_dt));
    }
    if (m_copyright_isSet) {
        obj.insert(QString("copyright"), ::MelodixAPI::toJsonValue(m_copyright));
    }
    if (m_resource_state_isSet) {
        obj.insert(QString("resourceState"), ::MelodixAPI::toJsonValue(m_resource_state));
    }
    if (m_version_isSet) {
        obj.insert(QString("version"), ::MelodixAPI::toJsonValue(m_version));
    }
    if (m_single_isSet) {
        obj.insert(QString("single"), ::MelodixAPI::toJsonValue(m_single));
    }
    if (m_mv_isSet) {
        obj.insert(QString("mv"), ::MelodixAPI::toJsonValue(m_mv));
    }
    if (m_publish_time_isSet) {
        obj.insert(QString("publishTime"), ::MelodixAPI::toJsonValue(m_publish_time));
    }
    if (m_pic_isSet) {
        obj.insert(QString("pic"), ::MelodixAPI::toJsonValue(m_pic));
    }
    if (m_duration_isSet) {
        obj.insert(QString("duration"), ::MelodixAPI::toJsonValue(m_duration));
    }
    return obj;
}

QString MDSearch_200_response_result_songs_inner::getName() const {
    return m_name;
}
void MDSearch_200_response_result_songs_inner::setName(const QString &name) {
    m_name = name;
    m_name_isSet = true;
}

bool MDSearch_200_response_result_songs_inner::is_name_Set() const{
    return m_name_isSet;
}

bool MDSearch_200_response_result_songs_inner::is_name_Valid() const{
    return m_name_isValid;
}

QString MDSearch_200_response_result_songs_inner::getId() const {
    return m_id;
}
void MDSearch_200_response_result_songs_inner::setId(const QString &id) {
    m_id = id;
    m_id_isSet = true;
}

bool MDSearch_200_response_result_songs_inner::is_id_Set() const{
    return m_id_isSet;
}

bool MDSearch_200_response_result_songs_inner::is_id_Valid() const{
    return m_id_isValid;
}

QList<MDSearch_200_response_result_songs_inner_ar_inner> MDSearch_200_response_result_songs_inner::getAr() const {
    return m_ar;
}
void MDSearch_200_response_result_songs_inner::setAr(const QList<MDSearch_200_response_result_songs_inner_ar_inner> &ar) {
    m_ar = ar;
    m_ar_isSet = true;
}

bool MDSearch_200_response_result_songs_inner::is_ar_Set() const{
    return m_ar_isSet;
}

bool MDSearch_200_response_result_songs_inner::is_ar_Valid() const{
    return m_ar_isValid;
}

QString MDSearch_200_response_result_songs_inner::getAl() const {
    return m_al;
}
void MDSearch_200_response_result_songs_inner::setAl(const QString &al) {
    m_al = al;
    m_al_isSet = true;
}

bool MDSearch_200_response_result_songs_inner::is_al_Set() const{
    return m_al_isSet;
}

bool MDSearch_200_response_result_songs_inner::is_al_Valid() const{
    return m_al_isValid;
}

qint32 MDSearch_200_response_result_songs_inner::getDt() const {
    return m_dt;
}
void MDSearch_200_response_result_songs_inner::setDt(const qint32 &dt) {
    m_dt = dt;
    m_dt_isSet = true;
}

bool MDSearch_200_response_result_songs_inner::is_dt_Set() const{
    return m_dt_isSet;
}

bool MDSearch_200_response_result_songs_inner::is_dt_Valid() const{
    return m_dt_isValid;
}

qint32 MDSearch_200_response_result_songs_inner::getCopyright() const {
    return m_copyright;
}
void MDSearch_200_response_result_songs_inner::setCopyright(const qint32 &copyright) {
    m_copyright = copyright;
    m_copyright_isSet = true;
}

bool MDSearch_200_response_result_songs_inner::is_copyright_Set() const{
    return m_copyright_isSet;
}

bool MDSearch_200_response_result_songs_inner::is_copyright_Valid() const{
    return m_copyright_isValid;
}

bool MDSearch_200_response_result_songs_inner::isResourceState() const {
    return m_resource_state;
}
void MDSearch_200_response_result_songs_inner::setResourceState(const bool &resource_state) {
    m_resource_state = resource_state;
    m_resource_state_isSet = true;
}

bool MDSearch_200_response_result_songs_inner::is_resource_state_Set() const{
    return m_resource_state_isSet;
}

bool MDSearch_200_response_result_songs_inner::is_resource_state_Valid() const{
    return m_resource_state_isValid;
}

qint32 MDSearch_200_response_result_songs_inner::getVersion() const {
    return m_version;
}
void MDSearch_200_response_result_songs_inner::setVersion(const qint32 &version) {
    m_version = version;
    m_version_isSet = true;
}

bool MDSearch_200_response_result_songs_inner::is_version_Set() const{
    return m_version_isSet;
}

bool MDSearch_200_response_result_songs_inner::is_version_Valid() const{
    return m_version_isValid;
}

qint32 MDSearch_200_response_result_songs_inner::getSingle() const {
    return m_single;
}
void MDSearch_200_response_result_songs_inner::setSingle(const qint32 &single) {
    m_single = single;
    m_single_isSet = true;
}

bool MDSearch_200_response_result_songs_inner::is_single_Set() const{
    return m_single_isSet;
}

bool MDSearch_200_response_result_songs_inner::is_single_Valid() const{
    return m_single_isValid;
}

qint32 MDSearch_200_response_result_songs_inner::getMv() const {
    return m_mv;
}
void MDSearch_200_response_result_songs_inner::setMv(const qint32 &mv) {
    m_mv = mv;
    m_mv_isSet = true;
}

bool MDSearch_200_response_result_songs_inner::is_mv_Set() const{
    return m_mv_isSet;
}

bool MDSearch_200_response_result_songs_inner::is_mv_Valid() const{
    return m_mv_isValid;
}

qint32 MDSearch_200_response_result_songs_inner::getPublishTime() const {
    return m_publish_time;
}
void MDSearch_200_response_result_songs_inner::setPublishTime(const qint32 &publish_time) {
    m_publish_time = publish_time;
    m_publish_time_isSet = true;
}

bool MDSearch_200_response_result_songs_inner::is_publish_time_Set() const{
    return m_publish_time_isSet;
}

bool MDSearch_200_response_result_songs_inner::is_publish_time_Valid() const{
    return m_publish_time_isValid;
}

QString MDSearch_200_response_result_songs_inner::getPic() const {
    return m_pic;
}
void MDSearch_200_response_result_songs_inner::setPic(const QString &pic) {
    m_pic = pic;
    m_pic_isSet = true;
}

bool MDSearch_200_response_result_songs_inner::is_pic_Set() const{
    return m_pic_isSet;
}

bool MDSearch_200_response_result_songs_inner::is_pic_Valid() const{
    return m_pic_isValid;
}

qint32 MDSearch_200_response_result_songs_inner::getDuration() const {
    return m_duration;
}
void MDSearch_200_response_result_songs_inner::setDuration(const qint32 &duration) {
    m_duration = duration;
    m_duration_isSet = true;
}

bool MDSearch_200_response_result_songs_inner::is_duration_Set() const{
    return m_duration_isSet;
}

bool MDSearch_200_response_result_songs_inner::is_duration_Valid() const{
    return m_duration_isValid;
}

bool MDSearch_200_response_result_songs_inner::isSet() const {
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

        if (m_al_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_dt_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_copyright_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_resource_state_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_version_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_single_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_mv_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_publish_time_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_pic_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_duration_isSet) {
            isObjectUpdated = true;
            break;
        }
    } while (false);
    return isObjectUpdated;
}

bool MDSearch_200_response_result_songs_inner::isValid() const {
    // only required properties are required for the object to be considered valid
    return m_name_isValid && m_id_isValid && m_ar_isValid && m_al_isValid && m_dt_isValid && m_copyright_isValid && m_resource_state_isValid && m_version_isValid && m_single_isValid && m_mv_isValid && m_publish_time_isValid && m_pic_isValid && m_duration_isValid && true;
}

} // namespace MelodixAPI
