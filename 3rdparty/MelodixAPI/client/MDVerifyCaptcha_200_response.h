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
 * MDVerifyCaptcha_200_response.h
 *
 * 
 */

#ifndef MDVerifyCaptcha_200_response_H
#define MDVerifyCaptcha_200_response_H

#include <QJsonObject>


#include "MDEnum.h"
#include "MDObject.h"

namespace MelodixAPI {

class MDVerifyCaptcha_200_response : public MDObject {
public:
    MDVerifyCaptcha_200_response();
    MDVerifyCaptcha_200_response(QString json);
    ~MDVerifyCaptcha_200_response() override;

    QString asJson() const override;
    QJsonObject asJsonObject() const override;
    void fromJsonObject(QJsonObject json) override;
    void fromJson(QString jsonString) override;

    qint32 getCode() const;
    void setCode(const qint32 &code);
    bool is_code_Set() const;
    bool is_code_Valid() const;

    bool isData() const;
    void setData(const bool &data);
    bool is_data_Set() const;
    bool is_data_Valid() const;

    virtual bool isSet() const override;
    virtual bool isValid() const override;

private:
    void initializeModel();

    qint32 m_code;
    bool m_code_isSet;
    bool m_code_isValid;

    bool m_data;
    bool m_data_isSet;
    bool m_data_isValid;
};

} // namespace MelodixAPI

Q_DECLARE_METATYPE(MelodixAPI::MDVerifyCaptcha_200_response)

#endif // MDVerifyCaptcha_200_response_H
