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

#include "MDUpdateUserInfo_200_response.h"

#include <QDebug>
#include <QJsonArray>
#include <QJsonDocument>
#include <QObject>

#include "MDHelpers.h"

namespace MelodixAPI {

MDUpdateUserInfo_200_response::MDUpdateUserInfo_200_response(QString json) {
    this->initializeModel();
    this->fromJson(json);
}

MDUpdateUserInfo_200_response::MDUpdateUserInfo_200_response() {
    this->initializeModel();
}

MDUpdateUserInfo_200_response::~MDUpdateUserInfo_200_response() {}

void MDUpdateUserInfo_200_response::initializeModel() {

    m_code_isSet = false;
    m_code_isValid = false;
}

void MDUpdateUserInfo_200_response::fromJson(QString jsonString) {
    QByteArray array(jsonString.toStdString().c_str());
    QJsonDocument doc = QJsonDocument::fromJson(array);
    QJsonObject jsonObject = doc.object();
    this->fromJsonObject(jsonObject);
}

void MDUpdateUserInfo_200_response::fromJsonObject(QJsonObject json) {

    m_code_isValid = ::MelodixAPI::fromJsonValue(m_code, json[QString("code")]);
    m_code_isSet = !json[QString("code")].isNull() && m_code_isValid;
}

QString MDUpdateUserInfo_200_response::asJson() const {
    QJsonObject obj = this->asJsonObject();
    QJsonDocument doc(obj);
    QByteArray bytes = doc.toJson();
    return QString(bytes);
}

QJsonObject MDUpdateUserInfo_200_response::asJsonObject() const {
    QJsonObject obj;
    if (m_code_isSet) {
        obj.insert(QString("code"), ::MelodixAPI::toJsonValue(m_code));
    }
    return obj;
}

qint32 MDUpdateUserInfo_200_response::getCode() const {
    return m_code;
}
void MDUpdateUserInfo_200_response::setCode(const qint32 &code) {
    m_code = code;
    m_code_isSet = true;
}

bool MDUpdateUserInfo_200_response::is_code_Set() const{
    return m_code_isSet;
}

bool MDUpdateUserInfo_200_response::is_code_Valid() const{
    return m_code_isValid;
}

bool MDUpdateUserInfo_200_response::isSet() const {
    bool isObjectUpdated = false;
    do {
        if (m_code_isSet) {
            isObjectUpdated = true;
            break;
        }
    } while (false);
    return isObjectUpdated;
}

bool MDUpdateUserInfo_200_response::isValid() const {
    // only required properties are required for the object to be considered valid
    return m_code_isValid && true;
}

} // namespace MelodixAPI
