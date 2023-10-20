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

#include "MDGetUserDetail_200_response_expertArray_inner.h"

#include <QDebug>
#include <QJsonArray>
#include <QJsonDocument>
#include <QObject>

#include "MDHelpers.h"

namespace MelodixAPI {

MDGetUserDetail_200_response_expertArray_inner::MDGetUserDetail_200_response_expertArray_inner(QString json) {
    this->initializeModel();
    this->fromJson(json);
}

MDGetUserDetail_200_response_expertArray_inner::MDGetUserDetail_200_response_expertArray_inner() {
    this->initializeModel();
}

MDGetUserDetail_200_response_expertArray_inner::~MDGetUserDetail_200_response_expertArray_inner() {}

void MDGetUserDetail_200_response_expertArray_inner::initializeModel() {

    m_role_id_isSet = false;
    m_role_id_isValid = false;

    m_role_name_isSet = false;
    m_role_name_isValid = false;
}

void MDGetUserDetail_200_response_expertArray_inner::fromJson(QString jsonString) {
    QByteArray array(jsonString.toStdString().c_str());
    QJsonDocument doc = QJsonDocument::fromJson(array);
    QJsonObject jsonObject = doc.object();
    this->fromJsonObject(jsonObject);
}

void MDGetUserDetail_200_response_expertArray_inner::fromJsonObject(QJsonObject json) {

    m_role_id_isValid = ::MelodixAPI::fromJsonValue(m_role_id, json[QString("roleId")]);
    m_role_id_isSet = !json[QString("roleId")].isNull() && m_role_id_isValid;

    m_role_name_isValid = ::MelodixAPI::fromJsonValue(m_role_name, json[QString("roleName")]);
    m_role_name_isSet = !json[QString("roleName")].isNull() && m_role_name_isValid;
}

QString MDGetUserDetail_200_response_expertArray_inner::asJson() const {
    QJsonObject obj = this->asJsonObject();
    QJsonDocument doc(obj);
    QByteArray bytes = doc.toJson();
    return QString(bytes);
}

QJsonObject MDGetUserDetail_200_response_expertArray_inner::asJsonObject() const {
    QJsonObject obj;
    if (m_role_id_isSet) {
        obj.insert(QString("roleId"), ::MelodixAPI::toJsonValue(m_role_id));
    }
    if (m_role_name_isSet) {
        obj.insert(QString("roleName"), ::MelodixAPI::toJsonValue(m_role_name));
    }
    return obj;
}

qint32 MDGetUserDetail_200_response_expertArray_inner::getRoleId() const {
    return m_role_id;
}
void MDGetUserDetail_200_response_expertArray_inner::setRoleId(const qint32 &role_id) {
    m_role_id = role_id;
    m_role_id_isSet = true;
}

bool MDGetUserDetail_200_response_expertArray_inner::is_role_id_Set() const{
    return m_role_id_isSet;
}

bool MDGetUserDetail_200_response_expertArray_inner::is_role_id_Valid() const{
    return m_role_id_isValid;
}

QString MDGetUserDetail_200_response_expertArray_inner::getRoleName() const {
    return m_role_name;
}
void MDGetUserDetail_200_response_expertArray_inner::setRoleName(const QString &role_name) {
    m_role_name = role_name;
    m_role_name_isSet = true;
}

bool MDGetUserDetail_200_response_expertArray_inner::is_role_name_Set() const{
    return m_role_name_isSet;
}

bool MDGetUserDetail_200_response_expertArray_inner::is_role_name_Valid() const{
    return m_role_name_isValid;
}

bool MDGetUserDetail_200_response_expertArray_inner::isSet() const {
    bool isObjectUpdated = false;
    do {
        if (m_role_id_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_role_name_isSet) {
            isObjectUpdated = true;
            break;
        }
    } while (false);
    return isObjectUpdated;
}

bool MDGetUserDetail_200_response_expertArray_inner::isValid() const {
    // only required properties are required for the object to be considered valid
    return true;
}

} // namespace MelodixAPI
